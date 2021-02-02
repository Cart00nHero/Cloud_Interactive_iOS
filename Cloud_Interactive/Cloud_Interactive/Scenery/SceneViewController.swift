//
//  DefaultTemplate.swift
//  WhatToEat
//
//  Created by YuCheng on 2020/5/9.
//  Copyright © 2020 YuCheng. All rights reserved.
//

import UIKit
import ReSwift

protocol SceneStateDelegate {
    func onNewState(state: SceneState)
}
class SceneViewController: UIBaseViewController {

    var stateDelegate: SceneStateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appStore.subscribe(self) {
            $0.select {
                $0.sceneState
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        appStore.unsubscribe(self)
        stateDelegate = nil
    }

    // MARK: - Public Methods
    func registerKeyBoardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // MARK: - Private Methods
    private func initialNavigationBar() {
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 34.0/255.0, green: 139.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    // MARK: - UI Actions
    @objc private func adjustForKeyboard(notification: Notification) {
        appStore.dispatch(AdjustForKeyboardAction(notification: notification))
    }

}

extension SceneViewController: StoreSubscriber{
    func newState(state: SceneState) {
        self.stateDelegate?.onNewState(state: state)
    }
}
