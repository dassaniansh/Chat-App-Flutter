import 'package:chat/helper/authenticate.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/helper/helperFunctions.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/views/search.dart';
import 'package:flutter/material.dart';

class ChatRooms extends StatefulWidget {

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  AuthMethods authMethods=new AuthMethods();

  @override
  void initState() {
    getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  getUserInfo()async{
    Constants.myName=await HelperFunctions.getUserNameSharedPrefrence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 55.0,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
        },
      ),
    );
  }
}
