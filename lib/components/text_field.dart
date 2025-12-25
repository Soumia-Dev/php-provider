import 'package:flutter/material.dart';

class TextFieldBuild extends StatelessWidget {
  const TextFieldBuild({
    super.key,
    required this.hint,
    required this.myController,
    this.maxLines,
  });
  final String hint;
  final TextEditingController myController;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        maxLines: maxLines,
        controller: myController,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "please enter your $hint";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }
}
