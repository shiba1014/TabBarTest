//
//  SecondViewController.swift
//  TabBarTest
//
//  Created by 羽柴 彩月 on 2017/08/29.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    static let shared = SecondViewController()
    
    private init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Second"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
