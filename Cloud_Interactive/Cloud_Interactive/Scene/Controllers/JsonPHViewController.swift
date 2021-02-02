//
//  JsonPHViewController.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation
import UIKit

class JsonPHViewController: UIViewController {
    private var sceneVC: SceneViewController? = nil
    private let presenter = JsonPHPresenter()
    @IBOutlet weak var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sceneVC = self.parent as? SceneViewController
    }
    // MARK: - actions
    @IBAction func requestApiButtonClickAction(_ sender: UIButton) {
        let toVC = self.storyboard?.instantiateViewController(identifier: "GalleryViewController")
        self.sceneVC?.basePushToViewController(toVC!, Animated: true)
    }
}
