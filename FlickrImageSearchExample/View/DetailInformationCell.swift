//
//  DetailInformationCell.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import UIKit

class DetailInformationCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var detailLabel: UILabel?

    var dataValue: DetailModel? {
        didSet {
            guard let data = dataValue else {
                return
            }
            titleLabel?.text = data.title
            detailLabel?.text = data.description
        }
    }

}
