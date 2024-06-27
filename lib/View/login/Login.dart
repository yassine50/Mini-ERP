import 'package:flutter/material.dart';
import 'package:pfe/Accessibilities/Tools.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/View/googleNav/googleNav.dart';
import 'package:pfe/View/recuperation/recuperation.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/backendClass/fb_storage.dart';
import 'package:pfe/backendClass/firebaseAuth.dart';
import 'package:pfe/hive/LocalStorage.dart';

import 'package:pfe/widgets/button/blueButton.dart';
import 'package:pfe/widgets/forms/inputFild.dart';
import 'package:pfe/widgets/popups/Allpop.dart';
import 'package:pfe/widgets/text/text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  Future connecter() async {
    if (email.text == "" || pass == "") {
      Allpups.warningPopup(context, "Vous devez remplir les données");
    } else {
      FirebaseAuths.signIn(email.text, pass.text).then((value) async {
        if (value == 1) {
          Allpups.loading(context);
          Account().email = email.text;
          Account().password = pass.text;
          Account().id = Tools.Cast_email(email.text);
          Map result = await FB_RBD().GetData("Accounts/" + Account().id!);
          if (result["type"] == "technicien") {
            Account().type = "tech";
          } else if (result["type"] == "utilisateur") {
            Account().type = "user";
          } else {
            Account().type = result["type"];
          }

          Account().phone = result["phone"];
          Account().fullName = result["fullName"];
          Account().photo = await _fetchImage(Account().id!);

          Navigator.pop(context);
          if (!await FB_RBD()
              .verif_path("Accounts/" + Account().id.toString() + "/deleted")) {
            Allpups.warningPopup(context, "ce compte a été supprimé");
          } else {
            LocalStorage.SaveUser();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GoogleNavBar()),
            );
          }
        } else if (value == -11) {
          Allpups.warningPopup(context,
              "Le mot de passe ou le email que vous avez entré est incorrect");
          //  Allpups.warningPopup(context, "Aucun utilisateur trouvé pour cet e-mail.") ;
        } else if (value == -12) {
          // Allpups.warningPopup(context, "Le mot de passe que vous avez entré est incorrect") ;
        }
      });
    }
  }

  Future<String> _fetchImage(String id) async {
    print("/profile/" + id.toString() + "/profileimage");
//  FB_Storage().imageTasks("tasks/"+widget.id.toString()) ;
    return await FB_Storage()
        .Get_file("/profile/" + id.toString() + "/profileimage");
  }

  recuperation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Recuperation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200,
                width: 200,
              ),
              SizedBox(
                height: 10,
              ),
              AllText.text(
                  fontsize: 30,
                  color: Colors.black,
                  FontWeight: FontWeight.bold,
                  text: "Bienvenue"),
              AllText.text(
                  fontsize: 14,
                  color: Colors.grey,
                  FontWeight: FontWeight.normal,
                  text:
                      "Accédez à votre compte, invitez vos amis et réservez votre stade."),
              SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: AllText.text(
                    fontsize: 14,
                    color: Colors.black,
                    FontWeight: FontWeight.bold,
                    text: "Email"),
              ),
              InputFild(
                controller: email,
                hint: 'Entrez votre Email',
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: AllText.text(
                    fontsize: 14,
                    color: Colors.black,
                    FontWeight: FontWeight.bold,
                    text: "Mot de passe"),
              ),

              InputFild(
                obscureText: true,
                controller: pass,
                hint: 'Mot de passe',
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: recuperation,
                child: AllText.text(
                    fontsize: 14,
                    color: Color.fromARGB(255, 19, 27, 153),
                    FontWeight: FontWeight.normal,
                    text: "mot de passe oublier?."),
              ),
              SizedBox(height: 30),
              BlueBotton(
                ontap: connecter,
              ),
              //sign in button
            ],
          ),
        ),
      ),
    );
  }
}
