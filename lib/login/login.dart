import 'package:firebase_login_and_initialize_data/Firebase/auth.dart';
import 'package:firebase_login_and_initialize_data/Firebase/reset_password.dart';
import 'package:firebase_login_and_initialize_data/home/home_screen.dart';
import 'package:firebase_login_and_initialize_data/register/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  late String email;
  late String password;
  bool _obscureText = true;

  final FocusNode _password = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //! email
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your email";
                    } else if (!value.trim().contains(
                          RegExp("^[a-zA-Z0-9]+@+.[a-zA-Z]"),
                        )) {
                      return "Enter valid email";
                    }
                  },
                  onFieldSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_password);
                  },
                  onSaved: (val) {
                    email = val!.trim();
                  },
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
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                //! password
                TextFormField(
                  focusNode: _password,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your password";
                    } else if (value.length < 8) {
                      return "Enter Minimum 8 character";
                    }
                  },
                  obscureText: _obscureText,
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
                          _obscureText = !_obscureText;
                        });
                      },
                      child: _obscureText
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
                  onFieldSubmitted: (text) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onSaved: (val) {
                    password = val!;
                  },
                ),
                const SizedBox(height: 35),

                //! login button
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurpleAccent),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      Authantication()
                          .logIn(email: email, password: password)
                          .then(
                        (result) {
                          if (result == null) {
                            Navigator.push(
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
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  result,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPass(),
                      ),
                    );
                  },
                  child: const Text(
                    " Forgot password ?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Create account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: const Text(
                        " SingUp",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
