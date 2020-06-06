import 'package:chat/helper/helperFunctions.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/chatRoomsScreen.dart';
import 'package:chat/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethoda databaseMethoda = new DatabaseMethoda();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPrefrence(
          emailTextEditingController.text);
      // HelperFunctions.saveUserNameSharedPrefrence(
      //     usernameTextEditingController.text);

      setState(() {
        isLoading = true;
      });

      databaseMethoda
          .getUserByEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserEmailSharedPrefrence(
            snapshotUserInfo.documents[0].data['name']);
      });

      authMethods
          .signInwithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPrefrence(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRooms()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            appBar: appBarMain(context),
            body: Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: emailTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("email"),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.length < 4
                                  ? "This will never work"
                                  : null;
                            },
                            controller: passwordTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("Password"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(),
                      child: Text(
                        "Forgot Password",
                        style: simpleTextStyle(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: simpleTextStyle(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In with Google",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Dont have account",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        : Container(
            child: Center(
            child: CircularProgressIndicator(),
          ));
  }
}
