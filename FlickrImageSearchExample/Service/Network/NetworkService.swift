//
//  NetworkService.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation

final class NetworkService {
    
    func loadData(urlString: String, parameters: [String: String], session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
        
        guard let url = URLComponents(string: urlString) else {
            completion(.failure(.network(string: "Wrong url format")))
            return nil
        }
        
        var components: URLComponents = url
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        print(components.url ?? "nil url")
        
        var request = NetworkMethod.request(method: .GET, url: components.url!)
        if let reachability = Reachability(), !reachability.isReachable {
            request.cachePolicy = .returnCacheDataDontLoad
        }
        
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}
