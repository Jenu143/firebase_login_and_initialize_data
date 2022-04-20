import 'package:firebase_login_and_initialize_data/Firebase/auth.dart';
import 'package:flutter/material.dart';

class ResetPass extends StatelessWidget {
  ResetPass({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepOrange.withOpacity(0.5),
                      ),
                      child: IconButton(
                        splashColor: Colors.deepOrange,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter your email";
                        } else if (!value
                            .contains(RegExp("^[a-zA-Z0-9]+@+\.[a-zA-Z]"))) {
                          return "Enter valid email";
                        }
                      },
                      onFieldSubmitted: (text) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "Email",
                        contentPadding: const EdgeInsets.only(left: 40),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        labelText: "Enter your email",
                        suffixIcon: const Icon(
                          Icons.email,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                  ),
                  onPressed: () {
                    Authantication()
                        .resetPassword(email: emailController.text)
                        .then((result) {
                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text(
                              "Email has been sent",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      }
                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text(
                              "Enter your valid email",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      }
                    });
                    // emailController.clear();
                  },
                  child: const Text("Sent"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
