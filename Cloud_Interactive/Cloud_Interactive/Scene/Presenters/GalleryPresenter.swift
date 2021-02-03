//
//  GalleryPresenter.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation
import UIKit

class GalleryPresenter: NSObject {
    var galleryData = [LoadImagesResponse]()
    let imageCache = NSCache<NSNumber, UIImage>()
    
    func fetchImage(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completionHandler(image)
            }
        }
    }
}
