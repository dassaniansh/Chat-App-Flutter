import 'package:chat/helper/helperFunctions.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/chatRoomsScreen.dart';
import 'package:chat/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethoda databaseMethods=new DatabaseMethoda();

  final formkey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signMeUp() {

    Map<String,String> userInfoMap={
          "name": usernameTextEditingController.text,
          "email": emailTextEditingController.text,
        };

    HelperFunctions.saveUserEmailSharedPrefrence(emailTextEditingController.text);
    HelperFunctions.saveUserNameSharedPrefrence(usernameTextEditingController.text);
        
    if (formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpwithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        print("$val"); 

        databaseMethods.uploadUserInfo(userInfoMap);

    HelperFunctions.saveUserLoggedInSharedPrefrence(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRooms()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Form(
                            key: formkey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  validator: (val) {
                                    return val.isEmpty || val.length < 4
                                        ? "This will never work"
                                        : null;
                                  },
                                  controller: usernameTextEditingController,
                                  style: simpleTextStyle(),
                                  decoration:
                                      textFieldInputDecoration("username"),
                                ),
                                TextFormField(
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
                                  decoration:
                                      textFieldInputDecoration("Password"),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(),
                        //   child: Text(
                        //     "Forgot Password",
                        //     style: simpleTextStyle(),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 25,
                        // ),
                        GestureDetector(
                          onTap: () {
                            signMeUp();
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
                                "Sign up",
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
                              "Sign up",
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
                              "Already have account",
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
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
