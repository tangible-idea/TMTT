import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:tmtt/pages.dart';

void main() {
  runApp(MyTmttApp());
}

class MyTmttApp extends StatelessWidget {

  MyTmttApp({super.key});

  var theme = ThemeData(
    fontFamily: 'Notosans',
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {

    // 앱 세로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      locale: Get.deviceLocale, // 언어 설정
      getPages: kGetPages,
      initialRoute: PageName.splash,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _instagramID = "";
  TextEditingController _idController = new TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
              controller: _idController,
              onTap: () {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    _idController!.text = "";
                  },
                ),
                filled: true,
              ),
            ),

            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),

            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
