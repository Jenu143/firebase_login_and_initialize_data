import 'package:firebase_login_and_initialize_data/Firebase/auth.dart';
import 'package:firebase_login_and_initialize_data/login/login.dart';
import 'package:firebase_login_and_initialize_data/home/components/tab_bar_screen_1.dart';
import 'package:firebase_login_and_initialize_data/home/components/tab_bar_screen_2.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.email,
    required this.email2,
  }) : super(key: key);

  final TextEditingController email;

  final TextEditingController email2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context),
        body: TabBarView(
          children: [
            TabBarScreen1(
              email: email,
            ), 
            TabBarScreen2(
              email: email2,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Firebase Login",
        style: TextStyle(
          color: Colors.deepPurpleAccent,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.logout_outlined),
            onPressed: () {
              Authantication().logOut().then((_) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  ));
            },
          ),
        ),
      ],
      elevation: 1.5,
      backgroundColor: Colors.white,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SafeArea(
          child: SizedBox(
            height: 50,
            child: TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.deepOrange,
              indicatorColor: Colors.deepOrange,
              indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 3, color: Colors.deepPurpleAccent),
                insets: EdgeInsets.only(left: 15, right: 15),
              ),
              tabs: [
                Text(
                  "Input",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Output",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
