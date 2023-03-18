import 'dart:io';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Anidex',
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: const Color.fromARGB(255, 30, 29, 25),
          primaryColor: Color(0xFF8F43EE)
        ),
        home: HomePage(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  var current = "hello";
  /*void getResults() async {
    try {
    var response = await http.post('https://json.flutter.su/echo', body: {'name':'test','num':'10'});
    }
    exept
  }*/
  Future<bool> checkForInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    if (UniversalPlatform.isAndroid | UniversalPlatform.isIOS) {
      if (appState.checkForInternet() != true) {
        // show no connection screen
      }
    }
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo.png"),
            if (UniversalPlatform.isDesktopOrWeb) ...[
              SizedBox(
                height: 14,
              ),
              Text(
                "Just another anime search engine",
                style: GoogleFonts.inter()
              ),
            ],
            SizedBox(
                height: 37,
              ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                style: TextStyle(color: Color(0xFFF5F5F5)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF272621),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF8F43EE)),
                  hintText: 'Врата Штейна',
                  hintStyle: GoogleFonts.inter(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w200,
                    textStyle: TextStyle(color: Color(0xFFF5F5F5).withOpacity(0.6))
                  )
                ),
              ),
              ),
            ),
            SizedBox(
              height: 37,
            ),
          ]),
    );
  }
}
