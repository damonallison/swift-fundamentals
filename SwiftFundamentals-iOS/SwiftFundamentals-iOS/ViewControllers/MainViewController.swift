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
        // Programmatically add a UITabBarItem and custom VC.
        //
        let sb = UIStoryboard(name: "AutoLayout", bundle: Bundle.main)
        guard let vc = sb.instantiateInitialViewController() else {
            preconditionFailure("AutoLayout.storyboard is missing the initial ViewController")
        }
        
        let item = UITabBarItem(title: "Auto Layout", image: nil, selectedImage: nil)
        vc.tabBarItem = item
        self.viewControllers?.insert(vc, at: 0)
        
        self.selectedIndex = 0
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("\(#file)-\(#function)-\(#line): didSelect \(item)")
    }
}
