import 'package:flutter/material.dart';

class Search extends StatelessWidget {
   final VoidCallback ontap  ; 
  final TextEditingController controller;
  final String hint;
  final IconData iconData;

  Search({
    super.key,
    required this.controller,
    required this.hint,
    this.iconData = Icons.search, required this.ontap, // Default icon is search
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    final inputDecoration = InputDecoration(
      contentPadding: EdgeInsets.only(left: 18, right: 18, top: 10),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey),
      ),
      prefixIcon: Icon(iconData),
      focusColor: Colors.black,
    );

    return Container(
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        onChanged:  (value) {
          ontap ; 
        },
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        style: textStyle,
        decoration: inputDecoration,
      ),
    );
  }
}
