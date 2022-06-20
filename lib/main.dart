import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/pages/LoginPage.dart';

import 'Model/ModelOganization.dart';
import 'API/OrganizationApiService.dart';
import 'HomeScreen.dart';
import 'pages/OrganizationPage.dart';
import 'package:dcdg/dcdg.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Color(0xffededed),
        colorScheme: ThemeData().colorScheme.copyWith(primary: const Color(0xff7f0000)),
      ),
      home: const LoginPage(),
    );
  }
}

