//
//  CameraViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/12.
//

import UIKit

import YPImagePicker

class CameraViewController: UIViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 오픈 소스 활용
    // 권한 모두 허용
    // 권한 문구 등도 내부적으로 구현 > 실제로 카메라를 쓸 때 권한 요청 
    @IBAction func YPImagePickerButtonClicked(_ sender: UIButton) {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                // 사진을 고르고 나서 아래의 코드 실행
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                self.resultImageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        
    }
}
