//
//  ProductViewController.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/23.
//

import UIKit
import PhotosUI

import RealmSwift
import SnapKit

class ProductViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 8
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter
    }()
    
    // MARK: - Property
    
    var task: Product? {
        didSet {
            label.text = task?.name
            dateLabel.text = dateFormatter.string(from: task?.date ?? Date())
        }
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
    }
    
    // MARK: - UI Method
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(touchUpSaveButton))
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureImageView()
        configureNavigationBar()
    }
    
    private func setConstraints() {
        [label, dateLabel, productImageView].forEach {
            view.addSubview($0)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(28)
            make.top.equalTo(productImageView.snp.bottom).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func configureImageView() {
        guard let task = task else { return }
        productImageView.image = loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        productImageView.addGestureRecognizer(tapGesture)
    }
    
    private func openGallery() {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)

        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpImageView() {
        openGallery()
    }
    
    @objc func touchUpSaveButton() {
        showToast(message: "저장 완료")
        
        if let image = productImageView.image {
            guard let task = task else { return }

            saveImageToDocument(fileName: "\(task.objectId).jpg", image: image)
        }
    }
}

// MARK: - PHPicker Delegate

extension ProductViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard !results.isEmpty else {
            return
        }
        
        let imageResult = results[0]
        
        if imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) {
            imageResult.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.productImageView.image = selectedImage as? UIImage
                    }
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
}
