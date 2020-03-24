import 'package:ecommerceapp/models/person.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerceapp/db/users.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("personnes");

  TextEditingController _nameTextController;
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;
  TextEditingController _passwordConfirmTextController;
  UserServices _userServices ;
  String gender;
  String groupValue = "male";
  bool loading = false;
  bool hidePass = true;
  bool hideConfirmPass = true;
  String errorMessage="";

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _passwordConfirmTextController = TextEditingController();
    _userServices = UserServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/fashion2.jpg',
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
            padding: const EdgeInsets.only(top: 50.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          controller: _nameTextController,
                          decoration: InputDecoration(
                              hintText: "Full Name*",
                              border: InputBorder.none,
                              icon: Icon(Icons.person_outline)),
                          validator: validateFullName,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              //border: OutlineInputBorder(),
                              hintText: "Email *",
                              icon: Icon(Icons.alternate_email)),
                          // ignore: missing_return
                          validator: emailValidator,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                            controller: _passwordTextController,
                            obscureText: hidePass,
                            decoration: InputDecoration(
                                hintText: "Password *",
                                suffixIcon: GestureDetector(
                                  dragStartBehavior: DragStartBehavior.down,
                                   onTap: (){
                                    setState(() {
                                      hidePass = !hidePass;
                                    });
                                   },
                                  child: Icon(hidePass ? Icons.visibility :Icons.visibility_off,semanticLabel: hidePass ?"Montrer mot de passe":"Masquer mot de passe",),

                                ),
                                border: InputBorder.none,
                                icon: Icon(Icons.lock_outline)),
                            validator: validatePassword,
                          ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                            controller: _passwordConfirmTextController,
                            obscureText: hideConfirmPass,
                            decoration: InputDecoration(
                                hintText: "Confirm Password *",
                                suffixIcon: GestureDetector(
                                  dragStartBehavior: DragStartBehavior.down,
                                  onTap: (){
                                    setState(() {
                                      hideConfirmPass = !hideConfirmPass;
                                    });
                                  },
                                  child: Icon(hideConfirmPass ? Icons.visibility :Icons.visibility_off,semanticLabel: hideConfirmPass ?"Montrer mot de passe":"Masquer mot de passe",),

                                ),
                                border: InputBorder.none,
                                icon: Icon(Icons.lock_outline)),
                            validator: validateConfirmPassword,
                          ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "Male",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              trailing: Radio(
                                  value: "male",
                                  groupValue: groupValue,
                                  onChanged: (e) => valueChanged(e)),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "Female",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              trailing: Radio(
                                  value: "female",
                                  groupValue: groupValue,
                                  onChanged: (e) => valueChanged(e)),
                            ),
                          )
                        ],
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            //validateForm();
                            if (_formKey.currentState.validate()) {
                              registerToFb();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red,fontSize: 22.0),
                      ),
                  ),
                ],
              ),
            ),
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
        ],
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender=e;
      } else if (e == "female") {
        groupValue = e;
        gender=e;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passwordConfirmTextController.dispose();
  }

  String validateFullName(String value) {
    if (value.isEmpty) {
      return 'Name field cannot empty !!!';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password field cannot empty !!!';
    } else if (value.length < 6) {
      return 'Password has to be at least 6 characters long';
    }

    return null;
  }

  String emailValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please make sure your email address is valid';
    }

    return null;
  }

  String validateConfirmPassword(String value) {
      if (value.isEmpty) {
        return 'Password field cannot empty !!!';
      } else if (value.length < 6) {
        return 'Password has to be at least 6 characters long';
      }else if(value.trim() != _passwordTextController.text.trim()){
        return "The passwords do not match ";
      }

    return null;
  }

  void registerToFb() {

    _userServices.signUp(_emailTextController.text.trim(), _passwordTextController.text.trim()).then(
        (user) {
          Personne p = Personne(
            userId: user.uid,
            userName: _nameTextController.text.trim(),
            email: user.email,
            gender: groupValue,
            password: _passwordTextController.text.trim()
          );
          try{
            _userServices.createUser(p);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
          }catch(e){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text(e.message),
                    actions: [
                      FlatButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          }
        }
    ).catchError((onError){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(onError.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });

  }

  void registerToFb2() {
    auth
        .createUserWithEmailAndPassword(
        email: _emailTextController.text, password: _passwordTextController.text)
        .then((result) {
      dbRef.child(result.user.uid).set({
        "email": _emailTextController.text,
        "password": _passwordTextController.text,
        "userName": _nameTextController.text,
        "gender":gender,
        "userId":result.user.uid,
      }).then((res) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }


}

//MaterialPageRoute(builder: (context) => HomePage(uid: result.user.uid))