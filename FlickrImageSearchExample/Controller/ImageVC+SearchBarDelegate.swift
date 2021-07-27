//
//  ImageVC+SearchBarDelegate.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import Foundation
import UIKit

// MARK: - UISearchBarDelegate Setup
extension ImageViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.methodFlickerSearch(searchBar.text)
        view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true
    }

    func methodFlickerSearch(_ searchText: String?) {
        guard let strText = searchText else {return}
        if !strText.isEmpty {
            let searchText: String =  searchText!.replacingOccurrences(of: " ", with: "")
            self.methodViewModelService(searchText)
        } else {
            searchActive = false
        }
    }
}
