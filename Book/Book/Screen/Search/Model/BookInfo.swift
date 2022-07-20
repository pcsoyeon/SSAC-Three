//
//  SearchModel.swift
//  Book
//
//  Created by 소연 on 2022/07/20.
//

import UIKit

struct Book {
    var backgroundColor: UIColor?
    var title: String
    var author: String
    var cover: String
}

struct BookInfo {
    let book: [Book] = [
        Book(backgroundColor: .systemPink, title: "백설공주", author: "양수빈", cover: "7번방의선물"),
        Book(backgroundColor: .systemCyan, title: "신데렐라", author: "김후리", cover: "광해"),
        Book(backgroundColor: .systemBrown, title: "잠자는 숲속의 공주", author: "김민지", cover: "명량"),
        Book(backgroundColor: .systemYellow, title: "채식주의자", author: "최유리", cover: "왕의남자"),
        Book(backgroundColor: .systemBlue, title: "1987", author: "박정훈", cover: "태극기휘날리며"),
        Book(backgroundColor: .systemGray, title: "데미안", author: "임하연", cover: "알라딘"),
        Book(backgroundColor: .systemPurple, title: "노르웨이 숲", author: "최이준", cover: "부산행"),
        Book(backgroundColor: .systemOrange, title: "인간실격", author: "이경민", cover: "극한직업")
    ]
}
