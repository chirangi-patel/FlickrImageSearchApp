//
//  ImageViewCell.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet weak var imageBackgroundView: UIView!
    
    var imageValue: ImageModel? {
        didSet {
            guard let feeds = imageValue else {
                return
            }
            titleLabel?.text = feeds.title
            ImageManager.sharedInstance.downloadImageFromURL(feeds.flickrImageURL() ?? "") { (success, image) -> Void in
                if success && image != nil {
                    self.imageView?.image = image
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageBackgroundView?.backgroundColor = ThemeColor.white
        self.imageView?.contentMode =   UIView.ContentMode.scaleAspectFit
    }
}
