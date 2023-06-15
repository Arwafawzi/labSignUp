import 'dart:convert';
import 'package:app_api/services/api/User/create_order.dart';
import 'package:app_api/services/api/User/get_orders.dart';
import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/CardOrders.dart';
import 'package:app_api/views/GetID_screen.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:app_api/views/order_screen.dart';
import 'package:app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List listOrders = [];
  @override
  void initState() {
    super.initState();
    _test();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 1, 119),
        actions: [
          IconButton(
              onPressed: () {
                context.push(view: GetScreenID());
              },
              icon: Icon(Icons.move_down)),
        ],
      ),
      body: ListView(
        children: [
          TextFieldCustom(
            hint: "Title",
            controller: titleController,
            icon: Icons.read_more,
          ),
          TextFieldCustom(
              minLines: 3,
              maxLines: 10,
              hint: "content",
              controller: contentController,
              icon: Icons.content_copy),
          Center(
              child: ElevatedButton(
            child: Text("GetData"),
            onPressed: () async {
              final result = await createOrder(context: context, body: {
                "title": titleController.text,
                "content": contentController.text
              });

              print(result.statusCode);
              _test();
            },
          )),
          //-------------- display orders ---------------

          for (var item in listOrders)
            InkWell(
                onTap: () {
                  context.pushAndRemove(view: OrderScreen(order: item));
                },
                child: CardOrders(order: item)),
        ],
      ),
    );
  }

  _test() async {
    if ((await getOrders()).statusCode == 200) {
      listOrders = json.decode((await getOrders()).body)["data"];
      print(listOrders);
      setState(() {});
    } else {
      final box = GetStorage();
      box.remove("token");
      context.pushAndRemove(view: LoginScreen());
    }
  }
}

lodingPage({required BuildContext context}) {
  return showDialog(
      context: context,
      barrierColor: Colors.white,
      builder: (context) => Center(child: CircularProgressIndicator()));
}

getData({required String keyUser}) {
  final box = GetStorage();
  if (box.hasData(keyUser)) {
    return box.read(keyUser);
  } else {
    return null;
  }
}

getDataWithLoading({required BuildContext context, required String keyUser}) {
  lodingPage(context: context);
  final data = getData(keyUser: keyUser);

  if (data != null) {
    Navigator.of(context).pop();
  }
}
