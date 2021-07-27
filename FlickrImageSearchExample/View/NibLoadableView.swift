//
//  NibLoadableView.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import UIKit

protocol NibLoadableView: AnyObject { }

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }

}

extension UITableViewCell: NibLoadableView { }
