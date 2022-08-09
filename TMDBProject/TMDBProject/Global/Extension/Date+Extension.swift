//
//  Date+Extension.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/03.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
