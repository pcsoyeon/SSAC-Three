//
//  BackUpViewController.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/26.
//

import UIKit

import SnapKit
import Zip

class BackUpViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var buttonStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.addArrangedSubview(backupButton)
        stackView.addArrangedSubview(restoreButton)
        return stackView
    }()
    
    private lazy var backupButton : UIButton = {
        let button = UIButton()
        button.setTitle("백업", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(touchUpBackUpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var restoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("복구", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(touchUpRestoreButton), for: .touchUpInside)
        return button
    }()
    
    private var listTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var progressView: BackUpProgressView = {
        let progreeView = BackUpProgressView()
        progreeView.color = .systemPink
        progreeView.isHidden = true
        return progreeView
    }()
    
    // MARK: - Property
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter
    }()
    
    private var zipList: [String] = [] {
        didSet {
            listTableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        zipList = fetchDocumentZipFile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        view.backgroundColor = .white
        configureTableView()
    }
    
    private func setConstraints() {
        [buttonStackView, listTableView, progressView].forEach {
            view.addSubview($0)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        progressView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.register(BackUpListTableViewCell.self, forCellReuseIdentifier: BackUpListTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Custom Method
    
    private func showActivityViewController() {
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("ShoppingList_\(dateFormatter.string(from: Date())).zip")
        
        let viewController = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(viewController, animated: true)
    }
    
    private func changeRootViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: ListViewController())
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    // MARK: - @objc
    
    @objc func touchUpBackUpButton() {
        var urlPaths = [URL]()
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다.")
            return
        }
        
        if let url = URL(string: realmFile.path) {
            urlPaths.append(url)
        }
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList_\(dateFormatter.string(from: Date()))")
            print("Archive Location: \(zipFilePath)")
            
            showActivityViewController()
        } catch {
            showAlertMessage(title: "압축을 실패했습니다")
        }
    }
    
    @objc func touchUpRestoreButton() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
}

// MARK: - UITableView Protocol

extension BackUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zipList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackUpListTableViewCell.reuseIdentifier, for: indexPath) as? BackUpListTableViewCell else { return UITableViewCell() }
        cell.setData(zipList[indexPath.row])
        return cell
    }
}

// MARK: - UIDocumentPickerView Protocol

extension BackUpViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            let fileURL = sandboxFileURL
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    self.progressView.isHidden = false
                    self.progressView.progress = progress
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.") { _ in
                        self.progressView.isHidden = true
                        self.changeRootViewController()
                    }
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
        } else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = sandboxFileURL
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.") { _ in
                        self.changeRootViewController()
                    }
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
        }
    }
}
