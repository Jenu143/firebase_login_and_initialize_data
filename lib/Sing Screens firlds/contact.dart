import 'package:flutter/material.dart';

//! conform password field
class Contact extends StatefulWidget {
  const Contact({
    Key? key,
    required this.focusNodeId,
    required this.ContactController,
  }) : super(key: key);

  final FocusNode focusNodeId;

  final TextEditingController ContactController;

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNodeId,
      controller: widget.ContactController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter your number";
        } else if (value.length < 10) {
          return "Enter valid phone number";
        }
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: "Phone number",
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
          labelText: "Enter your phone number",
          suffixIcon: Icon(Icons.call)),
      onFieldSubmitted: (text) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}
