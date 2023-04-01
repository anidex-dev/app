import 'dart:io';
import 'dart:math';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ChangeNotifierProvider(
        create: (context) => AppState(),
        child: MaterialApp(
          title: 'Anidex',
          theme: ThemeData(
              useMaterial3: false,
              scaffoldBackgroundColor: const Color.fromARGB(255, 30, 29, 25),
              primaryColor: Color(0xFF8F43EE)),
          home: HomePage(),
        ),
      );
    });
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
  void openScreen(String name) {}
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
            if (UniversalPlatform.isDesktop | UniversalPlatform.isWeb) ...[
              SizedBox(
                height: 14,
              ),
              Text("Just another anime search engine",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                                  color: Color(0xFFF5F5F5),
                    )
                    
                    ),
              ),
            ],
            SizedBox(
              height: 27,
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
                        borderRadius: BorderRadius.circular(50),
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
                          textStyle: TextStyle(
                              color: Color(0xFFF5F5F5).withOpacity(0.6)))),
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                   width: 119,
                   height: 36, 
                  child: ElevatedButton(
                    onPressed: () {
                      appState.openScreen("results");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF8F43EE)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      )
                        )
                    ),
                    child: Text('Поиск',
                        style: GoogleFonts.pressStart2p(
                            textStyle: TextStyle(color: Color(0xFFF0EB8D)))),
                  ),
                  ),
                  SizedBox(
                    width: 26,
                  ),
                  SizedBox(
                   width: 119,
                   height: 36, 
                  child: ElevatedButton(
                    onPressed: () {
                      appState.openScreen("results");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF413543)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      )
                        )
                    ),
                    child: Text('Рандом',
                        style: GoogleFonts.pressStart2p(
                            textStyle: TextStyle(color: Color(0xFF8F43EE)))),
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 37,
            ),
          ]),
    );
  }
}
