
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_project/qr_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: URLInputScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white),
      ),
    );
  }
}

class URLInputScreen extends StatefulWidget {
  @override
  _URLInputScreenState createState() => _URLInputScreenState();
}

class _URLInputScreenState extends State<URLInputScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            Icon(
              Icons.qr_code,
              size: 200,
              color: Color.fromARGB(255, 144, 0, 32),
            ),
            Text(
              'CodeCraft',
              style: TextStyle(
                color: Color.fromARGB(255, 144, 0, 32),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 100),
            TextFormField(
              controller: _textEditingController,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintText: 'Введите ссылку',
                hintStyle: TextStyle(fontSize: 20),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                String inputText = _textEditingController.text;
                if (inputText.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRDisplayScreen(inputText),
                    ),
                  );
                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Введите ссылку'),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 144, 0, 32)),
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(25)),
              ),
              child: Icon(
                Icons.refresh,
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

