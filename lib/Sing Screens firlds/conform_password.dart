import 'package:flutter/material.dart';

//! conform password field
class ConformPassword extends StatefulWidget {
  const ConformPassword({
    Key? key,
    required this.focusNodeId,
    required this.conformPasswordController,
    required this.forChekPassword,
    required this.forNextFocus,
  }) : super(key: key);

  final FocusNode focusNodeId;

  final TextEditingController conformPasswordController;
  final TextEditingController forChekPassword;
  final FocusNode forNextFocus;

  @override
  State<ConformPassword> createState() => _ConformPasswordState();
}

class _ConformPasswordState extends State<ConformPassword> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNodeId,
      controller: widget.conformPasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Re enter password";
        } else if (widget.forChekPassword.text != value) {
          return "password is not match!";
        }
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: "Conform password",
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
        labelText: "Enter your conform password",
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
      onFieldSubmitted: (text) {
        FocusScope.of(context).requestFocus(widget.forNextFocus);
      },
    );
  }
}
