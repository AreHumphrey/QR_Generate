import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

class QRDisplayScreen extends StatefulWidget {
  final String url;

  QRDisplayScreen(this.url);

  @override
  _QRDisplayScreenState createState() => _QRDisplayScreenState();
}

class _QRDisplayScreenState extends State<QRDisplayScreen> {
  GlobalKey globalKey = GlobalKey();

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary? boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          Uint8List pngBytes = byteData.buffer.asUint8List();

          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;
          File file = File('$tempPath/image.png');
          await file.writeAsBytes(pngBytes);

          await Share.shareFiles(['$tempPath/image.png'], text: 'QR Code');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: QrImageView(data: widget.url),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                _captureAndSharePng();
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 144, 0, 32)),
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(25)),
              ),
              child: Icon(
                Icons.download,
                color: Colors.white,
                size: 35,
              ),
            )

          ],
        ),
      ),
    );
  }
}
