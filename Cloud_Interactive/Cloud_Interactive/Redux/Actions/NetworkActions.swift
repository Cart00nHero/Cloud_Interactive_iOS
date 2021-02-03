//
//  NetworkActions.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation
import ReSwift

enum ApiActionStatus {
    case Started, Success, Failed
}
protocol ApiActionProtocol {
    var status: ApiActionStatus { get set }
    var errorMessage: String { get set }
}

struct LoadImagesRequestAction: Action, ApiActionProtocol {
    var status: ApiActionStatus = .Started
    var errorMessage: String = ""
    var responseData: [LoadImagesResponse] = []
}
func loadImagesRequestAction() -> LoadImagesRequestAction {
    var action = LoadImagesRequestAction()
    if NetWorkStatusListener.shareListener.isReachable == false {
        action.status = .Failed
        return action
    }
    let request = LoadImagesRequest()
    httpBinNetwork.request(request) { (response) in
        if response.error == nil {
            action.status = .Success
            let responseData = response.decode(to: [LoadImagesResponse].self)
            action.responseData = responseData ?? []
        } else {
            action.status = .Failed
            action.errorMessage = response.error?.localizedDescription ?? ""
        }
        appStore.dispatch(action)
    }
    return action
}
