//
//  ViewController.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import UIKit
import ReSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appStore.dispatch(loadImagesRequestAction())
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appStore.subscribe(self) {
            $0.select {
                $0.sceneState
            }
        }
    }
}

extension ViewController: StoreSubscriber {
    func newState(state: SceneState) {
        switch state.currentAction {
        case let action as LoadImagesRequestAction:
            if action.status == .Success
                && action.responseData.count > 0 {
                print("OoooooooO")
                let aaa = action.responseData[0]
                print(aaa.thumbnailUrl ?? "")
            }
        default: break
        }
    }
}
