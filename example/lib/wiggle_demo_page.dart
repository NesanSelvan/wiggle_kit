import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:haptic_feedback_pro/haptic_feedback_pro.dart';
import 'package:wiggle_kit/wiggle_kit.dart';

class WiggleDemoPage extends StatefulWidget {
  const WiggleDemoPage({super.key});

  @override
  State<WiggleDemoPage> createState() => _WiggleDemoPageState();
}

class _WiggleDemoPageState extends State<WiggleDemoPage> {
  final Map<WiggleType, WiggleController> _controllers = {
    for (final type in WiggleType.values) type: WiggleController(),
  };

  final Map<FeedbackType, WiggleController> _hapticControllers = {
    for (final type in [
      FeedbackType.light,
      FeedbackType.medium,
      FeedbackType.heavy,
      FeedbackType.soft,
      FeedbackType.rigid,
      FeedbackType.success,
      FeedbackType.warning,
      FeedbackType.error,
      FeedbackType.selection,
    ])
      type: WiggleController(),
  };

  static const _meta = {
    WiggleType.rotate: (
      icon: Icons.settings_rounded,
      color: Color(0xFF6C63FF),
      bg: Color(0xFFEEEDFF),
      label: 'Settings gear',
      desc: 'Rocks left and right',
    ),
    WiggleType.shake: (
      icon: Icons.phone_android_rounded,
      color: Color(0xFFE53935),
      bg: Color(0xFFFFEBEE),
      label: 'Vibrating phone',
      desc: 'Moves side to side',
    ),
    WiggleType.bounce: (
      icon: Icons.location_on_rounded,
      color: Color(0xFF43A047),
      bg: Color(0xFFE8F5E9),
      label: 'Location pin',
      desc: 'Bounces up and down',
    ),
    WiggleType.pulse: (
      icon: Icons.favorite_rounded,
      color: Color(0xFFE91E63),
      bg: Color(0xFFFCE4EC),
      label: 'Heart beat',
      desc: 'Scales in and out',
    ),
    WiggleType.swing: (
      icon: Icons.notifications_rounded,
      color: Color(0xFFF57C00),
      bg: Color(0xFFFFF3E0),
      label: 'Bell swing',
      desc: 'Swings like a pendulum',
    ),
    WiggleType.jello: (
      icon: Icons.emoji_emotions_rounded,
      color: Color(0xFF00ACC1),
      bg: Color(0xFFE0F7FA),
      label: 'Emoji squish',
      desc: 'Stretches and squishes',
    ),
    WiggleType.spin: (
      icon: Icons.refresh_rounded,
      color: Color(0xFF8E24AA),
      bg: Color(0xFFF3E5F5),
      label: 'Loading spin',
      desc: 'Rotates 360°',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WiggleKit'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          const _SectionHeader('All types'),
          const SizedBox(height: 12),
          ...WiggleType.values.map((type) {
            final m = _meta[type]!;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _DemoCard(
                child: Row(
                  children: [
                    WiggleKit(
                      type: type,
                      duration: type == WiggleType.rotate
                          ? const Duration(milliseconds: 80)
                          : const Duration(milliseconds: 200),
                      amplitude: type == WiggleType.rotate ? 2 : 1.0,
                      child: _IconWidget(
                        icon: m.icon,
                        color: m.color,
                        bg: m.bg,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.label,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            m.desc,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: m.bg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        type.name,
                        style: TextStyle(
                          fontSize: 11,
                          color: m.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 28),
          const _SectionHeader('Amplitude · shake'),
          const SizedBox(height: 12),
          _DemoCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [0.5, 1.0, 2.0, 3.0].map((a) {
                return Column(
                  children: [
                    WiggleKit(
                      type: WiggleType.shake,
                      amplitude: a,
                      child: _IconWidget(
                        icon: _meta[WiggleType.shake]!.icon,
                        color: _meta[WiggleType.shake]!.color,
                        bg: _meta[WiggleType.shake]!.bg,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${a}x',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 28),
          const _SectionHeader('Speed · bounce'),
          const SizedBox(height: 12),
          _DemoCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [100, 300, 600, 1000].map((ms) {
                return Column(
                  children: [
                    WiggleKit(
                      type: WiggleType.bounce,
                      duration: Duration(milliseconds: ms),
                      child: _IconWidget(
                        icon: _meta[WiggleType.bounce]!.icon,
                        color: _meta[WiggleType.bounce]!.color,
                        bg: _meta[WiggleType.bounce]!.bg,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${ms}ms',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 28),
          const _SectionHeader('Tap to trigger · count: 3'),
          const SizedBox(height: 12),
          ...WiggleType.values.map((type) {
            final m = _meta[type]!;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _DemoCard(
                child: Row(
                  children: [
                    WiggleKit(
                      type: type,
                      count: 3,
                      controller: _controllers[type],
                      child: _IconWidget(
                        icon: m.icon,
                        color: m.color,
                        bg: m.bg,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        m.label,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    FilledButton.tonal(
                      onPressed: _controllers[type]!.start,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(56, 34),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: m.bg,
                        foregroundColor: m.color,
                      ),
                      child: const Text('Play', style: TextStyle(fontSize: 13)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () => _showDialog(context, type),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(64, 34),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: m.color,
                        side: BorderSide(color: m.color.withValues(alpha: 0.4)),
                      ),
                      child: const Text(
                        'Dialog',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 28),
          const _SectionHeader('Haptic feedback · tap to feel'),
          const SizedBox(height: 12),
          ..._hapticControllers.entries.map((entry) {
            final feedbackType = entry.key;
            final controller = entry.value;
            final (color, bg) = _hapticMeta[feedbackType]!;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _DemoCard(
                child: Row(
                  children: [
                    WiggleKit(
                      type: WiggleType.shake,
                      count: 2,
                      controller: controller,
                      hapticConfig: WiggleHapticConfig(type: feedbackType),
                      child: _IconWidget(
                        icon: Icons.vibration_rounded,
                        color: color,
                        bg: bg,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        feedbackType.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    FilledButton.tonal(
                      onPressed: controller.start,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(56, 34),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: bg,
                        foregroundColor: color,
                      ),
                      child: const Text('Play', style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static const _hapticMeta = {
    FeedbackType.light: (Color(0xFF78909C), Color(0xFFECEFF1)),
    FeedbackType.medium: (Color(0xFF42A5F5), Color(0xFFE3F2FD)),
    FeedbackType.heavy: (Color(0xFF5C6BC0), Color(0xFFE8EAF6)),
    FeedbackType.soft: (Color(0xFF26A69A), Color(0xFFE0F2F1)),
    FeedbackType.rigid: (Color(0xFF7E57C2), Color(0xFFEDE7F6)),
    FeedbackType.success: (Color(0xFF43A047), Color(0xFFE8F5E9)),
    FeedbackType.warning: (Color(0xFFFB8C00), Color(0xFFFFF8E1)),
    FeedbackType.error: (Color(0xFFE53935), Color(0xFFFFEBEE)),
    FeedbackType.selection: (Color(0xFFF57C00), Color(0xFFFFF3E0)),
  };

  void _showDialog(BuildContext context, WiggleType type) {
    final m = _meta[type]!;
    showDialog(
      context: context,
      builder: (ctx) => WiggleKit(
        type: type,
        count: 3,
        child: AlertDialog(
          title: Row(
            children: [
              _IconWidget(icon: m.icon, color: m.color, bg: m.bg, size: 36),
              const SizedBox(width: 12),
              Text(m.label),
            ],
          ),
          content: Text(m.desc),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget({
    required this.icon,
    required this.color,
    required this.bg,
    this.size = 44,
  });
  final IconData icon;
  final Color color;
  final Color bg;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.black38,
        letterSpacing: 0.8,
      ),
    );
  }
}
