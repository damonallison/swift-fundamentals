# View Controller Programming Guide

[View Controller Programming Guide](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457)

Two broad classifications of VCs:

* Content VC - present a view (UIViewController subclasses, UITableViewController)
* Container VCs - skeletal containers (UITabViewController, UINavigationController)

* Storyboards / segues
* Use IB to assign each VC and segue an ID.
* IDs are used to programmatically load a VC from the storyboard.
* Segue IDs are passed into

* Cross-VC communication (how to get data between source<->dest:
* Source configures dest, presents it.
* Dest delegates data back to source.
* Always use delegation to prevent the dest VC
from knowing anything about it's parent hierarchy.

* Declare IBOutlets / IBActions (as weak) in a category in the implementation file.
Properties / methods declared in the private interface are exposed to IB, but not
to other classes.

* The VC's view is loaded on demand - not when the VC is instantiated.

* Resource management - prefer lazy initialization for views and expensive data.
* Respond properly to low memory warnings.

* VC initialization sequence :
* initWithCoder (or the init method called)
* awakeFromNib (what objects are available?)
* view property is accessed, may be deferred
* loadView
* viewDidLoad
* view[Will|Did]Appear

##### Rotation

* The app (thru Info.plist) and root VC control what device orientations are supported.
* The root VC receives `willRotateToInterfaceOrientation:duration`. The default implementaiton
is to forward to all child VCs.
* Use `statusBarOrientation` to determine the current device orientation.
