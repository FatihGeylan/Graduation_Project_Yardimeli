import 'package:flutter/material.dart';
import 'package:yardimeliflutter/pages/LoginPage.dart';

import 'API/ModelOganization.dart';
import 'API/OrganizationApiService.dart';
import 'HomeScreen.dart';
import 'pages/OrganizationPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ThemeData().colorScheme.copyWith(primary: const Color(0xff7f0000)),
      ),
      home: const LoginPage(),
    );
  }
}

