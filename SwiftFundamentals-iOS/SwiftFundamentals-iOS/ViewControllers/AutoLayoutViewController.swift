//
//  DetailViewController.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 12/1/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import UIKit

///
/// A simple view controller to show state passing between VCs.
///
class AutoLayoutViewController : UIViewController {
 
    weak var delegate: CompletedDelegate?
    
    // Optional for testing purposes only. In production code, these should be
    // unwrapped optionals.
    @IBOutlet weak var navBar: UINavigationBar?
    @IBOutlet weak var firstNameLabel: UILabel?
    @IBOutlet weak var lastNameLabel: UILabel?

    @IBOutlet weak var random: UILabel?
    
    var person: Person?
    
    ///
    /// If the VC is instantiated from a nib or storyboard,
    /// awakeFromNib is immediately called.
    ///
    /// When called, all objects have been loaded from the nib.
    /// use `awakeFromNib()` to load other objects that you were
    /// not able to put into the nib
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
        print("\(#file)-\(#function)")
    }
    
    /// Called when the `view` property is first accessed.
    override func loadView() {
        // If you override loadView and actually provide a view, there is no
        // reason to call super. This call does not provide a view, therefore
        // it calls into super.
        super.loadView()
        print("\(#file)-\(#function)")
    }
    
    ///
    /// Called during rotation, or anytime device traits change (i.e., iPad Split View)
    ///
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        print("Display scale: \(self.traitCollection.displayScale)")
        print("Width size class: \(self.traitCollection.horizontalSizeClass.rawValue)")
        print("Height size class: \(self.traitCollection.verticalSizeClass.rawValue)")
    }
    
    ///
    /// When `viewDidLoad()` is called, all view objects are instantiated.
    ///
    /// Use this function to further configure your views.
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(#file)-\(#function) view.bounds == \(self.view.bounds)")
            
        if let navBar = self.navBar {
            // Make the UINavigationBar transparent, but keep the bar button items showing.
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
        if let firstNameLabel = self.firstNameLabel {
            firstNameLabel.text = "This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text."
        }
        
        if let random = self.random {
            random.text = "This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text.  This is some long text."
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#file)-\(#function)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#file)-\(#function)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("\(#file)-\(#function)")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("\(#file)-\(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            print("This VC is being removed (popped) from it's container VC.")
        }
        if self.isBeingDismissed {
            print("This VC is being dismissed by one of it's ancestors (modal).")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    /// Release any used memory from the view hierarchy (images)
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK:- IBActions
    
    @IBAction func done(sender: AnyObject) {
        self.delegate?.completed(vc: self)
    }

}
