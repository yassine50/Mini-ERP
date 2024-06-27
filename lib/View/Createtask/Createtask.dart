import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/View/Createtask/function.dart';
import 'package:pfe/View/Createtask/gallary.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/backendClass/fb_storage.dart';
import 'package:pfe/widgets/button/profileButton.dart';
import 'package:pfe/widgets/dropDownButton/dropDownButton.dart';
import 'package:pfe/widgets/forms/inputTitre.dart';
import 'package:pfe/widgets/popups/Allpop.dart';
import 'package:pfe/widgets/text/text.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final ImagePicker _picker = ImagePicker();
  TextEditingController titre = TextEditingController();
  TextEditingController desc = TextEditingController();
  String? image;

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
            text: "Créer une tâche",
            color: Theme.of(context).shadowColor,
            fontsize: 18,
            FontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Your form widgets here
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(21)),
                        color: Color(0xFFD9D9D9)),
                    child: InputFildTitre(
                        controller: titre, hint: 'Titre de la tâche'),
                  ),
                  SizedBox(height: 12),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: AllText.text(
                          FontWeight: FontWeight.bold,
                          fontsize: 14,
                          color: Colors.black,
                          text: 'Description')),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFD4D4D4),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      minLines: 6,
                      maxLines: null,
                      cursorColor: Colors.black,
                      controller: desc,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: "Entrez votre description",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AllText.text(
                          fontsize: 18,
                          color: Colors.black,
                          FontWeight: FontWeight.bold,
                          text: "Priorité"),
                      DropDuwnButton(
                          taskid: null,
                          initvalue: "Urgente",
                          list: ["Urgente", "Élevée", "Normale", "Basse"],
                          width: 120),
                    ],
                  ),
                  if (image != null) ...{
                    Container(
                      height: 120,
                      width: 100,
                      child: Image.asset(image!),
                    ),
                  },
                  SizedBox(height: 36),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 24), child: Gallary()),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileButton(
                    onTap: () {
                      setState(() {
                        GallaryState.images.clear();
                        titre.clear();
                      });
                    },
                    text: 'Annuler',
                    width: 125,
                    outlindedbutton: true,
                  ),
                  ProfileButton(
                    onTap: () async {
                      if (titre.text == "" ||
                          desc.text == "" ||
                          GallaryState.images.isEmpty) {
                        Allpups.warningPopup(
                            context, "Vous devez remplir les données");
                      } else {
                        Allpups.loading(context);
                        int timestampInSeconds =
                            DateTime.now().millisecondsSinceEpoch ~/ 1000;
                        await FB_RBD().Update_Data("Tasks", {
                          timestampInSeconds.toString(): {
                            "title": titre.text,
                            "desc": desc.text,
                            "status": "notAssgined",
                            "priority": DropDuwnButtonState.dropdownValue,
                            "createdBy": Account().id,
                          }
                        });

                        for (int i = 0; i < GallaryState.images.length; i++) {
                          await FB_Storage().Upload_Images(
                              GallaryState.images[i].path,
                              i.toString(),
                              timestampInSeconds.toString());
                        }
                        
                        GallaryState.images.clear();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Allpups.succsess(
                            context, "La tâche a été créée avec succès.");
                      }
                    },
                    text: 'Confirmer',
                    width: 125,
                    outlindedbutton: false,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
