// ignore_for_file: unused_import, prefer_const_constructors

import 'package:fs_dart/halaman/settings/halaman_awal.dart';
import 'package:fs_dart/halaman/settings/settings.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fs_dart/halaman/contoh/wrap.dart';
import 'halaman/contoh/contoh-slider-horizontal.dart';
import 'package:fs_dart/halaman/order/order.dart';
import 'package:fs_dart/halaman/edit/filter.dart';
import 'halaman/awal/halaman_awal.dart';
import 'halaman/foto-sesi/foto_sesi.dart';
import 'halaman/foto-sesi/qr_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'halaman/edit/qr_scan.dart';

// custom scroll behavior class untuk scroll dengan pointerdevicekind touch / mouse
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  // Use it only after calling `hiddenWindowAtLaunch`
  windowManager.waitUntilReadyToShow().then((_) async {
    // Hide window title bar
    // await windowManager.setTitleBarStyle('hidden');
    await windowManager.setFullScreen(true);
    await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1920, 1080),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(
    MaterialApp(
      scrollBehavior:
          MyCustomScrollBehavior(), // add custom scroll behavior class pada material app main app untuk dipakai global
      theme: ThemeData.light(),
      home: HalamanAwal(), // ubah route dengan mengetik halaman
    ),
  );
}
