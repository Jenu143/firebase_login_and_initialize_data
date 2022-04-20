import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabBarScreen1 extends StatefulWidget {
  const TabBarScreen1({
    Key? key,
    required this.email,
  }) : super(key: key);

  final TextEditingController email;

  @override
  _TabBarScreen1State createState() => _TabBarScreen1State();
}

class _TabBarScreen1State extends State<TabBarScreen1> {
  TextEditingController heightController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  FocusNode weight = FocusNode();

  List yourItemList = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  " Welcome :",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " ${widget.email.text.trim()}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //^ height
                const Text(
                  "Height : ",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  width: 100,
                  //!
                  child: TextField(
                    controller: heightController,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(weight);
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            //^ weight
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Weight : ",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  width: 100,
                  //!
                  child: TextField(
                    controller: weightController,
                    focusNode: weight,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurpleAccent)),
              onPressed: () {
                Map<String, dynamic> someData = {
                  'Height': heightController.text,
                  'Weight': weightController.text,
                };

                FocusScope.of(context).requestFocus(FocusNode());
                FirebaseFirestore.instance
                    .collection("userdata")
                    .doc(widget.email.text.trim())
                    .update(
                  {
                    "data": FieldValue.arrayUnion([someData])
                  },
                );

                heightController.clear();
                weightController.clear();
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
