import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:pfe/Accessibilities/Tools.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/backendClass/fb_storage.dart';
import 'package:pfe/backendClass/firebaseAuth.dart';
import 'package:pfe/widgets/avatarPhoto/ProfileAvatar.dart';
import 'package:pfe/widgets/button/profileButton.dart';
import 'package:pfe/widgets/dropDownButton/dropDownButton.dart';
import 'package:pfe/widgets/forms/inputFild.dart';
import 'package:pfe/widgets/popups/Allpop.dart';
import 'package:pfe/widgets/text/text.dart';

class CreateAccount extends StatefulWidget {
  final Tech tech;
  final bool update;
  const CreateAccount({super.key, required this.tech, required this.update});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    name.text = widget.tech.fullName!;
    email.text = widget.tech.email!;
    phone.text = widget.tech.phone!;
    img = widget.tech.photo!;

    super.initState();
  }

  String img = "";
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).shadowColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AllText.text(
            text: "Créer compte",
            color: Theme.of(context).shadowColor,
            fontsize: 18,
            FontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileAvatar(imageUrl: img),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: AllText.text(
                          fontsize: 16,
                          color: Colors.black,
                          FontWeight: FontWeight.bold,
                          text: "Nom et Prénom")),
                  InputFild(
                      controller: name, hint: "Entrez votre nom et prénom"),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: AllText.text(
                          fontsize: 16,
                          color: Colors.black,
                          FontWeight: FontWeight.bold,
                          text: "Téléphone")),
                  InputFild(
                    controller: phone,
                    hint: "Entrez votre numéro téléphone",
                    keybord: TextInputType.phone,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: AllText.text(
                          fontsize: 16,
                          color: Colors.black,
                          FontWeight: FontWeight.bold,
                          text: "Date de naissance")),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AllText.text(
                                fontsize: 14,
                                color: Colors.grey,
                                FontWeight: FontWeight.w400,
                                text: DateFormat('yyyy/MM/dd')
                                    .format(selectedDate)
                                    .toString()),
                            Icon(Icons.calendar_month_outlined)
                          ]),
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: AllText.text(
                          fontsize: 16,
                          color: Colors.black,
                          FontWeight: FontWeight.bold,
                          text: "Email")),
                  InputFild(
                    controller: email,
                    hint: "Entrez votre Email",
                    keybord: TextInputType.emailAddress,
                    edit: !widget.update,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: AllText.text(
                          fontsize: 16,
                          color: Colors.black,
                          FontWeight: FontWeight.bold,
                          text: "mot de passe")),
                  InputFild(
                    controller: pass,
                    hint: "Entrez votre  mot de passe",
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AllText.text(
                          fontsize: 18,
                          color: Colors.black,
                          FontWeight: FontWeight.bold,
                          text: "Type"),
                      const DropDuwnButton(
                        taskid: null,
                        initvalue: "technicien",
                        list: [
                          "technicien",
                          "utilisateur",
                          "responsable administratif",
                          "admin"
                        ],
                        width: 260,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileButton(
                        onTap: () async {
                          if (name.text == "" ||
                              phone.text == "" ||
                              selectedDate == DateTime.now() ||
                              email.text == "" ||
                              pass.text == "" ||
                              ProfileAvatarState.img == null) {
                            // Handle form validation failure
                          } else {
                            if (widget.update) {
                              Navigator.pop(context);
                              Allpups.succsess(context,
                                  "Le nouvel mise a jour a effectué avec succès.");
                              FB_RBD().Update_Data(
                                  "Accounts/" + Tools.Cast_email(email.text), {
                                "fullName": name.text,
                                "phone": phone.text,
                                "type": DropDuwnButtonState.dropdownValue
                                    .toString(),
                              });
                              FB_Storage().Upload_File(
                                  ProfileAvatarState.img!.path,
                                  "profileimage",
                                  Tools.Cast_email(email.text));
                            } else {
                              bool result = await FirebaseAuths.signUp(
                                  email.text, pass.text);
                              if (result == true) {
                                Allpups.loading(context);

                                await FB_RBD().Update_Data("Accounts", {
                                  Tools.Cast_email(email.text): {
                                    "email": email.text,
                                    "fullName": name.text,
                                    "phone": phone.text,
                                    "type": DropDuwnButtonState.dropdownValue ==
                                            "responsable administratif"
                                        ? "doyen"
                                        : DropDuwnButtonState.dropdownValue,
                                    "afaire": 0,
                                    "tacheEnCours": 0,
                                  }
                                });
                                await FB_Storage().Upload_File(
                                    ProfileAvatarState.img!.path,
                                    "profileimage",
                                    Tools.Cast_email(email.text));

                                Navigator.pop(context);
                                Navigator.pop(context);
                                Allpups.succsess(context,
                                    "Le nouvel utilisateur a été créé avec succès.");
                                ProfileAvatarState.img = null;

                                final Email emailToSend = Email(
                                  body:
                                      "Bonjour,\n\nVoici vos identifiants de connexion pour accéder à la plateforme :\n\nEmail: ${email.text}\nMot de passe: ${pass.text}\n\nNous vous recommandons de changer votre mot de passe après votre première connexion pour des raisons de sécurité.\n\nCordialement,",
                                  subject:
                                      'Informations de Connexion à la Plateforme',
                                  recipients: [email.text],
                                  isHTML: false,
                                );
                                await FlutterEmailSender.send(emailToSend);
                              }
                            }
                          }
                        },
                        text: 'Confirmer',
                        width: 125,
                        outlindedbutton: false,
                      )
                    ],
                  )
                ]),
          )),
    );
  }
}
