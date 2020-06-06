import 'package:chat/helper/authenticate.dart';
import 'package:chat/helper/helperFunctions.dart';
import 'package:chat/views/chatRoomsScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoogedInState();
    super.initState();
  }

  getLoogedInState() async {
    await HelperFunctions.getUserLoggedInSharedPrefrence().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
      ),
      home: userIsLoggedIn ? ChatRooms() : Authenticate(),
    );
  }
}
