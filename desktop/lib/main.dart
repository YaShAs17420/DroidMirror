import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const DroidMirrorApp());
}

class DroidMirrorApp extends StatelessWidget {
  const DroidMirrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DroidMirror',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: DroidMirrorHomePage.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: DroidMirrorHomePage.accent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const DroidMirrorHomePage(),
    );
  }
}

class DroidMirrorHomePage extends StatelessWidget {
  const DroidMirrorHomePage({super.key});

  static const Color background = Color(0xFF0B0D12);
  static const Color panel = Color(0xFF141820);
  static const Color border = Color(0xFF282E39);
  static const Color accent = Color(0xFF65D6AD);
  static const Color muted = Color(0xFF929BAA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact =
                      constraints.maxWidth < 1000 ||
                      constraints.maxHeight < 650;

                  if (compact) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildConnectionPanel(),
                          const SizedBox(height: 20),
                          SizedBox(height: 650, child: _buildPhonePreview()),
                          const SizedBox(height: 20),
                          _buildNavigationPanel(),
                          const SizedBox(height: 20),
                          _buildInfoPanel(),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 250,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildConnectionPanel(),
                                const SizedBox(height: 18),
                                _buildNavigationPanel(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(child: _buildPhonePreview()),
                        const SizedBox(width: 24),
                        SizedBox(
                          width: 220,
                          child: SingleChildScrollView(
                            child: _buildInfoPanel(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 16 : 26,
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF10131A),
            border: Border(bottom: BorderSide(color: border)),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.phone_android_rounded,
                  color: accent,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DroidMirror',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (!compact) ...[
                      const SizedBox(height: 3),
                      const Text(
                        'ANDROID REMOTE CONTROL',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 9,
                          color: muted,
                          letterSpacing: 1.7,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 9 : 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF24202A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: border),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 8, color: Color(0xFFFFC477)),
                    SizedBox(width: 7),
                    Text(
                      'Not connected',
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildConnectionPanel() {
    return _panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('CONNECTION'),
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(Icons.usb_rounded, color: accent, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'USB connection',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Connect an Android phone using a USB cable.',
            style: TextStyle(color: muted, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: null,
              icon: const Icon(Icons.link_rounded, size: 18),
              label: const Text(
                'Connect device',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                disabledBackgroundColor: const Color(0xFF29332F),
                disabledForegroundColor: muted,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Connection support will be added in a later milestone.',
            style: TextStyle(color: muted, fontSize: 10, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationPanel() {
    return _panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('PHONE CONTROLS'),
          const SizedBox(height: 16),
          _navigationButton(Icons.arrow_back_rounded, 'Back'),
          const SizedBox(height: 8),
          _navigationButton(Icons.circle_outlined, 'Home'),
          const SizedBox(height: 8),
          _navigationButton(Icons.crop_square_rounded, 'Recent Apps'),
          const SizedBox(height: 12),
          const Text(
            'Controls become available after a device is connected.',
            style: TextStyle(color: muted, fontSize: 10, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _navigationButton(IconData icon, String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2029),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: muted),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: muted),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.lock_outline_rounded, size: 14, color: muted),
        ],
      ),
    );
  }

  Widget _buildPhonePreview() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < 300;

              return Row(
                children: [
                  const Icon(Icons.smartphone_rounded, color: accent, size: 19),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Device preview',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    narrow ? 'IDLE' : 'USB - IDLE',
                    style: const TextStyle(
                      color: muted,
                      fontSize: 10,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const phoneAspectRatio = 9 / 19.5;

                final availableWidth = math.max(0.0, constraints.maxWidth);
                final availableHeight = math.max(0.0, constraints.maxHeight);

                final phoneWidth = math.min(
                  availableWidth,
                  math.min(280.0, availableHeight * phoneAspectRatio),
                );

                final phoneHeight = phoneWidth / phoneAspectRatio;

                if (phoneWidth <= 0 || phoneHeight <= 0) {
                  return const SizedBox.shrink();
                }

                return Center(
                  child: SizedBox(
                    width: phoneWidth,
                    height: phoneHeight,
                    child: _buildPhoneFrame(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'No device connected',
            style: TextStyle(color: muted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneFrame() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF07090D),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: const Color(0xFF454B57), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 24,
            spreadRadius: 1,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final smallPhone = constraints.maxHeight < 300;

            return Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 75,
                  height: 19,
                  decoration: BoxDecoration(
                    color: const Color(0xFF20242D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.phone_android_rounded,
                  size: smallPhone ? 30 : 43,
                  color: const Color(0xFF4A5362),
                ),
                SizedBox(height: smallPhone ? 8 : 17),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Ready when you are',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: smallPhone ? 4 : 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Connect your Android phone to begin.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, height: 1.5, color: muted),
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Icon(
                    Icons.horizontal_rule_rounded,
                    size: 34,
                    color: Color(0xFF555C68),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('SESSION'),
              const SizedBox(height: 18),
              _infoRow('Device', 'None'),
              const SizedBox(height: 14),
              _infoRow('Transport', 'USB'),
              const SizedBox(height: 14),
              _infoRow('Streaming', 'Inactive'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('UP NEXT'),
              const SizedBox(height: 14),
              _featureRow(Icons.cast_connected_rounded, 'Screen streaming'),
              const SizedBox(height: 13),
              _featureRow(Icons.touch_app_rounded, 'Mouse & gestures'),
              const SizedBox(height: 13),
              _featureRow(Icons.keyboard_alt_outlined, 'Keyboard input'),
              const SizedBox(height: 13),
              _featureRow(Icons.phonelink_lock_rounded, 'Screen-off control'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 16 : 26,
            vertical: 13,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF10131A),
            border: Border(top: BorderSide(color: border)),
          ),
          child: compact
              ? const Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _FooterStatus(),
                    Text(
                      'ANDROID FIRST - USB FIRST',
                      style: TextStyle(
                        fontSize: 9,
                        color: muted,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                )
              : const Row(
                  children: [
                    _FooterStatus(),
                    Spacer(),
                    Text(
                      'ANDROID FIRST - USB FIRST',
                      style: TextStyle(
                        fontSize: 9,
                        color: muted,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _panel({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: border),
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 10,
        color: muted,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: muted),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _featureRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 17, color: accent),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 11, color: muted),
          ),
        ),
      ],
    );
  }
}

class _FooterStatus extends StatelessWidget {
  const _FooterStatus();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 7, color: DroidMirrorHomePage.accent),
        SizedBox(width: 9),
        Text(
          'DroidMirror is ready',
          style: TextStyle(fontSize: 11, color: DroidMirrorHomePage.muted),
        ),
      ],
    );
  }
}
