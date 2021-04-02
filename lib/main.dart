import 'package:flutter/material.dart';
import 'package:english_words_3000/screens/home.dart';
import 'package:english_words_3000/auth_screen/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:english_words_3000/auth_screen/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ここ大事！
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.id,
      routes: {
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        Home.id: (context) => Home(),
      },
    );
  }
}
