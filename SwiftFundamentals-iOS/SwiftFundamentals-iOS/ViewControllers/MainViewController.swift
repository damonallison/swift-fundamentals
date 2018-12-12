//
//  MainViewController.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 12/8/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit

class MainViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        //
        // Programmatically add a VC from another storyboard to the UITabBarController.
        // Note: This can be accomplished in IB by using storyboard references.
        //
//        let sb = UIStoryboard(name: "AutoLayout", bundle: Bundle.main)
//        guard let vc = sb.instantiateInitialViewController() else {
//            preconditionFailure("AutoLayout.storyboard is missing the initial ViewController")
//        }
        
//        let item = UITabBarItem(title: "Auto Layout", image: nil, selectedImage: nil)
//        vc.tabBarItem = item
//        self.viewControllers?.insert(vc, at: 0)
        
        // Because we are adding a VC via a storyboard reference, we need to set the
        // UITabItem's label property programmatically.
        guard let vc = self.viewControllers?.first(where: { $0 is AutoLayoutViewController }) else {
            preconditionFailure("Missing tabItems")
        }
        vc.tabBarItem.title = "Auto Layout"
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("\(#file)-\(#function)-\(#line): didSelect \(item)")
    }
}
