//
//  ChildTableViewController.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 12/3/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit

class ChildTableViewController : UITableViewController, CompletedDelegate {
    
    weak var delegate: CompletedDelegate?
    
    @IBAction func done(sender: AnyObject) {
        self.delegate?.completed(vc: self)
    }
    
    func completed(vc: UIViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    /// Segues are created in IB. In order to customize the destination VC
    /// before it is displayed, you need to determine what segue is being invoked
    /// by identifier, cast the destination VC appropriately, and assign state.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("\(#file)-\(#function) - segue \(segue)")
        print("\(#file)-\(#function) - sender \(sender ?? "nil")")
        precondition(segue.identifier == "showPerson", "Invalid segue triggered")
        guard let destVC = segue.destination as? PersonViewController else {
            preconditionFailure("Unexpected DestinationVC \(segue.destination.self)")
        }
        destVC.person = Person(firstName: "Damon", lastName: "Allison")
        destVC.delegate = self
        
        // How to cancel the segue if it's unknown or invalid?
    }
}
