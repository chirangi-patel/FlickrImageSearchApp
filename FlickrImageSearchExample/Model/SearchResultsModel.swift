//
//  SearchResultsModel.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation

struct SearchResultsModel: Codable {
    var stat: String?
    var photos: ResultsModel?
}

extension SearchResultsModel: Parceable {
    static func parseObject(data: Data) -> Result<SearchResultsModel, ErrorResult> {
        let decoder = JSONDecoder()
        if let result = try? decoder.decode(SearchResultsModel.self, from: data) {
            return Result.success(result)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse flickr results"))
        }
    }
}
