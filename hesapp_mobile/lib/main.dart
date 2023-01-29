import 'package:flutter/material.dart';
import 'package:hesapp_mobile/view/profile_page.dart';
import 'package:hesapp_mobile/view/log_in_page.dart';
import 'package:hesapp_mobile/view/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LogInPage(),
    );
  }
}




