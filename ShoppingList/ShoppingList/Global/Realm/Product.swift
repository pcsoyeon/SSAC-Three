//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by 소연 on 2022/08/22.
//

import Foundation

import RealmSwift

class Product: Object {
    @Persisted var name: String
    @Persisted var check: Bool
    @Persisted var date: Date
    
    // PK(필수): Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(name: String, check: Bool = false, date: Date) {
        self.init()
        self.name = name
        self.check = check
        self.date = date
    }
}
