//
//  RootViewController.swift
//  TabBarTest
//
//  Created by 羽柴 彩月 on 2017/08/29.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    fileprivate(set) var topNavVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初回起動時の切り分け
        // LaunchVCにTopVCを重ねる
        // ログアウト時にはTopVCを取り除く
        let tabBC = TabBarController.shared
        tabBC.change(mainViewController: tabBC.firstVC)
        topNavVC = UINavigationController(rootViewController: tabBC).toNavigationBarHidden
        addChild(topNavVC!, toContainerView: view)
    }
}
