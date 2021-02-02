//
//  SolarApiService.swift
//  MoyaTest
//
//  Created by YuCheng on 2019/5/11.
//  Copyright © 2019 SCTWBank. All rights reserved.
//

import SolarNetwork

struct HTTPBinTarget: SLTarget {
    var baseURLString: String { return "https://jsonplaceholder.typicode.com" }
    var configuration: URLSessionConfiguration {
        let configure = URLSessionConfiguration.default
//        configure.timeoutIntervalForResource = 1
        configure.timeoutIntervalForRequest = 30
        return configure
    }
}

let httpBinNetwork = SLNetwork(HTTPBinTarget())

class PostRequest: SLRequest {
    override func loadRequest() {
        NetWorkStatusListener.shareListener.startListening()
        super.loadRequest()
        method = .post
    }
}
class GetRequest: SLRequest {
    override func loadRequest() {
        NetWorkStatusListener.shareListener.startListening()
        super.loadRequest()
        method = .get
    }
}

class NetWorkStatusListener: NSObject {
    static let shareListener = NetWorkStatusListener()
    private var isStarted = false
    var isReachable = true
    private let reachability = NetworkReachabilityManager()
    override init()
    {
        super.init()
        startListening()
    }
    func startListening() {
        if isStarted == false {
            reachability?.startListening { status in
                switch status {
                case .unknown:
                    debugPrint("unknown")
                    self.isReachable = true
                case .notReachable:
                    debugPrint("notReachable")
                    self.isReachable = false
                case .reachable(_):
                    self.isReachable = true
                }
            }
            isStarted = true
        }
    }
    func stopListening() {
        reachability?.stopListening()
        isStarted = false
    }
}
