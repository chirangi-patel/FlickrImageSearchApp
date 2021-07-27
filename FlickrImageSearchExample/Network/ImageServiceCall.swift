//
//  ImageServiceCall.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation

protocol ImageServiceCallProtocol: AnyObject {
    func fetchPhotos(_ searchTerm: String, completion: @escaping ((Result<SearchResultsModel, ErrorResult>) -> Void))
}

final class ImageServiceCall: NetworkHandler, ImageServiceCallProtocol {
    static let shared = ImageServiceCall()
    let endpoint = APIConstants.baseURLString

    var task: URLSessionTask?

    func fetchPhotos(_ searchTerm: String, completion: @escaping ((Result<SearchResultsModel, ErrorResult>) -> Void)) {
        self.cancelFetchService()

        var parameters: [String: String] = [
            APIKey.methodKey: APIConstants.APIMethods_PhotosSearch,
            APIKey.apiKey: APIConstants.apiKeyValue,
            APIKey.nojsoncallbackKey: "1",
            APIKey.formatKey: "json",
            APIKey.safeSearchKey: "1",
            APIKey.textKey: searchTerm,
            APIKey.perPageKey: APIConstants.limit,
            APIKey.pageKey: "1" //Default for now
        ]

        if searchTerm.isEmpty {
            guard let location = LocationService.sharedInstance.lastLocation else {
                return
            }
            parameters[APIKey.latKey] = "\(location.coordinate.latitude)"
            parameters[APIKey.longKey] = "\(location.coordinate.longitude)"
            parameters[APIKey.textKey] = "Nearby"
        }

        task = NetworkService().loadData(urlString: endpoint, parameters: parameters, completion: self.networkResult(completion: completion))
    }
    func cancelFetchService() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
