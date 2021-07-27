//
//  DetailViewCell.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import UIKit

class DetailViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var photoImageView: UIImageView?

    var dataValue: DetailModel? {
        didSet {
            guard let data = dataValue else {
                return
            }
            titleLabel?.text = data.title
            if let imageUrl = data.description {
                ImageManager.sharedInstance.downloadImageFromURL(imageUrl) { (success, image) -> Void in
                    if success && image != nil {
                        self.photoImageView?.image = image
                    }
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.photoImageView?.contentMode =   UIView.ContentMode.scaleAspectFit
    }
}
