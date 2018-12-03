//
//  RootTableViewController.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 12/2/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit

class RootTableViewController : UITableViewController, CompletedDelegate {
    
    override func viewDidLoad() {
        assert(self.tableView != nil && self.view == self.tableView)
        self.tableView.backgroundColor = UIColor.red
    }

    
    /// Example showing how to load a new storyboard and VC from the storyboard.
    ///
    /// - Parameter sender: The object (UIButton) triggering the action.
    @IBAction func showPersonViewController(sender: AnyObject) {
        let sb = UIStoryboard(name: "Person", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "PersonVC") as? PersonViewController else {
            preconditionFailure("Expected PersonVC to be of type PersonViewController")
        }
        vc.person = Person(firstName: "Damon", lastName: "Allison")
        vc.delegate = self
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    /// Loads the child VC and presents it's initial VC modally.
    ///
    /// - Parameter sender: The object (UIButton) triggering the action.
    @IBAction func presentChildViewController(sender: AnyObject) {
        let sb = UIStoryboard(name: "Child", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() else {
            preconditionFailure("Child.storyboard does not have an initial view controller")
        }
        guard let tabVC = vc as? UITabBarController else {
            preconditionFailure("Child.storyboard root view controller should be a UITabBarController")
        }
        // The first VC will be the UINavigationController with it's root VC ChildTableViewController.
        guard let navVC = tabVC.viewControllers?[0] as? UINavigationController,
              let childVC = navVC.viewControllers[0] as? ChildTableViewController else {
            preconditionFailure("The first UITabViewController child VC should be a UINavigationController w/ it's first VC a ChildTableViewController")
        }
        childVC.delegate = self
        
        print("Tab count: \(tabVC.viewControllers?.count ?? 0)")
        print("Tab item count: \(tabVC.tabBar.items?.count ?? 0)")
        for i in 0..<(tabVC.tabBar.items?.count ?? 0) {
            let tabItem = tabVC.tabBar.items![i]
            tabItem.badgeColor = UIColor.purple
            tabItem.badgeValue = String(i)
            tabItem.title = "Damon \(i)"
            print("tabItem: \(tabItem)")
        }
        self.modalPresentationStyle = .fullScreen
        self.present(tabVC, animated: true) {
            print("presented tabVC")
        }
    }
    
    /**
     *  prepareForSegue is called when a segue is about to be performed.
     *  The segue has a `destinationViewController` property populated,
     *  allowing you to configure the destination VC before it is presented.
     *
     *  Typically, the destination's `delegate` is set to the source VC.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Preparing for segue : \(segue)")
        print("Source VC \(segue.source.restorationIdentifier ?? "nil")")
        print("Dest   VC \(segue.destination.restorationIdentifier ?? "nil")")
    }
    
    func completed(vc: UIViewController) {
        
        print("VC completed: \(vc)")
        
        if vc is ChildTableViewController {
            self.dismiss(animated: true) {
                print("Dismissed ChildTableViewController")
            }
            return
        }

        //
        // Determine if the personViewController is on the top of the navigation stack.
        //
        guard let nc = self.navigationController else {
            preconditionFailure("RootTableViewController should be embedded in a UINavigationController")
        }
        guard let tc = nc.topViewController else {
            preconditionFailure("UINavigationController.topViewController should exist")
        }
        precondition(tc is PersonViewController, "Expected PersonViewController")
        nc.popViewController(animated: true)
    }
}
