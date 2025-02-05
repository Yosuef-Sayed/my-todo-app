import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:local/sqldb.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // SqlDB SQL = SqlDB();
  // SharedPreferences? prefs;

  @override
  void initState() {
    run();
    super.initState();
  }

  void run() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/todos"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log(data["todos"][0].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Local Database",
      home: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              run();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
            child: Text(
              "Get Data",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
