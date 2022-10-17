//
//  MigrationViewController.swift
//  FirebaseExample
//
//  Created by 소연 on 2022/10/13.
//

import UIKit

import RealmSwift

class MigrationViewController: UIViewController {
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. fileURL
        print("FileURL: \(localRealm.configuration.fileURL)")
        
        // 2. Schema Version
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
        
        // 3. Test
//        for i in 1...100 {
//            let task = Todo(title: "소깡이 할 일 \(i)", importance: Int.random(in: 1...5))
//
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//        }
        
//        for i in 1...10 {
//            let task = DetailTodo(detailTitle: "127 앨범깡 \(i)개 ", favorite: true)
//
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//        }
        
        // 특정 Todo 테이블에 Detail Todo 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '소깡이 할 일 7'")
//            .first else { return }
//
//        let detail = DetailTodo(detailTitle: "포카 교환하기", favorite: false)
//
//        try! localRealm.write {
//            task.detail.append(detail)
//        }
        
        // 특정 Todo 테이블에 Detail Todo 여러개 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '소깡이 할 일 2'")
//            .first else { return }
//
//        let detail = DetailTodo(detailTitle: "도영이 포카 \(Int.random(in: 1...5))개 보관하기", favorite: false)
//
//        for _ in 1...10 {
//            try! localRealm.write {
//                task.detail.append(detail)
//            }
//        }
        
        // 특정 Todo 테이블  삭제
//        guard let task = localRealm.objects(Todo.self).filter("title = '소깡이 할 일 2'").first else { return }
//
//        try! localRealm.write {
//            localRealm.delete(task.detail)
//            localRealm.delete(task)
//        }
        
        // 특정 Todo에 메모 추가
        guard let task = localRealm.objects(Todo.self).filter("title = '소깡이 할 일 1'").first else { return }
        
        let memo = Memo()
        memo.content = "제발 도영이가 나오게 해주세요 🙏🏻"
        memo.date = Date()
        
        try! localRealm.write {
            task.memo = memo
        }
    }
}
