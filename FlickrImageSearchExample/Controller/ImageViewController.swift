//
//  ImageViewController.swift
//  FlickrImageSearchExample
//
//  Created by Chirangi Patel on 27/7/21.
//

import UIKit
import CoreLocation

class ImageViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar?
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 3
    var activityIndicator: ActivityIndicator? = ActivityIndicator()
    var searchActive: Bool = false
    let dataSource = ImageViewDataSource()
    lazy var viewModel: ImageViewModel = {
        let viewModel = ImageViewModel(dataSource: dataSource)
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupViewModel()
        self.setupLocationService()
    }

    func setupUI() {
        self.title = "Flickr Search"
        self.view.backgroundColor = ThemeColor.white
    }

    func setupViewModel() {
        self.imageCollectionView?.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.imageCollectionView?.reloadData()
        }
        if let _ = LocationService.sharedInstance.lastLocation {
            self.methodViewModelService()
        }
        self.viewModel.onErrorHandling = { [weak self] error in
            self?.showAlert(title: "An error occured", message: "Oops, something went wrong!")
        }
    }

    func methodViewModelService(_ searchText: String? = "") {
        guard let strText = searchText else {return}
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.activityIndicator?.start()
        self.viewModel.fetchServiceCall(strText) { _ in
            DispatchQueue.main.async {
                self.activityIndicator?.stop()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.searchActive = false
                self.imageCollectionView?.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsViewController" {
            let controller = segue.destination as? DetailsViewController
            controller?.selectedData = viewModel.selectedData
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ImageViewController: UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        guard let layout = self.imageCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        self.imageCollectionView?.collectionViewLayout = layout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.imageCollectionView?.backgroundColor = ThemeColor.white
        self.imageCollectionView?.showsHorizontalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.presentProfile(indexPath) { (_) in
            self.performSegue(withIdentifier: "toDetailsViewController", sender: self)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem + 21
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: LocationServiceDelegate
extension ImageViewController: LocationServiceDelegate {
    func setupLocationService() {
        LocationService.sharedInstance.delegate = self
        LocationService.sharedInstance.startUpdatingLocation()
    }

    func locationDidUpdate(_ currentLocation: CLLocation) {
        self.methodViewModelService()
    }

    func locationDidFail(_ error: Error) {
        print("tracing Location Error : \(error)")
    }
}
