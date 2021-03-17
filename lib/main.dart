import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/girissayfasi.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personelim',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GirisSayfasi(),
      debugShowCheckedModeBanner: false,
    );
  }
}
