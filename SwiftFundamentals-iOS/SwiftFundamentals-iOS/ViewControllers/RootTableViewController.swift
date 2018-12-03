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
        vc.delegate = self
        self.navigationController!.pushViewController(vc, animated: true)
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
        
        guard let vc = segue.destination as? DetailViewController else {
            preconditionFailure("Destination VC should be \(String.init(describing: DetailViewController.self))")
        }
        vc.delegate = self
    }
    
    func completed(vc: UIViewController) {
        
        print("VC completed: \(vc)")

        //
        // Determine if the personViewController is on the top of the navigation stack.
        //
        guard let nc = self.navigationController else {
            preconditionFailure("RootTableViewController should be embedded in a UINavigationController")
        }
        guard let tc = nc.topViewController else {
            preconditionFailure("UINavigationController.topViewController should exist")
        }
        precondition(tc is DetailViewController || tc is PersonViewController, "Expected DetailViewController or PersonViewController")
        nc.popViewController(animated: true)
    }
}
