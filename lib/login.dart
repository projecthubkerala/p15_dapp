import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app/admin/home.dart';
import 'package:notes_app/home_screen.dart';
import 'package:notes_app/user/signup.dart';
import 'package:notes_app/user/user_home_page.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _globalKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF151619),
        body: ListView(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Center(
                child: Text(
              'Login in to your account',
              style: TextStyle(
                  fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
            )),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Form(
                      key: _globalKey1,
                      child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            CustomTextField(
                              textFieldController: _emailController,
                              hintText: 'Phone Number',
                              inputType: TextInputType.phone,
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            CustomTextField(
                              isPassword: true,
                              textFieldController: _passwordController,
                              hintText: 'Password',
                              inputType: TextInputType.visiblePassword,
                              isVisible: true,
                         
                            ),
                          ])),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 50,
                      width: 300,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF2CC66D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0)),
                          side: const BorderSide(color: Color(0xFF2CC66D)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const UserHomaPage()));
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Visibility(
                        visible: true,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                            },
                            child: const Text(
                              'Admin? Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2CC66D),
                                fontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => SignupScreen()));
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2CC66D),
                              fontSize: 15,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textFieldController,
    this.isVisible = false,
    this.suffixIcon = const Icon(Icons.ac_unit),
    this.hintText = '',
    this.lineNo = 1,
    this.isPassword = false,
    this.inputType = TextInputType.streetAddress,
    this.inputColor = Colors.white,
  });

  final TextEditingController textFieldController;
  final bool isVisible;
  final Icon suffixIcon;
  final String hintText;
  final int lineNo;
  final bool isPassword;
  final TextInputType inputType;
  final Color inputColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      color: const Color(0xFF1E1F23),
      child: TextFormField(
        keyboardType: inputType,
        obscureText: isPassword,
        maxLines: lineNo,
        style: TextStyle(color: inputColor),
        controller: textFieldController,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            left: 20,
            top: 12,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF2CC66D), width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: hintText,
          suffixIcon: Visibility(
            visible: isVisible,
            child: suffixIcon,
          ),
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF2CC66D),
          ),
        ),
      ),
    );
  }
}
