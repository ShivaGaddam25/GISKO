import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mygisko/responsive/mobile_screen_layout.dart';
import 'package:mygisko/screens/forgotpassword_screen.dart';
import 'package:mygisko/screens/signup_screen.dart';
import 'package:mygisko/services/facebook_sign_in.dart';
import 'package:mygisko/utils/colors.dart';
import 'package:mygisko/utils/utils.dart';
import 'package:mygisko/widgets/text_field_input.dart';
// ignore: unnecessary_import
import 'package:mygisko/resources/auth_methods.dart';

import 'package:mygisko/services/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  void _loginUser() async {
    setState(() {
      _isLoading = true;
    });

    // Add your login logic here

    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MobileScreenLayout()));
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  void _navigateToSignupScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FacebookSignInService authservicef = FacebookSignInService();
    GoogleSignInService authserviceg = GoogleSignInService();
    //Forgotpassword authservicefp = Forgotpassword();
    return WillPopScope(
      onWillPop: () async {
        //go back to the device's home screen
        SystemNavigator.pop();
        return false;
        //prevent default back button behavior
      },
      child: Scaffold(
        body: Container(
          color: const Color(0xFF163057),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  const SizedBox(height: 32),
                  SvgPicture.asset(
                    'assets/giskologo.svg',
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF163057), BlendMode.color),
                    height: 64,
                  ),
                  const SizedBox(height: 84),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        // Handle Google Sign-In,
                        await authserviceg.signInWithGoogle();

                        // Add this check to ensure an email is selected
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MobileScreenLayout(),
                            ),
                          );
                        }
                      } catch (e) {
                        print("Google Sign-In cancelled or failed: $e");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/googol_logo.svg',
                      height: 24,
                    ),
                    label: const Text("Sign in with Google"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        // Handle Facebook Sign-In
                        await authservicef.signInWithFacebook();

                        // Add this check to ensure the sign-in was successful
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MobileScreenLayout(),
                            ),
                          );
                        }
                      } catch (e) {
                        print("Facebook Sign-In cancelled or failed: $e");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/facebook_logo.svg',
                      height: 24,
                    ),
                    label: const Text("Sign in with Facebook"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Colors.black)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "or",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "Enter your email",
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "Enter your password",
                    textInputType: TextInputType.text,
                    isPass: true,
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        //Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: _isLoading ? null : _loginUser,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: Color.fromARGB(255, 92, 1, 72),
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle "Forgot Password?" action
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Forgotpassword()));
                    },
                    child: const Text('Get help?'),
                  ),
                  const SizedBox(height: 180),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text("Don't have an account?"),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToSignupScreen,
                        child: Container(
                          child: const Text(
                            'Join GISKO.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
