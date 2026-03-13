## 1.0.4

* Updated README with `hapticConfig` usage and correct installation version.

## 1.0.3

* Added `hapticConfig` parameter via `WiggleHapticConfig` to trigger haptic feedback when a wiggle animation starts.
* Supports all 10 `FeedbackType` values from `haptic_feedback_pro`: `light`, `medium`, `heavy`, `soft`, `rigid`, `success`, `warning`, `error`, `selection`, `vibration`.
* Haptic is opt-in — omitting `hapticConfig` keeps existing behaviour unchanged.

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
