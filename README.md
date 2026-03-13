<div align="center">

# wiggle_kit

**Add delightful wiggle animations to any Flutter widget in one line.**

[![pub version](https://img.shields.io/pub/v/wiggle_kit.svg)](https://pub.dev/packages/wiggle_kit)
[![likes](https://img.shields.io/pub/likes/wiggle_kit)](https://pub.dev/packages/wiggle_kit/score)
[![popularity](https://img.shields.io/pub/popularity/wiggle_kit)](https://pub.dev/packages/wiggle_kit/score)
[![license](https://img.shields.io/github/license/NesanSelvan/wiggle_kit)](LICENSE)

</div>

---

## 🎬 Preview

<table>
  <tr>
    <td align="center"><b>All wiggle types</b></td>
    <td align="center"><b>Amplitude & speed</b></td>
    <td align="center"><b>Tap to trigger</b></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/NesanSelvan/wiggle_kit/main/media/1.gif" width="220"/></td>
    <td><img src="https://raw.githubusercontent.com/NesanSelvan/wiggle_kit/main/media/2.gif" width="220"/></td>
    <td><img src="https://raw.githubusercontent.com/NesanSelvan/wiggle_kit/main/media/3.gif" width="220"/></td>
  </tr>
</table>

---

## ✨ Features

- **7 animation types** — rotate, shake, bounce, pulse, swing, jello, spin
- **Amplitude control** — dial up or down how intense the wiggle is
- **Speed control** — set how fast each cycle runs
- **Finite or infinite** — loop forever or stop after N cycles
- **Manual trigger** — fire the animation from anywhere with `WiggleController`
- **Auto reset** — returns to original position after a finite animation ends
- **Universal** — wraps any widget: buttons, icons, cards, dialogs, and more
- **Haptic feedback** — optionally pair any wiggle with a haptic tap via `WiggleHapticConfig`
- **Zero config** — haptic is opt-in, existing usage is unchanged

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  wiggle_kit: ^1.0.4
```

Then run:

```sh
flutter pub get
```

---

## 🚀 Quick start

```dart
import 'package:wiggle_kit/wiggle_kit.dart';

WiggleKit(
  type: WiggleType.shake,
  child: Icon(Icons.notifications),
)
```

---

## 🛠️ Usage

### Infinite loop

```dart
WiggleKit(
  type: WiggleType.bounce,
  child: Icon(Icons.location_on),
)
```

### Finite count — resets after N cycles

```dart
WiggleKit(
  type: WiggleType.shake,
  count: 3,
  child: Icon(Icons.phone),
)
```

### Amplitude — control intensity

```dart
WiggleKit(
  type: WiggleType.shake,
  amplitude: 2.0, // default: 1.0
  child: Icon(Icons.phone),
)
```

### Duration — control speed

```dart
WiggleKit(
  type: WiggleType.rotate,
  duration: Duration(milliseconds: 150),
  child: Icon(Icons.settings),
)
```

### WiggleController — trigger on demand

```dart
final _controller = WiggleController();

WiggleKit(
  type: WiggleType.swing,
  count: 3,
  controller: _controller,
  child: Icon(Icons.notifications),
)

// Fire from a button, network event, timer, etc.
ElevatedButton(
  onPressed: _controller.start,
  child: Text('Wiggle'),
)
```

### Haptic feedback

Pair any wiggle with a haptic tap when the animation starts:

```dart
WiggleKit(
  type: WiggleType.shake,
  count: 3,
  hapticConfig: WiggleHapticConfig(type: FeedbackType.heavy),
  child: Icon(Icons.phone),
)
```

Works with all 10 `FeedbackType` values from [`haptic_feedback_pro`](https://pub.dev/packages/haptic_feedback_pro): `light`, `medium`, `heavy`, `soft`, `rigid`, `success`, `warning`, `error`, `selection`, `vibration`. Omit `hapticConfig` to disable haptics entirely.

### Wrap a dialog

```dart
showDialog(
  context: context,
  builder: (ctx) => WiggleKit(
    type: WiggleType.bounce,
    count: 3,
    child: AlertDialog(
      title: Text('Hello!'),
      content: Text('This dialog wiggles.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text('Close'),
        ),
      ],
    ),
  ),
);
```

---

## 🎭 Animation types

| Type | Description |
|------|-------------|
| `rotate` | Rocks left and right around the center |
| `shake` | Translates horizontally |
| `bounce` | Translates vertically |
| `pulse` | Scales in and out |
| `swing` | Rotates around the top center like a pendulum |
| `jello` | Alternates scaleX and scaleY for a squish effect |
| `spin` | Continuous 360° rotation |

---

## ⚙️ Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `child` | `Widget` | required | The widget to animate |
| `type` | `WiggleType` | `WiggleType.rotate` | Animation style |
| `duration` | `Duration` | `200ms` | Duration of each half-cycle |
| `amplitude` | `double` | `1.0` | Intensity multiplier |
| `count` | `int?` | `null` | Cycle count — `null` means infinite |
| `controller` | `WiggleController?` | `null` | Manual trigger — if provided, auto-start is disabled |
| `hapticConfig` | `WiggleHapticConfig?` | `null` | Haptic feedback on animation start — omit to disable |

---

## 🌟 Built By

Enjoyed this package? Check out the app we built it for 🚀

<p align="center">
  <a href="https://nutriscan.app/">
    <img src="https://raw.githubusercontent.com/NesanSelvan/wiggle_kit/main/media/download-banner.png" alt="Download NutriScan" width="100%" height="150"/>
  </a>
</p>

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

## 📄 License

[MIT](LICENSE)
