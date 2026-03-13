import 'dart:math';

import 'package:flutter/widgets.dart';

enum WiggleType { rotate, shake, bounce, pulse, swing, jello, spin }

class WiggleController {
  _WiggleKitState? _state;

  void _attach(_WiggleKitState state) => _state = state;
  void _detach() => _state = null;

  void start() => _state?._startAnimation();
}

class WiggleKit extends StatefulWidget {
  const WiggleKit({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.type = WiggleType.rotate,
    this.count,
    this.controller,
    this.amplitude = 1.0,
  });

  final Widget child;
  final Duration duration;
  final WiggleType type;
  final int? count;
  final WiggleController? controller;
  final double amplitude;

  @override
  State<WiggleKit> createState() => _WiggleKitState();
}

class _WiggleKitState extends State<WiggleKit>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _cycleCount = 0;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _setupAnimation();
    if (widget.controller != null) {
      widget.controller!._attach(this);
    } else {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _cycleCount = 0;
    _controller.removeStatusListener(_onStatus);
    setState(() => _finished = false);
    if (widget.count == null) {
      _controller.repeat(reverse: widget.type != WiggleType.spin);
    } else {
      _controller.addStatusListener(_onStatus);
      _controller.forward();
    }
  }

  void _onStatus(AnimationStatus status) {
    if (widget.type == WiggleType.spin) {
      if (status == AnimationStatus.completed) {
        _cycleCount++;
        if (_cycleCount < widget.count!) {
          _controller.forward(from: 0);
        } else {
          _controller.removeStatusListener(_onStatus);
          setState(() => _finished = true);
        }
      }
    } else {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _cycleCount++;
        if (_cycleCount < widget.count!) {
          _controller.forward();
        } else {
          _controller.removeStatusListener(_onStatus);
          setState(() => _finished = true);
        }
      }
    }
  }

  void _setupAnimation() {
    final a = widget.amplitude;
    _animation = switch (widget.type) {
      WiggleType.rotate => Tween(
        begin: -0.05 * a * 2.5,
        end: 0.05 * a * 2.5,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      WiggleType.spin => Tween(
        begin: 0.0,
        end: 2 * pi,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear)),
      WiggleType.shake => Tween(
        begin: -5.0 * a,
        end: 5.0 * a,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      WiggleType.bounce => Tween(
        begin: 0.0,
        end: -10.0 * a,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      WiggleType.pulse => Tween(
        begin: 1.0 - 0.05 * a,
        end: 1.0 + 0.05 * a,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      WiggleType.swing => Tween(
        begin: -0.1 * a,
        end: 0.1 * a,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      WiggleType.jello => Tween(begin: -0.05 * a, end: 0.05 * a).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
      ),
    };
  }

  @override
  void didUpdateWidget(WiggleKit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(this);
    }
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.type != widget.type ||
        oldWidget.duration != widget.duration ||
        oldWidget.amplitude != widget.amplitude) {
      _setupAnimation();
    }
    if (oldWidget.count != widget.count) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) return widget.child;
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return switch (widget.type) {
          WiggleType.rotate => Transform.rotate(
            angle: _animation.value,
            child: child,
          ),
          WiggleType.shake => Transform.translate(
            offset: Offset(_animation.value, 0),
            child: child,
          ),
          WiggleType.bounce => Transform.translate(
            offset: Offset(0, _animation.value),
            child: child,
          ),
          WiggleType.pulse => Transform.scale(
            scale: _animation.value,
            child: child,
          ),
          WiggleType.swing => Transform.rotate(
            angle: _animation.value,
            alignment: Alignment.topCenter,
            child: child,
          ),
          WiggleType.jello => Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(
              1.0 + _animation.value,
              1.0 - _animation.value,
              1.0,
            ),
            child: child,
          ),
          WiggleType.spin => Transform.rotate(
            angle: _animation.value,
            child: child,
          ),
        };
      },
    );
  }
}
