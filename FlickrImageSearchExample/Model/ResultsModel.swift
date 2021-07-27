//
//  ResultsModel.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation

struct ResultsModel: Codable {
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: Int?
    var photo: [ImageModel]?
}
