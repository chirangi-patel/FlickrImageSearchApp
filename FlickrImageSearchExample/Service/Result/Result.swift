//
//  Result.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
