import 'package:flutter/material.dart';


class Listl extends StatefulWidget {
  const Listl({super.key});

  @override
  State<Listl> createState() => _ListlState();
}

class _ListlState extends State<Listl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF163057),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "list",
              style: TextStyle(
                color: Color.fromARGB(255, 252, 251, 251),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
