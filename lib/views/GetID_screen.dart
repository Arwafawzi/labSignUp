import 'dart:convert';

import 'package:app_api/services/api/User/getByID.dart';
import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';

class GetScreenID extends StatefulWidget {
  const GetScreenID({super.key});

  @override
  State<GetScreenID> createState() => _GetScreenIDState();
}

class _GetScreenIDState extends State<GetScreenID> {
  Map order = {};
  final TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 101, 1, 119),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView(children: [
          TextFieldCustom(
              controller: idController,
              hint: "enter id",
              icon: Icons.insert_drive_file),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  if (int.parse(idController.text) is int) {
                    order = json
                        .decode((await getByID(id: idController.text)).body);
                    print(order);
                    if ((order["data"] as List).isEmpty) {
                      order = {};
                    } else {
                      order = order["data"][0];
                    }
                    setState(() {});
                  }
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("plase enter correct number")));
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(Size(200.0, 40.0)),
              ),
              child: Text(
                "Get id",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Visibility(
              visible: order.isNotEmpty,
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order["id"].toString(),
                      style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      order["title"].toString(),
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      order["content"].toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      order["create_at"].toString(),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}
