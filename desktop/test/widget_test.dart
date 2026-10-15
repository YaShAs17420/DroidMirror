import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:droidmirror_desktop/main.dart';

void main() {
  testWidgets('DroidMirror app loads successfully', (
    WidgetTester tester,
  ) async {
    // Give the desktop interface enough space for its layout.
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DroidMirrorApp());

    // Allow the first frame to render without waiting for endless animations.
    await tester.pump();

    expect(find.text('DroidMirror'), findsWidgets);
    expect(find.text('USB connection'), findsOneWidget);
    expect(find.text('Device preview'), findsOneWidget);
  });
}
