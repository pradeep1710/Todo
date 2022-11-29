import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/pages/home_page.dart';

late Box box;
void main(List<String> args) async {
  // initialize hive
  await Hive.initFlutter();
  // open a box
  box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: const Color.fromARGB(255, 254, 229, 155),
          appBarTheme: const AppBarTheme(toolbarHeight: 70, centerTitle: true),
          fontFamily: 'openSans',
          textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 18),
              titleLarge: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1))),
      home: const MyHomePage(),
    );
  }
}

