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
    
        
        // Programmatically add a UITabBarItem and associated VC.
        
        let sb = UIStoryboard(name: "AutoLayout", bundle: Bundle.main)
        guard let vc = sb.instantiateInitialViewController() else {
            preconditionFailure("AutoLayout.storyboard is missing the initial ViewController")
        }
        
        let item = UITabBarItem(title: "Auto Layout", image: nil, selectedImage: nil)
        vc.tabBarItem = item
        self.viewControllers?.insert(vc, at: 0)
        
        // Person View Controller is a single VC *not* embedded within a UINavigationController
        // This allows us to test creating our own UINavigationBar instance
        
        let sbPerson = UIStoryboard(name: "Person", bundle: Bundle.main)
        guard let personVC = sbPerson.instantiateInitialViewController() else {
            preconditionFailure("Person.storyboard is missing the initial ViewController")
        }
        (personVC as! PersonViewController).person = Person(firstName: "Damon", lastName: "Allison")
        let personItem = UITabBarItem(title: "Person", image: nil, selectedImage: nil)
        personVC.tabBarItem = personItem
        self.viewControllers?.append(personVC)
        
        // Force the selection...
        self.selectedIndex = 2
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("\(#file)-\(#function)-\(#line): didSelect \(item)")
    }
}
