//
//  ImageViewDataSourceTests.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import XCTest
@testable import FlickrImageSearchExample

class ImageViewDataSourceTests: XCTestCase {
    var dataSource: ImageViewDataSource?
    override func setUp() {
        super.setUp()
        dataSource = ImageViewDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testEmptyValueInDataSource() {
        dataSource?.data.value = []
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        XCTAssertEqual(dataSource?.numberOfSections(in: collectionView), 1, "Expected one section in collection view")
        XCTAssertEqual(dataSource?.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in collection view")
    }

    func testValueInDataSource() {
        let responseResults: [ImageModel] = valuesFromJSON()
        dataSource?.data.value = responseResults
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        XCTAssertEqual(dataSource?.numberOfSections(in: collectionView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource?.collectionView(collectionView, numberOfItemsInSection: 0), responseResults.count, "Expected responseResults.count cell in collection view")
    }

    func valuesFromJSON() -> [ImageModel] {
        var responseResults = [ImageModel]()
        guard let data = FileManager.readJsonFile(forResource: "flickrsample") else {
            XCTAssert(false, "Can't get data from flickrsample.json")
            return responseResults
        }
        let completion: ((Result<SearchResultsModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid flickrsample")
            case .success(let response):
                if
                    let converter = response.photos,
                    let photo = converter.photo {
                    responseResults = photo
                } else {
                      XCTAssert(false, "unable to parse SearchResultsModel")
                }
                break
            }
        }
        ParserHelper.parse(data: data, completion: completion)
        return responseResults
    }

}

extension FileManager {
    static func readJsonFile(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: ImageViewDataSourceTests.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
            }
        }
        return nil
    }
}
