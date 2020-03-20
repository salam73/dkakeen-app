import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:madayen/pages/favorites_page.dart';
import 'package:madayen/screens/HomeScreen.dart';
import 'package:madayen/services/authservice.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  FirebaseUser user2 = null;

  mydaad(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: '+4531223389',
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          //  Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;
          user2 = user;

          if (user != null) {
            setState(() {
              user2 == user;
            });
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: null,
        codeSent: null,
        codeAutoRetrievalTimeout: null);
    /*  FirebasePhoneAuth.instantiate(phoneNumber: "+4531223388");

    FirebasePhoneAuth.phoneAuthState.stream.listen((PhoneAuthState state) {
      print(state);
      if (state.index == 3)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Salam()),
        );
    });*/
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          //  Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          user2 = user;

          if (user != null) {
            setState(() {
              user2 == user;
            });
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);

          final snackBar = SnackBar(
            content: Text(exception.message),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);

          SnackBar(
              content: Text('Yay! A SnackBar!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                },
              ));
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoritesPage()));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  Widget homeWidget() {
    return Container(
      child: Text('hello'),
    );
  }

  @override
  void initState() {
    //  mydaad(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user2 == null
          ? Container(
              padding: EdgeInsets.all(32),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login to",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Mobile Number"),
                      controller: _phoneController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        child: Text("LOGIN"),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16),
                        onPressed: () {
                          final phone = _phoneController.text.trim();

                          loginUser(phone, context);
                        },
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Column(
              children: <Widget>[
                Container(child: Text(user2.phoneNumber)),
                RaisedButton(
                  child: Text('Signout'),
                  onPressed: () {
                    AuthService().signOut();
                  },
                )
              ],
            ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
