// ignore_for_file: avoid_print, must_be_immutable

import 'package:firebase_cast/ContactPage.dart';
import 'package:firebase_cast/MyHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/ContactsPage': (context) => ContactsPage(documentId: 'mom'),
        },
        title: 'Flutter Firebase Cast v1',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: _fbApp,
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                print('you have an error! ${snapshot.error.toString()}');
                return const Text("Something went wrong!");
              } else if (snapshot.hasData) {
                return const MyHomePage();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })));
  }
}
