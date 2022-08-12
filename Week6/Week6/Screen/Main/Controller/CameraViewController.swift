//
//  CameraViewController.swift
//  Week6
//
//  Created by 소연 on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON
import YPImagePicker

class CameraViewController: UIViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    
    // UIImagePickerController 1.
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIImagePickerController 2.
        picker.delegate = self
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
        // 카메라를 사용할 수 있는 기기인가?
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용 불가 > 사용자에게 토스트/얼럿")
            return
        }
        picker.sourceType = .camera
        picker.allowsEditing = true // 촬영 이후, 편집을 할 수 있는지 (default : false)
        present(picker, animated: true)
    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용 불가 > 사용자에게 토스트/얼럿")
            return
        }
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true)
    }
    
    @IBAction func saveToPhotoLibrary(_ sender: UIButton) {
        // TODO: - 사진 저장 Alert
        if let image = resultImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    // 이미지 뷰 이미지 > 네이버 > 얼굴 분석 요청 > 응답
    // 문자열이 아닌 파일, 이미지 PDF 파일 자체가 그대로 전송되지 않음 => 파일을 텍스트 형태로 인코딩
    // 어떤 파일의 종류가 서버에게 전달이 되는지 명시하는 것이 필요 = Content-Type
    
    @IBAction func clovaFaceButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/vision/celebrity"
        
        let header: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "X-Naver-Client-Id" : APIKey.Naver,
            "X-Naver-Client-Secret" : APIKey.NaverSecret
        ]
        
        // UIImage > Text 형태 (바이너리 타입)로 변환해서 전달
        
//        guard let imageData = resultImageView.image?.pngData() else { return }
        guard let imageData = resultImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        
        AF.upload(multipartFormData: { multipartFormData in
            // 가이드 확인
            // 이미지 이름 : image
            multipartFormData.append(imageData, withName: "image")
        }, to: url, headers: header)
        .validate(statusCode: 200...500)
        .responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                    print("=============================== NAVER CLOVA ===============================")
                    print(json)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// UIImagePickerController 3.
// 네비게이션 컨트롤러를 상속 받고 있음 (왜 네비게이션 컨트롤러를 상속받는가?)

// MARK: - UIImagePickerController Protocol

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // UIImagePickerController 4.
    // 사진을 선택 || 카메라 촬영 직후
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        // 원본, 편집, 메타데이터 - infoKey
        // TODO: - 여러개의 infoKey를 어떻게 관리?
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            resultImageView.image = originalImage
            dismiss(animated: true)
        }
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // Any로 타입이 설정되어 있으므로 타입 캐스팅을 통해서 UIImage로 변경
            resultImageView.image = editedImage
            dismiss(animated: true)
        }
    }
    
    // UIImagePickerController 5.
    // 취소 버튼 눌렀을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}

