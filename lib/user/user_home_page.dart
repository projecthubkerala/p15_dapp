import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserHomaPage extends StatelessWidget {
  const UserHomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2CC66D),
        title: const Text(
          "Home page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      // body: Center(child: Text('Home page')),
    );
  }
}
