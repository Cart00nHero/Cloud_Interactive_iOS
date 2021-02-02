//
//  UIActions.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation
import ReSwift

struct AdjustForKeyboardAction: Action {
    let notification: Notification
    init(notification: Notification) {
        self.notification = notification
    }
}
