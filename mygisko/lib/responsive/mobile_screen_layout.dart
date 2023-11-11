import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mygisko/resources/auth_methods.dart';
import 'package:mygisko/screens/homescreen/cart.dart';
import 'package:mygisko/screens/homescreen/down/profile_screen.dart';
import 'package:mygisko/screens/homescreen/notification.dart';
import 'package:mygisko/screens/homescreen/search.dart';
import 'package:mygisko/utils/colors.dart';
import 'package:mygisko/utils/custom_icon.dart';
import 'package:mygisko/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation
  String? _username;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
          _photoUrl = userProfile['photoUrl'];
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: _page == 2 || _page == 3 || _page == 4
            ? null
            : AppBar(
                // If on Shorts screen, hide the AppBar
                backgroundColor: const Color(0xFF163057),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        "GISKO",
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 251, 251),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      // Add search functionality
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()));
                    },
                    icon: const Icon(CupertinoIcons.search),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add cart functionality
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Cart()));
                    },
                    icon: const Icon(CupertinoIcons.shopping_cart),
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
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(CupertinoIcons.bars),
                    );
                  },
                ),
              ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFF163057),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        title: Text(
                          'Categories',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      // User's photo, username, and view button side by side
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35, // Adjust as needed
                            backgroundImage: _photoUrl != null
                                ? Image.network(_photoUrl as String).image
                                : const AssetImage('assets/default.png'),
                          ),
                          const SizedBox(
                              width:
                                  20), // Adjust spacing between photo and username
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _username ?? 'Loading...',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 248, 211, 157),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          5), // Adjust spacing between username and view button
                                  TextButton(
                                    onPressed: () {
                                      // Add functionality for the "View" action
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Profile(),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                    ),
                                    child: const Text(
                                      'View Profile',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Divider
                const Divider(),
                // Vertical buttons with images as background
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/women.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Women',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/men.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Men',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/wedding.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Wedding',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/festival.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Festivals',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/allanime.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Anime',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/kdrama.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'K-drama',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/marvel.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Marvel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/dc.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'DC',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 100, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/office.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Office',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                // Repeat the structure for additional buttons
                // ...

                // Existing "Categories" line (Keep as is)
                // Add your categories here
              ],
            ),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 51, 70, 108),
          child: PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: homeScreenItems,
          ),
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: background,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: CustomIcon(
                iconPath:
                    'assets/home.svg', // Provide the path to your custom icon
                color: (_page == 0) ? primaryColor : secondaryColor,
              ),
              label: 'Home',
              backgroundColor: background,
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(
                iconPath:
                    'assets/store.svg', // Provide the path to your custom icon
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: 'Store',
              backgroundColor: background,
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(
                iconPath:
                    'assets/shorts.svg', // Provide the path to your custom icon
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
              label: 'Shorts',
              backgroundColor: background,
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(
                iconPath:
                    'assets/profile.svg', // Provide the path to your custom icon
                color: (_page == 3) ? primaryColor : secondaryColor,
              ),
              label: 'Profile',
              backgroundColor: background,
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(
                iconPath:
                    'assets/local.svg', // Provide the path to your custom icon
                color: (_page == 4) ? primaryColor : secondaryColor,
              ),
              label: 'Local',
              backgroundColor: background,
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
