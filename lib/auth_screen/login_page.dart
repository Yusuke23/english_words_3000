import 'package:english_words_3000/auth_screen/registration_page.dart';
import 'package:english_words_3000/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:english_words_3000/components_in_auth_page/rounded_button.dart';
import 'package:english_words_3000/const_auth_screen/const_auth_screen.dart';

class LoginPage extends StatefulWidget {
  static const id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 100.0,
                    child: Image.asset('images/icons8backpack2.png'),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'English Words 3000',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: animation.value * 35,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, Home.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('メールアドレスかパスワードが正しくありません。'),
                            actions: [
                              TextButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    showSpinner = false;
                                  });
                                },
                              )
                            ],
                          );
                        });
                  }
                },
              ),
              RoundedButton(
                  title: 'Register Page',
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationPage.id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
