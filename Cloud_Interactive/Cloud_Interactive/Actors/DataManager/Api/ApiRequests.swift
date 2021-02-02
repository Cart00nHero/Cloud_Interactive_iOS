//
//  ApiRequests.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation

class LoadImagesRequest: GetRequest {
    override func loadRequest() {
        super.loadRequest()
        path = "/photos"
    }
}
