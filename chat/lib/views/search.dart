import 'package:chat/helper/constants.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/conversation_screen.dart';
import 'package:chat/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethoda databaseMethods = new DatabaseMethoda();

  TextEditingController searchtextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchtextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  createChatRoomsStartConvo({String userName}) {

    String chatRoomId=getChatRoomId(userName, Constants.myName);

    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomsId": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId,chatRoomMap);
    Navigator.push(context, MaterialPageRoute(
      builder: (context)=> ConversationScreen()
    ));
  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              userName,
              style: simpleTextStyle(),
            ),
            Text(
              userEmail,
              style: simpleTextStyle(),
            )
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            createChatRoomsStartConvo(userName:userName);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(13)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text("Message"),
          ),
        ),
      ]),
    );
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot.documents[index].data['name'],
                userEmail: searchSnapshot.documents[index].data['email'],
              );
            },
          )
        : Container(
            child: CircularProgressIndicator(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            color: Color(0x54FFFFFF),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: searchtextEditingController,
                  decoration: InputDecoration(
                    hintText: "Search Username",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(8),
                      child: Image.asset("assets/images/search_white.png")),
                ),
              ],
            ),
          ),
          searchList(),
        ],
      )),
    );
  }
}

getChatRoomId(String a,String b){
  if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else{
    return "$a\_$b";
  }
}
