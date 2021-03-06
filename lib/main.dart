import 'package:flutter/material.dart';
import 'package:english_words_3000/screens/home.dart';
import 'package:english_words_3000/auth_screen/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:english_words_3000/auth_screen/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        Home.id: (context) => Home(),
      },
    );
  }
}
