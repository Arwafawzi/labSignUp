import 'dart:convert';

import 'package:app_api/services/api/Auth/login.dart';
import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/Home_screen.dart';
import 'package:app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = "";
  bool _isLoading = false;
  void _login() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 194, 241),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              color: Color.fromARGB(255, 212, 194, 241),
              height: 300,
              child: Column(children: [
                Text(
                  "Log in",
                  style: TextStyle(
                      color: Color.fromARGB(255, 153, 2, 213), fontSize: 30),
                ),
                TextFieldCustom(
                  hint: "example@gmail.com",
                  icon: Icons.email,
                  controller: emailController,
                ),
                TextFieldCustom(
                  hint: "******",
                  icon: Icons.password,
                  isPassword: true,
                  controller: passwordController,
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () async {
                          final Map body = {
                            "email": emailController.text,
                            "password": passwordController.text,
                          };
                          final response = await loginUser(body: body);

                          if (response.statusCode == 200) {
                            final box = GetStorage();
                            box.write("token",
                                json.decode(response.body)["data"]["token"]);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("LOGIN FAILD"),
                                duration: Duration(seconds: 3)));
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Text("Create"))),
                TextButton(
                  onPressed: () {
                    context.push(view: SignUpScreen());
                  },
                  child: Text(
                    "dot a have an account",
                    style: TextStyle(color: Color.fromARGB(255, 10, 22, 15)),
                  ),
                )
              ])),
        ),
      ),
    );
  }
}
