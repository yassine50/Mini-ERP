import 'package:flutter/material.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/backendClass/firebaseAuth.dart';
import 'package:pfe/widgets/button/profileButton.dart';
import 'package:pfe/widgets/forms/inputFild.dart';
import 'package:pfe/widgets/popups/Allpop.dart';
import 'package:pfe/widgets/text/text.dart';

class Pass extends StatefulWidget {
  const Pass({super.key});

  @override
  State<Pass> createState() => _PassState();
}

class _PassState extends State<Pass> {
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  void _updatePassword() {
    String oldPassword = oldpass.text;
    String newPassword = newpass.text;
    String confirmPassword = confirmpass.text;

    if (Account().password == oldPassword) {
      if (newPassword == confirmPassword) {
        FirebaseAuths.Change_password(newPassword);
        Allpups.succsess(context, "Mot de passe changé avec succès");
      } else {
        Allpups.warningPopup(context, "Les mots de passe ne correspondent pas");
      }
    } else {
      Allpups.warningPopup(context, "L'ancien mot de passe est incorrect");
    }

    oldpass.clear();
    newpass.clear();
    confirmpass.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: false,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12,),
            AllText.text(fontsize: 16, color: Colors.black, FontWeight: FontWeight.w400, text: "Ancien mot de passe"),
            SizedBox(height: 8,),
            InputFild(controller: oldpass, hint: "Entrez votre ancien mot de passe", obscureText: true),
            SizedBox(height: 12,),
            AllText.text(fontsize: 16, color: Colors.black, FontWeight: FontWeight.w400, text: "Nouveau mot de passe"),
            SizedBox(height: 8,),
            InputFild(controller: newpass, hint: "Entrez votre nouveau mot de passe", obscureText: true),
            SizedBox(height: 12,),
            AllText.text(fontsize: 16, color: Colors.black, FontWeight: FontWeight.w400, text: "Confirmer mot de passe"),
            SizedBox(height: 8,),
            InputFild(controller: confirmpass, hint: "Confirmez votre nouveau mot de passe", obscureText: true),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ProfileButton(
                  onTap: _updatePassword,
                  text: 'Confirmer',
                  width: 130,
                  outlindedbutton: false,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
