//
//  CompletedProtocol.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 12/2/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit

protocol CompletedDelegate : AnyObject {
    
    
    /// Indicates the view controller has been completed.
    ///
    /// The AnyObject requirement limits protocol adoption to class types.
    /// This is required since we are going to hold weak references to objects
    /// conforming to this protocol.
    ///
    /// - Parameter vc: The UIViewController that is indicating it is complete.
    func completed(vc: UIViewController)
}
