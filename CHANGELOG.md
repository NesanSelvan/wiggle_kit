## 1.0.2

* Updated README section.

## 1.0.1

* Increased default amplitude for `rotate` type for a more visible wiggle out of the box.

## 1.0.0

* Initial release.
* `WiggleKit` widget wraps any child with a wiggle animation.
* 7 animation types: `rotate`, `shake`, `bounce`, `pulse`, `swing`, `jello`, `spin`.
* `amplitude` parameter to control intensity of the animation.
* `duration` parameter to control the speed of each cycle.
* `count` parameter to limit the number of wiggle cycles (null = infinite).
* `WiggleController` to trigger animations programmatically.
* After a finite count completes, the widget returns to its original position.
