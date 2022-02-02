import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          Screenshot(
            controller: _screenshotController,
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset('images/day2.jpeg'),
                  Text(
                    'Code Passionately',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
          ),
          TextButton(
            child: Text('Take Screenshot and Share'),
            onPressed: _takeScreenshot,
          )
        ]))));
  }

  Future<void> _takeScreenshot() async {
    final _path = (await getApplicationDocumentsDirectory()).path;
    String fileName = 'my_screenshot.jpg';

    final _myScreenShotPath = await _screenshotController.captureAndSave(
      _path, //set path where screenshot will be saved
      fileName: fileName,
    );

    print("path of screenshot: $_myScreenShotPath");

    Share.shareFiles([_myScreenShotPath!], text: "Shared from #FlutterApp");
  }
}
