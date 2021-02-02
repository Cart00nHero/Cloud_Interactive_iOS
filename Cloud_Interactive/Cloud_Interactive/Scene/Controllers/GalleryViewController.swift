//
//  GalleryViewController.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {
    
    private var sceneVC: SceneViewController? = nil
    private let presenter = GalleryPresenter()
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sceneVC = self.parent as? SceneViewController
        self.sceneVC?.stateDelegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appStore.dispatch(loadImagesRequestAction())
    }
}
extension GalleryViewController: UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.galleryData.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                guard let cell = cell as? GalleryCollectionCell else { return }
                let itemNumber = NSNumber(value: indexPath.item)
                if let cachedImage = presenter.imageCache.object(forKey: itemNumber) {
                    cell.cellImageView.image = cachedImage
                } else {
                    // 4
                    let data = presenter.galleryData[indexPath.row]
                    let imageUrl = URL(string: data.thumbnailUrl ?? "")!
                    presenter.fetchImage(url: imageUrl) { (image) in
                        if image != nil {
                            cell.cellImageView.image = image
                            self.presenter.imageCache.setObject(image!, forKey: itemNumber)
                        }
                    }
                }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionCell", for: indexPath) as! GalleryCollectionCell
        let data = presenter.galleryData[indexPath.row]
        cell.cellTitleLabel.text = String(data.id)
        cell.cellTextLabel.text = data.title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = UIScreen.main.bounds.size.width/4.0
        return CGSize(width: cellSize, height: cellSize)
    }
    
    
}
extension GalleryViewController: SceneStateDelegate {
    func onNewState(state: SceneState) {
        switch state.currentAction {
        case let action as LoadImagesRequestAction:
            switch action.status {
            case .Started:
                activityIndicatorView.isHidden = false
                activityIndicatorView.startAnimating()
            case .Success:
                activityIndicatorView.isHidden = true
                activityIndicatorView.stopAnimating()
                presenter.galleryData = action.responseData
                collectionView.reloadData()
            case .Failed:
                activityIndicatorView.isHidden = true
                activityIndicatorView.stopAnimating()
            }
        default: break
        }
    }
}
