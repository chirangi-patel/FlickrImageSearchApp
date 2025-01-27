//
//  DetailsViewDataSource.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation
import UIKit

class DetailsDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class DetailsViewDataSource: DetailsDataSource<DetailModel>, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let type = DetailsType(rawValue: indexPath.row)
        switch type {
        case .imageCell?:
            let cell: DetailViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.dataValue = data.value[indexPath.row]
            cell.selectionStyle = .none
            return cell

        default:
            let cell: DetailInformationCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.dataValue = data.value[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }

}
