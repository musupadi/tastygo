import 'package:flutter/material.dart';
import 'package:tastygo/Constant/Colors.dart';

import '../Tensorflow/models/screen_params.dart';
import '../Tensorflow/ui/detector_widget.dart';

class Scanner2 extends StatefulWidget {
  const Scanner2({super.key});

  @override
  State<Scanner2> createState() => _Scanner2State();
}

class _Scanner2State extends State<Scanner2> {
  @override
  Widget build(BuildContext context) {
    ScreenParams.screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      key: GlobalKey(),
      backgroundColor: PrimaryColors(),
      appBar: AppBar(
        title: const Text('TastyGo Scanner', style: TextStyle(color: Colors.white)),
      ),
      body: const DetectorWidget(),
    );
  }
}
