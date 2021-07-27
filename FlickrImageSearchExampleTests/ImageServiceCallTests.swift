//
//  ImageServiceCallTests.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import XCTest
@testable import FlickrImageSearchExample

class ImageServiceCallTests: XCTestCase {

    func testCancelRequest() {
        let service: ImageServiceCall! = ImageServiceCall()
        service.fetchPhotos("test") { (_) in
        }
        service.cancelFetchService()
        XCTAssertNil(service.task, "Expected task nil")
    }
}
