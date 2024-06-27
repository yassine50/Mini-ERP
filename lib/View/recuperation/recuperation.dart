import 'package:flutter/material.dart';
import 'package:pfe/backendClass/firebaseAuth.dart';
import 'package:pfe/widgets/button/blueButton.dart';
import 'package:pfe/widgets/forms/inputFild.dart';
import 'package:pfe/widgets/popups/Allpop.dart';

class Recuperation extends StatefulWidget {
  const Recuperation({super.key});

  @override
  State<Recuperation> createState() => _recuperationState();
}

class _recuperationState extends State<Recuperation> {
  TextEditingController email = TextEditingController(); 
  void openLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  //image
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                    width: 900,
                  ),
                 const  SizedBox(
                    height: 100,
                  ),
                  //title
                   const  Text(
                    'Taper votre Email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    SizedBox(height: 8,),
                   InputFild(controller: email, hint: 'Enter votre email',) , 
                  
              
                  //subtitle
              
                  SizedBox(
                    height: 30,
                  ),
                  BlueBotton(ontap: () {
                    if(email.text != "" ) {
                      FirebaseAuths.ResetPassword(email.text) ; 
                      Navigator.pop(context); 
                      Allpups.succsess(context, "Opération réussie. Veuillez vérifier votre e-mail.") ; 
                    }
                  }),
                  //Emailtextfield
                 
                 
                  
              
                 
                  SizedBox(height: 50),
              
                  //text sign up
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
