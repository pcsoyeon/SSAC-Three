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
        
        for i in 1...10 {
            let task = DetailTodo(detailTitle: "127 앨범깡 \(i)개 ", favorite: true)

            try! localRealm.write {
                localRealm.add(task)
            }
        }
    }
}
