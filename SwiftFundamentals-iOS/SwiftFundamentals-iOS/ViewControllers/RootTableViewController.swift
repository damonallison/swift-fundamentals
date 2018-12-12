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
        
        //
        // Uses a custom UIView for the title image.
        //
        // How can we apply this view to *all* VCs that get pushed on the stack?
        //
        // * Do we need a custom base VC that all other VCs inherit from?
        // * Listen for UINavigationController delegate (willPush..) and
        //   manually set the titleView on the new VC?
        //
        let titleView = UIImageView(image: UIImage(named: "self"))
        
        self.navigationController?.navigationBar.tintColor = UIColor.yellow
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
        
        // Create a custom view for displaying in the
        self.navigationController?.navigationBar.topItem?.titleView = titleView
        // self.navigationController?.navigationBar.backgroundColor = UIColor.blue

        // Configure tabs
        guard let tabVC = self.tabBarController else {
            preconditionFailure("RootTableViewController must be embedded within a UITabBarController")
        }
        
        let count = tabVC.tabBar.items?.count ?? 0
        print("Tab count: \(count)")
        for i in 0..<count {
            let tabItem = tabVC.tabBar.items![i]
            tabItem.badgeColor = UIColor.purple
            tabItem.badgeValue = String(i)
            tabItem.title = "Damon \(i)"
            print("tabItem: \(tabItem)")
        }
    }

    /**
     *  prepareForSegue is called when a segue is about to be performed.
     *  The segue has a `destinationViewController` property populated,
     *  allowing you to configure the destination VC before it is presented.
     *
     *  Segues are created in IB. In order to customize the destination VC
     *  before it is displayed, you need to determine what segue is being invoked
     *  by identifier, cast the destination VC appropriately, and assign state.
     *  Typically, the destination's `delegate` is set to the source VC.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("\(#file)-\(#function) - segue \(segue)")
        print("\(#file)-\(#function) - sender \(sender ?? "nil")")
        
        // Determine which segue was triggered. This is set from IB.
        switch(segue.identifier) {
        case "showPerson":
            guard let destVC = segue.destination as? AutoLayoutViewController else {
                preconditionFailure("Unexpected DestinationVC \(segue.destination.self)")
            }
            destVC.person = Person(firstName: "Damon", lastName: "Allison")
            destVC.delegate = self
        default:
            precondition(segue.identifier == "showPerson", "Invalid segue triggered")
        }
    }

    func completed(vc: UIViewController) {
        
        print("VC completed: \(vc)")
        
        if vc is AutoLayoutViewController {
            self.dismiss(animated: true) {
                print("Dismissed PersonVC")
            }
            return
        }
    }
}
