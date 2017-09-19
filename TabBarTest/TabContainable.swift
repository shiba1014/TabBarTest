//
//  TabContainable.swift
//  TabBarTest
//
//  Created by 羽柴 彩月 on 2017/08/29.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import Foundation
import UIKit

protocol TabContainable: class {
    var viewController: UIViewController { get }
    
    func updateOnTabReselected()
}

extension TabContainable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}
