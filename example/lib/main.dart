import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiple_permission_handler/multiple_permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _multiplePermissionHandlerPlugin = MultiplePermissionHandler();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  void requestPermission() {
    _multiplePermissionHandlerPlugin.requestAppTrackingPermission();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion =
          await _multiplePermissionHandlerPlugin.getPlatformVersion() ??
              'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => requestPermission(),
        ),
      ),
    );
  }
}
