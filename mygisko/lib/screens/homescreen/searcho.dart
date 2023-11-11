import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygisko/screens/homescreen/search.dart';

class Searcho extends StatefulWidget {
  const Searcho({super.key});

  @override
  State<Searcho> createState() => _SearchoState();
}

class _SearchoState extends State<Searcho> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Search()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF163057),
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 4.0),
                  child: Icon(CupertinoIcons.search, color: Colors.grey),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type here to search",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
