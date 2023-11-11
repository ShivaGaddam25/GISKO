import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mygisko/resources/auth_methods.dart';
import 'package:mygisko/responsive/mobile_screen_layout.dart';
import 'package:mygisko/screens/login_screen.dart';

import 'package:mygisko/utils/colors.dart';

import 'package:mygisko/utils/utils.dart';
import 'package:mygisko/widgets/text_field_input.dart';

import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ibrandsController = TextEditingController();
  final TextEditingController _mobilenoController = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;
  String? selectedGender;
  List<String> genders = ['Male', 'Female', 'Rather not say'];

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _genderController.dispose();
    _ibrandsController.dispose();
    _mobilenoController.dispose();
  }

  Future<void> selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path).readAsBytesSync();
      });
    }
  }

  void signUpUser() async {
    setState(() {
      _isloading = true;
    });

    // Check if _image is null
    if (_image == null) {
      showSnackBar("Please select a profile picture", context);
      setState(() {
        _isloading = false;
      });
      return;
    }

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      gender: _genderController.text,
      mblno: _mobilenoController.text,
      ibrands: _ibrandsController.text,
      file: _image!,
    );

    if (res == "success") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MobileScreenLayout()));
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      _isloading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //SystemNavigator.pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        return false;
      },
      child: Scaffold(
        body: Container(
          color: const Color(0xFF163057),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  SvgPicture.asset(
                    'assets/giskologo.svg',
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF163057), BlendMode.color),
                    height: 64,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 58,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 58,
                                backgroundImage: NetworkImage(
                                  'https://assets-prod.sumo.prod.webservices.mozgcp.net/static/default-FFA-avatar.2f8c2a0592bda1c5.png',
                                ),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 70,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  TextFieldInput(
                    textEditingController: _usernameController,
                    hintText: "Enter your username",
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "Enter your email",
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "Enter your password",
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the buttons
                    children: genders.map((gender) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = gender;
                            _genderController.text = gender;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 28),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selectedGender == gender
                                ? const Color.fromARGB(255, 208, 4, 235)
                                : const Color.fromARGB(255, 165, 231, 247),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            gender,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  TextFieldInput(
                    textEditingController: _mobilenoController,
                    hintText: "Mobile Number",
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  TextField(
                    controller: _ibrandsController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Interested Brands',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  InkWell(
                    onTap: signUpUser,
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
                      child: _isloading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: primaryColor,
                            ))
                          : const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text("Already have an account?"),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Container(
                          child: const Text(
                            'Login GISKO.',
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
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'By Signing in, I agree to the',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add functionality for "Terms & Conditions"
                        },
                        child: Container(
                          child: const Text(
                            'Terms of Use',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue, // You can customize the color
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add functionality for "Terms & Conditions"
                        },
                        child: Container(
                          child: const Text(
                            ' & ',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 247, 248,
                                  249), // You can customize the color
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add functionality for "Terms & Conditions"
                        },
                        child: Container(
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue, // You can customize the color
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
