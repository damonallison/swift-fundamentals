//
//  RootTableViewController.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 12/2/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit

///
/// DynamicTableViewController shows how to create a table with dynamically
/// sized cells. When setting estimatedRowHeight, set it as accurate as possible.
/// The system calculates scroll bar heights based on these estimates. The more accurate the
/// estimates, the more seamless the user experience becomes.
///
/// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithSelf-SizingTableViewCells.html#//apple_ref/doc/uid/TP40010853-CH25-SW1
///
/// To enable self-sizing table cells, you must set:
///
/// self.tableView.rowHeight = UiTableViewAutomaticDimension
/// self.tableView.estimatedRowHeight = 100 // Make as accurate as possible.
///
class DynamicTableViewController : UITableViewController, CompletedDelegate {

    private let content = [
        "Some text.",
        "Some text. Some text. Some text. Some text.",
        "Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text.",
        "Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text.",
        "Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text. Some text.",
        ]

    override func viewDidLoad() {
        
        // UITableViewController will *always* have a UITableView as it's view.
        // There is a convenience property `tableView` to give you typed access
        // to the UITableView.
        assert(self.tableView != nil && self.view == self.tableView)

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
        
        
        //
        // Setup self-sizing rows
        //
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
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


///
/// UITableViewDataSource / UITableViewDelegate
///
extension DynamicTableViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.content.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "defaultCell")
        if cell == nil {
            cell = DynamicTableViewCell(frame: CGRect.zero)
        }
        guard let dynamicCell = cell as? DynamicTableViewCell else {
            preconditionFailure("Invalid cell type. Expected DynamicTableViewCell")
        }
        dynamicCell.valueLabel.text = self.content[indexPath.row]
        return dynamicCell
    }
}
