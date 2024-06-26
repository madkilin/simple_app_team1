import 'package:flutter/material.dart';
import 'package:simple_app_team1/add_user.dart';
import 'package:simple_app_team1/directory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DirectoryPage(),
        '/add_user': (context) => AddUserPage(),
      },
    );
  }
}
