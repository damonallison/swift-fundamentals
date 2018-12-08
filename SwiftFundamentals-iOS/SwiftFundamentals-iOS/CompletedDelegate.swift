//
//  CompletedProtocol.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 12/2/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit

///
/// The AnyObject requirement limits protocol adoption to class types.
/// This is required to hold weak references to objects conforming to
/// a protocol, which is the preferrred way to declare delegates.
///
/// Holding a weak reference to the delegate prevents retain cycles.
///
/// weak var delegate: CompletedDelegate?
///
protocol CompletedDelegate : AnyObject {
    
    
    /// Indicates the view controller has been completed.
    ///
    /// - Parameter vc: The UIViewController that is indicating it is complete.
    func completed(vc: UIViewController)
}
