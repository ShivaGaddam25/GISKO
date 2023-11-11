import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mygisko/resources/auth_methods.dart';
import 'package:mygisko/responsive/mobile_screen_layout.dart';
import 'package:mygisko/screens/homescreen/cart.dart';
import 'package:mygisko/screens/homescreen/notification.dart';
import 'package:mygisko/screens/homescreen/search.dart';
import 'package:mygisko/screens/login_screen.dart';
import 'package:mygisko/utils/colors.dart';
import 'package:mygisko/utils/utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;
  String? _username;
  String? _email;
  String? _mblno;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Assuming you have a method in AuthMethods to get user profile
      Map<String, dynamic>? userProfile =
          await AuthMethods().getUserProfile(user.uid);

      if (userProfile != null) {
        setState(() {
          _username = userProfile['username'];
          _email = userProfile['email'];
          _mblno = userProfile['mblno'];
          _photoUrl = userProfile['photoUrl'];
        });
      }
    }
  }

  void _signOut() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signOut(context);

    if (res == "success") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //SystemNavigator.pop();
        //return false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MobileScreenLayout()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF163057),
          title: const Text("My Profile"),
          actions: [
            IconButton(
              onPressed: () {
                // Add search functionality
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Search()));
              },
              icon: const Icon(CupertinoIcons.search),
            ),
            IconButton(
              onPressed: () {
                // Add cart functionality
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
              icon: const Icon(CupertinoIcons.cart),
            ),
            IconButton(
              onPressed: () {
                // Add notifications functionality
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications()));
              },
              icon: const Icon(CupertinoIcons.bell),
            ),
          ],
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
                  const SizedBox(height: 20),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),

// New Container with red border
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(
                            255, 128, 245, 4), // Change border color if needed
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Photo
                        CircleAvatar(
                            radius: 40,
                            backgroundImage: _photoUrl != null
                                ? Image.network(_photoUrl as String).image
                                : const AssetImage(
                                    'assets/default.png') // Provide a default image
                            ),
                        const SizedBox(width: 10),
                        // User Data
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _username ?? 'Loading...',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _email ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _mblno ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                        InkWell(
                          onTap: () {
                            // Add functionality for editing user data
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 27, 26, 25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: Color.fromARGB(255, 251, 234, 2),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 230, 4),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Add functionality for My Orders
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 118, 61, 1),
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                icon: const Icon(
                                  CupertinoIcons.cart,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'My Orders',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Add functionality for My Rewards
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 118, 61, 1),
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                icon: const Icon(
                                  CupertinoIcons.gift,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'My Coupons',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Add functionality for My Wallet
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 118, 61, 1),
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                icon: const Icon(
                                  CupertinoIcons.creditcard,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'My Wallet',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Add functionality for Customer Care
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 118, 61, 1),
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                icon: const Icon(
                                  CupertinoIcons.phone,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Get help',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Add functionality for My Address
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 118, 61, 1),
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                icon: const Icon(
                                  CupertinoIcons.location,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'My Address',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Add functionality for Saved
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 118, 61, 1),
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                icon: const Icon(
                                  CupertinoIcons.bookmark,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Saved',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  //my payments
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 230, 4),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'My Payments',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for Bank & UPI Details
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 140, 89, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Bank or UPI icon
                                  Icon(
                                    Icons.account_balance,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8), // Adjust the gap
                                  Text(
                                    'Bank & UPI Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for Payment & Refund
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 140, 89, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                ' ₹', // Rupee symbol
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '  Payments & Refunds',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for Saved Cards
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 140, 89, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Card icon
                                  Icon(
                                    CupertinoIcons.creditcard,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8), // Adjust the gap
                                  Text(
                                    'Saved Cards',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),

                  // My Activity Container
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 230, 4),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'My Activity',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for Followed Shops
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 107, 68, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                CupertinoIcons
                                    .person_2_fill, // Replace with appropriate icon
                                color: Colors.white,
                              ),
                              SizedBox(width: 8), // Adjust the gap here
                              Text(
                                'Followed Shops',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(), // Adjust the space between text and arrow
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for My Reviews
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 107, 68, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                CupertinoIcons
                                    .star_fill, // Replace with appropriate icon
                                color: Colors.white,
                              ),
                              SizedBox(width: 8), // Adjust the gap here
                              Text(
                                'My Reviews',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(), // Adjust the space between text and arrow
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for Q&A
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 107, 68, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                CupertinoIcons
                                    .question_circle_fill, // Replace with appropriate icon
                                color: Colors.white,
                              ),
                              SizedBox(width: 8), // Adjust the gap here
                              Text(
                                'Q&A',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(), // Adjust the space between text and arrow
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  InkWell(
                    onTap: () {
                      if (!_isLoading) {
                        _signOut();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 31, 245, 11),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : const Text(
                              'Logout',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 251, 234, 2)),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),

                  // My earning with GISKO
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 230, 4),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Start Earning',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for Sell on GISKO
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 100, 107, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                CupertinoIcons
                                    .tag_fill, // Appropriate icon for Sell on GISKO
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Sell on GISKO',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for GISKO Studio
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 100, 107, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                CupertinoIcons
                                    .photo_fill, // Appropriate icon for GISKO Studio
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'GISKO Studio',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for Get Clarity
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 100, 107, 1),
                            minimumSize: const Size.fromHeight(60),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                CupertinoIcons
                                    .lightbulb_fill, // Appropriate icon for Get Clarity
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Get Clarity',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                CupertinoIcons.forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  //faqs
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
                  // ...
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            vertical: 2,
                          ),
                        ),
                      ),
                      const Text(
                        ' & ',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 247, 248, 249),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add functionality for "Privacy Policy"
                        },
                        child: Container(
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
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
