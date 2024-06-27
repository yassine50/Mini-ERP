import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfe/backendClass/fb_rdb.dart';

class InputFild extends StatelessWidget {
  final TextInputType keybord ;
  final TextEditingController controller;
  final String? idTask ; 
  final String hint;
  final bool obscureText;
  final bool edit ; 

  const InputFild({
    Key? key,
    required this.controller,
    required this.hint,
    this.obscureText = false,  this.edit =true,  this.keybord = TextInputType.text,  this.idTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if(hint ==  "Entrez note") {
          FB_RBD().Update_Data("/Tasks/"+idTask!, {
            "note": value, 

          }) ; 
        }
      },
      keyboardType: keybord,
      enabled : edit, 
      obscureText: obscureText,
      cursorColor: Colors.black,
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        hintText: hint == "Entrez note" ? "pas de note" :hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Color(0xFF948B8B)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Color(0xFF948B8B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
