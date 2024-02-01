import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:watchface/clock_widget/WatchFaceAnalog02/wf_analog_02.dart';
import 'package:watchface/controller/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the system UI overlays to FullScreen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // Set watchSize value into Controller
    final GlobalController globalController =
        Get.put(GlobalController(), permanent: true);
    double widthScreenDevice = MediaQuery.of(context).size.width;
    globalController.updateWatchSize(widthScreenDevice);

    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: WatchFaceAnalog02(),
      ),
    );
  }
}
