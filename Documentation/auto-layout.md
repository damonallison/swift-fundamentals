# Auto Layout

## Questions

* How to print traits (size classes) at runtime?

## Guidelines

* To enable safe area, enable "Safe Area Layout Guides" in Interface Builder info tab (Cmd-Opt-1).

* Avoid using "Left" and "Right" Auto Layout Attributes. Use `Leading` and
  `Trailing` instead.

* Horizontal constraints - typically use a 0 point constraint to the layout
  margins.

* Vertical constraints
  * If the view extends under the bars (scroll views) typically constrain to the
    topMargin / bottomMargin. If you use UIScrollViews, you'll typically have to
    set `contentInset` and `scrollIndicatorInsets`.
  * If the view does *not* extend under the bars, constrain to the top/bottom
    `layoutGuide`.

* When programmatically instantiating views, set
  `translatesAutoresizingMaskIntoConstraints` to `NO`. When you add your own
  constraints, they conflict with the autoresizing constraints.

## Debugging

* Set the symbolic breakpoint `UIViewAlertForUnsatisfiableConstraints` to show a
  `UIAlert` for each unsatisfiable constraint.

* When adding views w/ constraints programmatically, set
  `translatesAutoresizingMaskIntoConstraints` to `false`.

* The constraint debugger will print view identifiers to logs (label text,
  button title). Set the view's Xcode specific label in the identity inspector
  to have that value printed.

* Debug -> View Debugging -> Show Alignment Rectangles
  * Shows blue outlines of each view. Allows you to visualize the views and constraints.


## Layout Options

* Programmatic
* Autoresizing masks (automates *some*)
* Auto Layout

### Autoresizing Masks

* Only support *some* layouts. Will not handle even mildly complex layouts.
* Autoresizing Masks were an incremental improvement (at best) to manual layout.
* You should *always* use Auto Layout.

### Constraints

* Priorities
  * AL tries to satisfy constraints in priority order. If it can't satisfy one,
    it is skipped.
  * 1000 is required, anything else is optional.

### Intrinsic content size

How can we create interfaces which dynamically adjust their size to adapt to
different content? By relying on a view's "intrinsic content size".

When a constraint is not set for a given dimension (height, width, or both), it
can use the view's intrinsic content size to calculate the dimension. For
example if the `height` is not constrained for a UILabel, the height will grow
unbounded to accommodate varying text length.


## UIStackView

* Add subviews to `UIStackView`s `arrangedSubviews` property.
* Set `isLayoutMarginsRelativeArrangement = true` to pin views to `UIStackView`'s margins rather than its edges.
* The stack view uses each UIView's `intrinsicContentSize` property when calculating it's size along the stack axis.

## Programmatic Constraints

* UIView exposes `NSLayoutAnchor` properties. Layout anchors are a newer, safer
  way to create constraints than using `NSLayoutConstraint`
  directly. NSLayoutAnchor has many different subclasses (horizontal, vertical)
  which enforce type safety. For example, you cannot constrain a
  horizontal anchor to a vertical anchor.
  
```swift

let margins = view.layoutMarginsGuide
//
// Constrains `myView`.leading to `view`.leading
myView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true

```
