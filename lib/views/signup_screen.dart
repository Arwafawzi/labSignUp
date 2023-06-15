import 'package:app_api/services/api/Auth/createUser.dart';
import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color.fromARGB(255, 212, 194, 241),
          child: Column(
            children: [
              Text(
                "Create New Account",
                style: TextStyle(
                    color: Color.fromARGB(255, 100, 17, 115), fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Column(children: [
                TextFieldCustom(
                  hint: "user123",
                  icon: Icons.person,
                  onChanged: (value) {
                    print(value);
                    username = value;
                  },
                ),
                TextFieldCustom(
                  hint: "Fahad Alazmi",
                  icon: Icons.person,
                  controller: nameController,
                ),
                TextFieldCustom(
                  hint: "example@gmail.com",
                  icon: Icons.email,
                  controller: emailController,
                ),
                TextFieldCustom(
                  hint: "AAaa1100229933",
                  icon: Icons.email,
                  obscureText: true,
                  isPassword: true,
                  onChanged: (pass) {
                    password = pass;
                  },
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 100, 17, 115)),
                        onPressed: () async {
                          final Map body = {
                            "email": emailController.text,
                            "password": password,
                            "username": username,
                            "name": nameController.text
                          };
                          final response = await createUser(body: body);
                          print(response.body);
                          if (response.statusCode == 200) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          }
                        },
                        child: Text("Create"))),
                TextButton(
                  onPressed: () {
                    context.push(view: LoginScreen());
                  },
                  child: Text(
                    "Don't have an account or Login ",
                    style: TextStyle(color: Color.fromARGB(255, 10, 22, 15)),
                  ),
                )
              ]),
            ],
          )),
    );
  }
}

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {super.key,
      required this.hint,
      required this.icon,
      this.isPassword = false,
      this.controller,
      this.onChanged,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines = 1});

  final String hint;
  final IconData icon;
  final bool? isPassword;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  bool obscureText;
  final int minLines;
  final int maxLines;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
          enabled: true,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.obscureText,
          obscuringCharacter: "*",
          cursorColor: const Color.fromARGB(255, 131, 131, 131),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hint,
            prefixIcon: Icon(
              widget.icon,
              color: Colors.grey,
            ),
            suffixIcon: widget.isPassword!
                ? IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      widget.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    })
                : null,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
          )),
    );
  }
}
