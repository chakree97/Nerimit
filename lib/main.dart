import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies/db/summary.dart';
import 'package:movies/screens/home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String MyBox = "Summary";
Future<void> main() async{
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(summaryAdapter());
  await Hive.openBox<summary>(MyBox);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark, 
      home: Home(),
    );
  }
}
