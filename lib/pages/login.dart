import 'package:ecommerceapp/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';
import 'sign_up.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  SharedPreferences sharedPreferences;
  bool loading = false;
  bool isLogedIn = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();

  }

  void isSignedIn() async{
     setState(() {
       loading = true;
     });
     sharedPreferences = await SharedPreferences.getInstance();
     isLogedIn = await googleSignIn.isSignedIn();
     if(isLogedIn){
       Navigator.pushReplacement(context, MaterialPageRoute(
         builder: (context)=> HomePage(),
       ));
     }

     setState(() {
       loading = false;
     });
  }

  Future handleSign() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    FirebaseUser user = (await auth.signInWithCredential(credential)).user;

    if(user != null){
       final QuerySnapshot result = await Firestore.instance.collection("users").where("id",isEqualTo: user.uid).getDocuments();
       final List<DocumentSnapshot> documents = result.documents;
       if(documents.length == 0){
       // insert user to our collection
         Firestore.instance.collection("users").document(user.uid)
             .setData({
           "id":user.uid,
           "username":user.displayName,
           "profilePicture":user.photoUrl
         });
         await sharedPreferences.setString("id", user.uid);
         await sharedPreferences.setString("username", user.displayName);
         await sharedPreferences.setString("photoUrl", user.photoUrl);
       }else{
         await sharedPreferences.setString("id", documents[0]['id']);
         await sharedPreferences.setString("username", documents[0]['username']);
         await sharedPreferences.setString("photoUrl", documents[0]['photoUrl']);
       }
       
       Fluttertoast.showToast(msg: "Login was successful");
       setState(() {
         loading = false;
       });
       Navigator.pushReplacement(context, MaterialPageRoute(
         builder: (context)=> HomePage(),
       ));
    }else{
      Fluttertoast.showToast(msg: "Login failed");
    }
  }

  Future<FirebaseUser> _handleSignIn2() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }



  @override
  Widget build(BuildContext context) {
   // const double pad = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('images/fashion2.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
              child: Image.asset('images/lg.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width/4,
                height: MediaQuery.of(context).size.width/4,
              ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                        key: _formKey,
                          child: Flex(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Material (
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:12.0),
                                    child: TextFormField(
                                      controller: _emailTextController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        //border: InputBorder.none,
                                        //border: OutlineInputBorder(),
                                        hintText: "Email *",
                                        icon: Icon(Icons.alternate_email)
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(value))
                                            return 'Please make sure your email address is valid';
                                          else
                                            return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Material (
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:12.0),
                                    child: TextFormField(
                                      controller: _passwordTextController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "Password *",
                                          icon: Icon(Icons.lock_outline)
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Password field cannot empty !!!';
                                        }else if(value.length<6){
                                          return 'Password has to be at least 6 characters long';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Material (
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.blue.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:12.0),
                                    child: MaterialButton(
                                      minWidth: MediaQuery.of(context).size.width,
                                      child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                                      onPressed: (){},
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Forgot password",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => SignUp()));
                                          },
                                          child: Text(
                                            "Sign up",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.red.withOpacity(0.8),fontWeight: FontWeight.bold),
                                          ))),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:20.0),
                                child: Divider(color: Colors.white,),
                              ),
                              Text("Other login in option",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Material (
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.red.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:12.0),
                                    child: MaterialButton(
                                      minWidth: MediaQuery.of(context).size.width,
                                      child: Text("Google",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                                      onPressed: (){
                                        handleSign();
                                      },
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ), ),
            ],
          ),




          Visibility(
            visible: loading ?? true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _signInButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.red.withOpacity(0.8),
      color: Colors.red.withOpacity(0.8),
      onPressed: () {
        handleSign();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Google', style: TextStyle(fontSize: 20, color: Colors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }


}



