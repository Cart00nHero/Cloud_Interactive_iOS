//
//  UICollectionViewCells.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation
import UIKit

class GalleryCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellTextLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
}
