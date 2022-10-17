//
//  Todo.swift
//  FirebaseExample
//
//  Created by 소연 on 2022/10/13.
//

import Foundation

import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var importance: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, importance: Int) {
        self.init()
        self.title = title
        self.importance = importance
    }
}
