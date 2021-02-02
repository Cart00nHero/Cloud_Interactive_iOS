//
//  ApiResponses.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation

struct LoadImagesResponse : Decodable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String?
    let thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
      }
}
extension LoadImagesResponse: JSONEmptyRepresentable {
  typealias CodingKeyType = LoadImagesResponse.CodingKeys
}
