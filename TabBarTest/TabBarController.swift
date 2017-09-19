//
//  TabBarController.swift
//  TabBarTest
//
//  Created by 羽柴 彩月 on 2017/08/29.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import UIKit

class TabBarController: UIViewController {
    static let shared = TabBarController()
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var tabView: UIView!
    @IBOutlet fileprivate var tabButtons: [UIButton]!
    
    fileprivate(set) lazy var firstVC = FirstViewController.shared.navigate
    fileprivate let controllers = [FirstViewController.shared, SecondViewController.shared]
    
    var mainVC: UIViewController? {
        didSet {
            remove(viewController: oldValue)
            setup(viewController: mainVC)
        }
    }
    
    static let FIRST_SELECTED_INDEX = 0
    
    fileprivate var selectedIndex = FIRST_SELECTED_INDEX {
        didSet {
            tabButtons.forEach { button in
                button.isSelected = selectedIndex == button.tag
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabButtons.forEach { button in
            button.titleLabel?.text = controllers[button.tag].title
            button.addTarget(self, action: #selector(self.tappedButton(_:)), for: .touchUpInside)
            button.isSelected = TabBarController.FIRST_SELECTED_INDEX == button.tag
        }
    }
    
    override func viewWillLayoutSubviews() {
        setup(viewController: mainVC)
    }
    
    func change(mainViewController mainVC: UIViewController) {
        self.mainVC  = mainVC
    }
    
    func setup(viewController vc: UIViewController?) {
        guard let vc = vc, isViewLoaded else { return }
        addChild(vc, toContainerView: containerView)
    }
    
    func remove(viewController vc: UIViewController?) {
        guard let vc = vc, isViewLoaded else { return }
        
        vc.willMove(toParentViewController: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    func tappedButton(_ sender: UIButton) {
        let index = sender.tag
        let vc: UINavigationController = controllers[index].navigate
        if selectedIndex == index {
            (vc.viewControllers.first as? TabContainable)?.updateOnTabReselected()
        } else {
            change(mainViewController: vc)
        }
        
        selectedIndex = index
    }
}

public extension UIViewController {
    func addChild(_ vc: UIViewController, toContainerView containerView: UIView, withConstraints: Bool = true) {
        addChildViewController(vc)
        containerView.addSubview(vc.view)
        
        if withConstraints {
            vc.view.constrainToFitToSuper()
        }
        
        vc.didMove(toParentViewController: self)
    }
    
    func removeFromParent(_ vc: UIViewController) {
        willMove(toParentViewController: vc)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
    func popToRootIfNotOnTop(animated: Bool, onTopHandler: () -> Void) {
        guard let navigationController = navigationController, navigationController.topViewController != self else {
            onTopHandler()
            return
        }
        navigationController.popToRootViewController(animated: animated)
    }
    
    var forefrontViewController: UIViewController {
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.forefrontViewController ?? self
        }
        return presentedViewController?.forefrontViewController ?? self
    }
}

public extension UINavigationController {
    var toNavigationBarHidden: UINavigationController {
        isNavigationBarHidden = true
        return self
    }
}

public extension UIView {
    func constrainToFitToSuper() {
        guard let superview = superview else { return }
        constrainToFit(superview)
    }
    
    func constrainToFit(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor)
            ])
    }
}

private extension UIViewController {
    var navigate: UINavigationController {
        return navigationController ?? UINavigationController(rootViewController: self)
    }
}
