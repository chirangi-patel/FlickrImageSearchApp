//
//  ImageViewModel.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation

class  ImageViewModel {
    // MARK: - Input
    weak var dataSource: GenericDataSource<ImageModel>?

    // MARK: - Output
    weak var service: ImageServiceCallProtocol?
    var onErrorHandling: ((ErrorResult?) -> Void)?
    var selectedData: ImageModel?

    init(service: ImageServiceCallProtocol? = ImageServiceCall.shared, dataSource: GenericDataSource<ImageModel>?) {
        self.dataSource = dataSource
        self.service = service
    }

    func fetchServiceCall(_ searchTerm: String,
                          completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {

        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        service.fetchPhotos(searchTerm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    if let results = converter.photos?.photo {
                        self.dataSource?.data.value = results
                        completion?(Result.success(true))
                    } else {
                        self.onErrorHandling?(ErrorResult.parser(string: "unable to parse"))
                        completion?(Result.failure(ErrorResult.parser(string: "unable to parse")))
                    }

                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    self.onErrorHandling?(error)
                    completion?(Result.failure(error))
                    break
                }
            }
        }
    }

    func presentProfile(_ indexPath: IndexPath,
                        completion: ((ImageModel) -> Void)? = nil) {
        if let data = self.dataSource?.data.value[indexPath.row] {
            self.selectedData = data
            completion!(data)
        }
    }
}
