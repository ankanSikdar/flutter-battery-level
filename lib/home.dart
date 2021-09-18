import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('example.ankan.dev/battery');

  String _batteryLevel = 'Battery Level Unknown';

  Future<void> _getBatteryLevel() async {
    String batteryLevel = '';

    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level is at $result %';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_batteryLevel),
          const SizedBox(height: 16.0, width: double.infinity),
          ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level')),
        ],
      ),
    );
  }
}
