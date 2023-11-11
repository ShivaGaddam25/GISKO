import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mygisko/responsive/mobile_screen_layout.dart';

import 'package:mygisko/screens/forgotpassword_screen.dart';
import 'package:mygisko/screens/login_screen.dart';

import 'package:mygisko/screens/signup_screen.dart';
import 'package:mygisko/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCGtFIlmkIsVWj3_C0i3pbdWPc_Ovivcvc',
        appId: '1:64775437473:web:7d8e7a442be4073fce44e0',
        messagingSenderId: '64775437473',
        projectId: 'gisko-007',
        authDomain: "gisko-007.firebaseapp.com",
        storageBucket: "gisko-007.appspot.com",
        measurementId: "G-PHE14DH3QL",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gisko',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        //home: const ResponsiveLayout(
        // mobileScreenLayout: MobileScreenLayout(),
        // webScreenLayout: WebScreenLayout(),
        //),
        initialRoute: '/GISKO',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/forgot': (context) => const Forgotpassword(),
          '/signup': (context) => const SignupScreen(),
          '/GISKO': (context) => StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return const MobileScreenLayout();
                  } else {
                    return const LoginScreen();
                  }
                },
              ),
        });
  }
}
