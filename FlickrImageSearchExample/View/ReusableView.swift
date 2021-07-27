//
//  ReusableView.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self) + "Identifier"
    }
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


extension UICollectionViewCell: ReusableView { }
extension UITableViewCell: ReusableView { }
