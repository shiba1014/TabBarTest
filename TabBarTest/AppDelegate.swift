//
//  AppDelegate.swift
//  TabBarTest
//
//  Created by 羽柴 彩月 on 2017/08/29.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window?.rootViewController = RootViewController()
        return true
    }
}

