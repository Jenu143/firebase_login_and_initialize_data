import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_and_initialize_data/Sing%20Screens%20firlds/conform_password.dart';
import 'package:firebase_login_and_initialize_data/Sing%20Screens%20firlds/contact.dart';
import 'package:firebase_login_and_initialize_data/Firebase/auth.dart';
import 'package:firebase_login_and_initialize_data/home/home_screen.dart';
import 'package:firebase_login_and_initialize_data/login/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();

  TextEditingController conformPasswordController = TextEditingController();

  TextEditingController contactController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  bool obscureText = false;

  bool checked = false;

  late String email;

  late String password;

//! focus nodes
  final FocusNode _password = FocusNode();

  final FocusNode _conformPassword = FocusNode();

  final FocusNode _contact = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    //! email
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter your email";
                        } else if (!value
                            .contains(RegExp("^[a-zA-Z0-9]+@+.[a-zA-Z]"))) {
                          return "Enter valid email";
                        }
                      },
                      onFieldSubmitted: (text) {
                        FocusScope.of(context).requestFocus(_password);
                      },
                      onSaved: (val) {
                        email = val!;
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
                          borderRadius: BorderRadius.circular(25),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        labelText: "Enter your email",
                        suffixIcon: const Icon(
                          Icons.email,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    //! password
                    TextFormField(
                      focusNode: _password,
                      controller: passwordController,
                      validator: (conform) {
                        if (conform!.isEmpty) {
                          return "Enter your password";
                        } else if (conform.length < 8) {
                          return "too short \n Enter minimum 8 characters";
                        }
                      },
                      onFieldSubmitted: (text) {
                        FocusScope.of(context).requestFocus(_conformPassword);
                      },
                      onSaved: (val) {
                        password = val!;
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "Password",
                        contentPadding: const EdgeInsets.only(left: 40),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        labelText: "Enter your password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: obscureText
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.red,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    //! conform password
                    ConformPassword(
                      focusNodeId: _conformPassword,
                      conformPasswordController: conformPasswordController,
                      forNextFocus: _contact,
                      forChekPassword: passwordController,
                    ),

                    const SizedBox(height: 30),

                    //! contact
                    Contact(
                      focusNodeId: _contact,
                      ContactController: contactController,
                    ),

                    const SizedBox(height: 30),

                    //! alredy account.?  btn
                    const AlredyAccountLine(),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.deepOrange,
                          value: checked,
                          onChanged: (value) {
                            setState(() {
                              checked = !checked;
                            });
                          },
                        ),
                        const Flexible(
                          child: Text(
                            'By creating account, I agree to Terms & Conditions and Privacy Policy.',
                          ),
                        ),
                      ],
                    ),

                    //! login btn
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 14),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          Authantication()
                              .singUp(
                            email: email,
                            password: password,
                          )
                              .then(
                            (result) {
                              if (result == null) {
                                FirebaseFirestore.instance
                                    .collection("userdata")
                                    .doc(email.trim())
                                    .set(
                                  {
                                    "data": [],
                                  },
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      email: emailController,
                                      email2: emailController,
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              }
                            },
                          );

                          // print("object");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const HomeScreen(),
                          //   ),
                          // );
                        } else {
                          return print("not validate object");
                        }
                      },
                      child: const Text(
                        "Create",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlredyAccountLine extends StatelessWidget {
  const AlredyAccountLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          },
          child: const Text(
            " LogIn",
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
