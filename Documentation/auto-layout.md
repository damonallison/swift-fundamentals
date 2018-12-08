# Auto Layout

* To enable safe area, enable "Safe Area Layout Guides" in Interface Builder info tab (Cmd-Opt-1).

## Questions

* What is an intrinsic content size?
* How to dynamically size controls (labels, table view cells) based on font size, string length?
* How to display (and test) right to left languages?

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
  * 



