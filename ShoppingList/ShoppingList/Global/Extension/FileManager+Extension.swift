//
//  FileManager+Extension.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/24.
//

import UIKit

extension UIViewController {
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        let image = UIImage(contentsOfFile: fileURL.path)
        return image
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        // Document 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // Document 경로에 path를 더해서 파일 네임을 지정 > 세부 파일 경로 (이미지를 저장할 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        // 이미지 압축 > 용량 줄이기
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL) // 해당 위치에 데이터 create
        } catch let error {
            print("file save error", error)
        }
    }
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    func fetchDocumentZipFile() -> [String] {
        var zipList: [String] = [""]
        
        do {
            guard let path = documentDirectoryPath() else { return zipList }
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")

            let zip = docs.filter { $0.pathExtension == "zip" } 
            print("zip: \(zip)")
            
            zipList = zip.map { $0.lastPathComponent }
            return zipList
        } catch {
            print("ERROR")
        }
        
        return zipList
    }
}
