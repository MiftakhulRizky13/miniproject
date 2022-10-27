import 'package:expensetracker/homepage/google_sheets_api.dart';
import 'package:expensetracker/splash.dart';
import 'package:flutter/material.dart';



void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
