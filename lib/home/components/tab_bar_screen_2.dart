import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabBarScreen2 extends StatefulWidget {
  const TabBarScreen2({Key? key, required this.email}) : super(key: key);

  final TextEditingController email;

  @override
  _TabBarScreen2State createState() => _TabBarScreen2State();
}

class _TabBarScreen2State extends State<TabBarScreen2> {
  //! for get data
  Future getData(String email) async {
    var storeData = (await FirebaseFirestore.instance
            .collection('userdata')
            .doc(email.trim())
            .get())
        .data();
    return storeData;
  }

  //! for delete
  void delet(dynamic height, dynamic weight, String email) async {
    var androidAds = (await FirebaseFirestore.instance
            .collection('userdata')
            .doc(email.trim())
            .get())
        .data();

    List lstUser = androidAds!["data"];

    List newArray = [];
    for (var index = 0; index < lstUser.length; index++) {
      Map<String, dynamic> element = lstUser[index];

      if (element["Height"] != height.toString() &&
          element["Weight"] != weight.toString()) {
        Map<String, dynamic> mapInsert = {
          "Height": element["Height"],
          "Weight": element["Weight"],
        };
        newArray.add(mapInsert);
      }
    }
    await FirebaseFirestore.instance
        .collection('userdata')
        .doc(email.trim())
        .set(
      {
        "data": newArray,
      },
    );
    setState(() {});
  }

  TextEditingController editHeightController = TextEditingController();

  TextEditingController editWeightController = TextEditingController();

  //! for edit
  edit(
    dynamic height,
    dynamic weight,
    String email,
    String heightController,
    String weightController,
  ) async {
    var androidAds = (await FirebaseFirestore.instance
            .collection('userdata')
            .doc(email.trim())
            .get())
        .data();

    List lstUser = androidAds!["data"];

    List newArray = [];
    for (var index = 0; index < lstUser.length; index++) {
      Map<String, dynamic> element = lstUser[index];

      if (element["Height"] == height.toString() &&
          element["Weight"] == weight.toString()) {
        Map<String, dynamic> mapInsert = {
          "Height": weightController,
          "Weight": heightController,
        };
        newArray.add(mapInsert);
      } else {
        Map<String, dynamic> mapInsert = {
          "Height": element["Height"],
          "Weight": element["Weight"],
        };
        newArray.add(mapInsert);
      }
    }
    await FirebaseFirestore.instance
        .collection('userdata')
        .doc(email.trim())
        .set(
      {
        "data": newArray,
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.email.text.isEmpty) {
      const Text(
        "data",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      );
      return const Center(
        child: Text(
          "No data",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      );
    } else {
      return FutureBuilder(
        future: getData(widget.email.text),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List data = snapshot.data['data'];
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                var dataList = data[i];
                return Container(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 8.0, top: 8, bottom: 8),
                  height: 100,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      width: 250,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(width: 10),
                                Text(
                                  "Your Height : ${dataList['Height']}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  "Your Weight : ${dataList['Weight']}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    delet(
                                      dataList["Height"],
                                      dataList["Weight"],
                                      widget.email.text,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alertDialogForEdit(
                                          context,
                                          dataList["Height"],
                                          dataList["Weight"],
                                          widget.email.text,
                                          editHeightController,
                                          editWeightController,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      );
    }
  }

  GestureDetector alertDialogForEdit(
    BuildContext context,
    dynamic heightAlert,
    dynamic weightAlert,
    String editEmail,
    TextEditingController editHeightController,
    TextEditingController editWeightController,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Edit your values"),
        titlePadding: const EdgeInsets.only(left: 55, top: 20),
        titleTextStyle: const TextStyle(
          color: Colors.deepOrange,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        content: SizedBox(
          height: 180,
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 100,
                child: TextField(
                    controller: editWeightController,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    cursorHeight: 30,
                    keyboardType: TextInputType.number,
                    decoration: decorationTextField(heightAlert)),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: editHeightController,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  cursorHeight: 30,
                  keyboardType: TextInputType.number,
                  decoration: decorationTextField(weightAlert),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Cancle",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text(
              "Edit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              edit(
                heightAlert,
                weightAlert,
                editEmail,
                editHeightController.text,
                editWeightController.text,
              );
              // print("object");
              // print("object :::::::::::::::::: $heightAlert");
              // print("object :::::::::::::::::: $weightAlert");
              // print("object :::::::::::::::::: $editEmail");
              // print("object :::::::::::::::::: ${editHeightController.text}");
              // print("object :::::::::::::::::: ${editWeightController.text}");

              Navigator.pop(context);
              editHeightController.clear();
              editWeightController.clear();
            },
          ),
        ],
      ),
    );
  }

  InputDecoration decorationTextField(String NewHeight) {
    return InputDecoration(
      hintText: NewHeight,
      hintStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepOrange,
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
