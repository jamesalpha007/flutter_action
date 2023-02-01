import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_action/bridge_generated.dart';

const base =
    'flutter_action'; // the name is related with cargo.toml [lib] name.
final path = Platform.isWindows ? '$base.dll' : 'lib$base.so';
final dylib = Platform.isIOS
    ? DynamicLibrary.process()
    : Platform.isMacOS
        ? DynamicLibrary.executable()
        : DynamicLibrary.open(path);
final api = FlutterActionImpl(dylib);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String greetText = "Hello from nothing";
  Future<void> callSomeText() async {
    String result = await api.greetingFromRust();
    setState(() {
      greetText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    callSomeText();
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Action App'),
        ),
        body: Center(
          child: Text(greetText),
        ),
      ),
    );
  }
}
