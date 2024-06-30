import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoapp/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          primaryColor: Colors.yellow,
          floatingActionButtonTheme:
           const   FloatingActionButtonThemeData(backgroundColor: Colors.yellow),
          appBarTheme:const AppBarTheme(backgroundColor: Colors.yellow)),
      home:const HomePage(),
    );
  }
}
