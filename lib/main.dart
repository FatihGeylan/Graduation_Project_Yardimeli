import 'package:flutter/material.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffe6e5ea),
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

