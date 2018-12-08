# iPhone X

* Designing for iPhone X (Fall 2017)
* Auto Layout in Interface Builder (412 - WWDC 2017)
* Modern User Interaction on iOS (219 - WWDC 2017)
* Updating Your App for iOS 11 (214 - WWDC 2017)

---

## Building Apps for iPhone X

* Base SDK @ iOS 11+.
* Must have launch storyboard.

* The UIStatusBar is *not* 20 pixels on the iPhone X. Do *not* hardcode frames
  or UI elements, use auto layout and constrain views to the safe area.

* 
* Bottom layout constraint should constrain go the safe area layout guide at the bottom - not superview bottom edge.
* Enable safe area layout guides turn on (Use Safe Area Layout Guides) checkbox in storyboard (or xib).

* Integrate search controller w/ UINavigationItem

if #available(iOS 11.0, *) {
  self.navigationItem.searchController = searchController
  self.navigationItem.hidesSearchBarWhenScrolling = [true | false]
else {
  present(searchController)
}

* View hierarchy debugger in Xcode.

* TableCell - backgroundView (entire cell)
              contentView (inset to safe area)


## Designing for iPhone X

* Use PDFs rather than `png`. Otherwise, make sure to use include 1x, 2x, 3x.
* 375 x 812 (145 more than 4.7 screen)

* Home Indicator - display over apps interface.

* NavBar background is extended to top edge.
* TabBar / Toolbar extended to bottom.
* Table view will span full display. Content view will be inset.

* Background graphics will need to be different for iPhone X.
* Use Safe Area Layout Guides / Content Insets

* Status bar is *not* 20px on iPhone 10.
* Don't hide the status bar.

* All content should be within safe area. Don't use full screen.
* Table views should extend all the way to the bottom.
* Auto-hide will hide the home indicator.

## Updating Your App for iOS 11

* UINavigationController facilities:
  * Search controller integration
  * Refresh controls
  * Rubber banding (large title size adjustments)

* UIToolbar / UINavigationBar - use Auto Layout

* UILayoutGuide - layoutMarginGuide (auto layout guides)
* layoutMargins (leading / trailing)


* Safe Area
  * UIView.safeAreaInsets
  * UIView.safeAreaLayoutGuide

* UITableView
  * Table views use self-sizing by default.
  * Headers, footers will use estimated sizes.
  * Ensure cells have sufficient internal constraints (or implement delegate methods to tell UITableView how to size cells).

* separatorInset (setting to 0 will cause cells to be pushed to edges)

* UITableView swipe actions
  * loadingSwipeActionsConfigurationForRowAt...
  * trailingSwipeActionsConfigurationForRowAt...
