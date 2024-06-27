import 'package:flutter/material.dart';

class BlueBotton extends StatelessWidget {
  final VoidCallback ontap  ; 
  final String hint  ; 
  const BlueBotton({super.key, required this.ontap,  this.hint = "connecter" , });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 3, 52, 212),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              hint,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
