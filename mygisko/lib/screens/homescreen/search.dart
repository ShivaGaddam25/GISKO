import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygisko/responsive/mobile_screen_layout.dart';
import 'package:mygisko/screens/homescreen/searcho.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void _navigateToSearcho(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Searcho()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, // Remove back arrow icon
            backgroundColor: const Color(0xFF163057),
            title: GestureDetector(
              onTap: () {
                _navigateToSearcho(context);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 251, 250, 170),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 4.0),
                      child: Icon(CupertinoIcons.search_circle_fill,
                          color: Color.fromARGB(255, 160, 212, 19)),
                    ),
                    Expanded(
                        child: Text(
                      'Search',
                      style: TextStyle(color: Color.fromARGB(255, 27, 81, 1)),
                    )), // Placeholder text
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
