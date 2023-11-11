import 'package:flutter/material.dart';
import 'package:mygisko/screens/login_screen.dart';
import 'package:mygisko/screens/signup_screen.dart';
import 'package:mygisko/utils/colors.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final bool _isLoading = false;

  Future<void> _signOut(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _navigateToSignupScreen(BuildContext context) {
    // Navigate to the Signup screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF163057),
        //actions: [
        //IconButton(
        //onPressed: () => _signOut(context),
        //icon: const Icon(Icons.logout),
        //),
        //],
        title: const Text('Get help?'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 1, 17, 50),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(height: 80),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    // Add functionality for "Forgot Password?"
                  },
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
                      color: Color.fromARGB(255, 1, 94, 50),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 18),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    // Add functionality for "Having trouble logging in?"
                  },
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
                      color: Color.fromARGB(255, 1, 94, 50),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Forgot Email?'),
                  ),
                ),
                const SizedBox(height: 18),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    // Add functionality for "Having trouble logging in?"
                  },
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
                      color: Color.fromARGB(255, 1, 94, 50),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Forgot Email & Password?'),
                  ),
                ),
                const SizedBox(height: 18),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    // Add functionality for "Having trouble logging in?"
                  },
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
                      color: Color.fromARGB(255, 1, 94, 50),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Having trouble logging in?'),
                  ),
                ),
                const SizedBox(height: 18),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    // Add functionality for "Having trouble logging in?"
                  },
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
                      color: Color.fromARGB(255, 1, 94, 50),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Want to Know more?'),
                  ),
                ),
                const SizedBox(height: 18),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color.fromARGB(255, 253, 115, 3))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "or",
                        style: TextStyle(color: Color.fromARGB(255, 253, 115, 3)),
                      ),
                    ),
                    Expanded(child: Divider(color: Color.fromARGB(255, 253, 115, 3))),
                  ],
                ),
                const SizedBox(height: 18),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SignupScreen())); // Add functionality for "Having trouble logging in?"
                  },
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
                        : const Text('Create Account <-> Join GISKO.'),
                  ),
                ),
                const SizedBox(height: 280),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Want to know more?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Container(
                        child: const Text(
                          'Search FQs',
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
                const SizedBox(height: 8),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(""),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Container(
                        child: const Text(
                          '',
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
    );
  }
}
