//
//  ProductRepository.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/28.
//

import Foundation

import RealmSwift

protocol UserDiaryRepositoryType {
    // Create
    func addItem(item: Product)
    
    // Read
    func fetch() -> Results<Product>
    func fetchSort(_ sort: String) -> Results<Product>
    func fetchFilter() -> Results<Product>
    
    // Update
    func updateCheck(item: Product)
    
    // Delete
    func deleteItem(item: Product)
}

class ProductRepository: UserDiaryRepositoryType {
    
    // local Realm 생성
    let localRealm = try! Realm()
    
    // 데이터 추가
    func addItem(item: Product) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch let error {
            print(error)
        }
    }
    
    // 데이터 읽기
    func fetch() -> Results<Product> {
        return localRealm.objects(Product.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    // 키워드 정렬
    func fetchSort(_ sort: String) -> Results<Product> {
        return localRealm.objects(Product.self).sorted(byKeyPath: "\(sort)", ascending: false)
    }
    
    // 체크 유무 필터 
    func fetchFilter() -> Results<Product> {
        return localRealm.objects(Product.self).filter("check == true")
    }
    
    // 체크 업데이트
    func updateCheck(item: Product) {
        do {
            try localRealm.write {
                item.check.toggle()
            }
        } catch let error {
            print(error)
        }
    }
    
    // 삭제
    func deleteItem(item: Product) {
        do {
            try localRealm.write {
                removeImageFromDocument(fileName: "\(item.objectId).jpg")
                localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
}

extension ProductRepository {
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
}
