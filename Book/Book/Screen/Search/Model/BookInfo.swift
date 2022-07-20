//
//  SearchModel.swift
//  Book
//
//  Created by 소연 on 2022/07/20.
//

import Foundation

struct Book {
    var title: String
    var author: String
    var cover: String
}

struct BookInfo {
    let book: [Book] = [
        Book(title: "최이준바보", author: "", cover: ""),
        Book(title: "김후리방구", author: "", cover: ""),
        Book(title: "어쩌구", author: "", cover: ""),
        Book(title: "저쩌구", author: "", cover: ""),
        Book(title: "1987", author: "", cover: ""),
        Book(title: "스타벅스", author: "", cover: ""),
        Book(title: "태끼바보", author: "", cover: ""),
        Book(title: "소깡이짱", author: "", cover: "")
    ]
}
