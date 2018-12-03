//
//  ViewController.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 10/28/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit
import Dispatch

class ViewController: UIViewController {

    var sema = DispatchSemaphore(value: 1)
    var q = DispatchQueue.global(qos: .background)
    
    @IBOutlet weak var signalButton: UIButton!
    @IBOutlet weak var waitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        q.async {
            while (true) {
                print("Waiting")
                self.sema.wait()
                print("Running")
            }
        }
    }
    
    @IBAction func signal(button: UIButton) {
        self.sema.signal()
    }
    
    @IBAction func wait(button: UIButton) {
        self.sema.wait()
    }
}
