//
//  PersonViewController.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 12/2/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit

class PersonViewController : UIViewController {
    
    weak var delegate: CompletedDelegate?
    
    @IBAction func done(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.completed(vc: self)
        }
    }
    
}
