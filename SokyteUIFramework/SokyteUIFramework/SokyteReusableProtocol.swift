//
//  SokyteReusableProtocol.swift
//  SokyteUIFramework
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

// open VS public
// 상속이 가능한가? -> 클래스에만 open 사용 가능

public protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
