//
//  UIItemData.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation

enum ViewType : Int {
    case Label,TextField,Gallery,ImageView
}
protocol ViewItemProtocol {
    var viewType: ViewType { get }
}

struct GalleryItem: ViewItemProtocol {
    let viewType: ViewType = .Gallery
    var titleLabel: LabelItem = LabelItem()
    var textLabel: LabelItem = LabelItem()
    var urlImage: ImageViewItem = ImageViewItem()
}

struct LabelItem: ViewItemProtocol {
    let viewType: ViewType = .Label
    var numberOfLines = 1
    var text = ""
}

struct ImageViewItem: ViewItemProtocol {
    let viewType: ViewType = .Label
    var imageUrl = ""
}
