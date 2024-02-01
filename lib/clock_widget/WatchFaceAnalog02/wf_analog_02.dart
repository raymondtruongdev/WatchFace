import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../template/page_template.dart';
import 'clock_analog_02.dart';

class WatchFaceAnalog02 extends StatefulWidget {
  const WatchFaceAnalog02({super.key});

  @override
  State<WatchFaceAnalog02> createState() => _WatchFaceAnalog02State();
}

class _WatchFaceAnalog02State extends State<WatchFaceAnalog02> {
  @override
  Widget build(BuildContext context) {
    return const ClockScreen();
  }
}

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE | dd').format(now);
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageTemplate(
        child: Stack(
          children: [
            ClipOval(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'lib/clock_widget/WatchFaceAnalog02/image/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..translate(80.0, 2.0),
                    child: Text(formattedDate,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Imprima',
                            fontSize: 20)), // Clock hand image
                  ),
                  const ClockAnalog02(),
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
