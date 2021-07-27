//
//  DetailsViewModel.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation

class  DetailsViewModel {
    // MARK: - Input
    weak var dataSource: DetailsDataSource<DetailModel>?

    init(dataSource: DetailsDataSource<DetailModel>?) {
        self.dataSource = dataSource
    }

    func fetchDataSource(photoData: ImageModel?,
                         completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        self.dataSource?.data.value = DetailModel.setupDetailModel(photoData)
        completion?(Result.success(true))
    }
}
