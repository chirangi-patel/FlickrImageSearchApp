//
//  ImageModel.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation

struct ImageModel: Codable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var ispublic: Int?
    var isfriend: Int?
    var isfamily: Int?

    func flickrImageURL(_ size: String = "m") -> String? {
        if
            let farm = self.farm,
            let server = self.server,
            let id = self.id,
            let secret = self.secret {
            let url =  "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg"
            return url
        }
        return nil
    }
}
