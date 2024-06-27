import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/DataClass/Task.dart';
import 'package:pfe/View/AjouterTech/ajouterTech.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/backendClass/fb_storage.dart';
import 'package:pfe/widgets/button/blueButton.dart';
import 'package:pfe/widgets/button/profileButton.dart';
import 'package:pfe/widgets/cashedImage/cashedImage.dart';
import 'package:pfe/widgets/dropDownButton/dropDownButton.dart';
import 'package:pfe/widgets/forms/inputTitre.dart';
import 'package:pfe/widgets/text/text.dart';

class Task extends StatefulWidget {
  final bool assgined;
  final String titre;
  final String desc;
  final String status;
  final String priority;
  final String dateCreation;
  final int id;
  const Task(
      {super.key,
      required this.assgined,
      required this.titre,
      required this.desc,
      required this.status,
      required this.priority,
      required this.dateCreation,
      required this.id});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
   Future<String> _fetchImage(String id) async {
    print("/profile/" + id.toString() + "/profileimage");
//  FB_Storage().imageTasks("tasks/"+widget.id.toString()) ;
    return await FB_Storage()
        .Get_file("/profile/" + id.toString() + "/profileimage");
  }

  Future<String> _fullname(String id) async {
    print("/profile/" + id.toString() + "/profileimage");
//  FB_Storage().imageTasks("tasks/"+widget.id.toString()) ;
//  print(id);
// print(await FB_RBD().GetData("/Accounts/"+id+"/fullName") );
    Map reuslt = await FB_RBD().GetData("/Accounts/");

    return reuslt[id]["fullName"];
  }
  TextEditingController titre = TextEditingController();

  Future<List<String>> _fetchImageTask() async {
//  FB_Storage().imageTasks("tasks/"+widget.id.toString()) ;
    return await FB_Storage().imageTasks("tasks/" + widget.id.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference task = FirebaseDatabase.instance
        .reference()
        .child("/Tasks/" + widget.id.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).shadowColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AllText.text(
            text: "Détails de la tâche",
            color: Theme.of(context).shadowColor,
            fontsize: 18,
            FontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          StreamBuilder(
              stream: task.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //Account().list_course = [] ;
                  TaskData ts = TaskData();
                  DatabaseEvent data = snapshot.data as DatabaseEvent;
                  if (data.snapshot.value != null &&
                      data.snapshot.value is Map) {
                    (data.snapshot.value as Map<dynamic, dynamic>)
                        .entries
                        .map((entry) {
                  
                      if (entry.key == "status") {
                        ts.status = entry.value;
                      } else if (entry.key == "assgined") {
                        Map<String, String> reuslt = {};
if (entry.value is Map) {
  reuslt = Map<String, String>.from(entry.value);
      ts.assgined = reuslt.values.toList();
}
                        
                       
                      } else if (entry.key == "") {
                      } else if (entry.key == "") {
                      } else if (entry.key == "") {
                      } else if (entry.key == "") {
                      } else if (entry.key == "") {
                      } else if (entry.key == "") {}
                      print(entry.value);
                    }).toList();
                    // state.league.team[index].nbVote = 5 ;
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(21)),
                              color: Color(0xFFD9D9D9)),
                          child: AllText.text(
                              fontsize: 18,
                              color: Colors.black,
                              FontWeight: FontWeight.bold,
                              text: widget.titre),
                          //  InputFildTitre(controller: titre, hint: 'Titre de la tâche',) ,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        AllText.text(
                            fontsize: 12,
                            color: const Color(0xFF9B9B9B),
                            FontWeight: FontWeight.w400,
                            text: widget.desc),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AllText.text(
                                fontsize: 18,
                                color: Colors.black,
                                FontWeight: FontWeight.bold,
                                text: "Statut"),
                            if (Account().type == "user" ||
                                Account().type == "doyen" ||
                                Account().type == "admin") ...{
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 36),
                                height: 24,
                                decoration: const BoxDecoration(
                                    color: Color(0xFF3053EC),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: AllText.text(
                                    fontsize: 13,
                                    color: Colors.white,
                                    FontWeight: FontWeight.w400,
                                    text: ts.status!),
                              )
                            } else ...{
                              DropDuwnButton(
                                initvalue: widget.status,
                                taskid: widget.id,
                                list: const [
                                 
                                  "a faire",
                                  "en attente",
                                  "en cours",
                                  "complete"
                                ],
                                width: 150,
                              )
                            },
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AllText.text(
                                fontsize: 18,
                                color: Colors.black,
                                FontWeight: FontWeight.bold,
                                text: "Priorité"),
                            if (Account().type == "tech" ||
                                Account().type == "user" ||
                                Account().type == "admin") ...{
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 36),
                                height: 24,
                                decoration: const BoxDecoration(
                                    color: Color(0xFF3053EC),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: AllText.text(
                                    fontsize: 13,
                                    color: Colors.white,
                                    FontWeight: FontWeight.w400,
                                    text: widget.priority),
                              )
                            } else ...{
                              DropDuwnButton(
                                  taskid: widget.id,
                                initvalue: widget.priority,
                                list: const ["Urgente", "Élevée", "Normale", "Basse"],
                                width: 120,
                              )
                            },

                            // DropDuwnButton(list: ["dw","dawdwa"],)
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AllText.text(
                                fontsize: 18,
                                color: Colors.black,
                                FontWeight: FontWeight.bold,
                                text: "date de création"),
                            AllText.text(
                                fontsize: 18,
                                color: Colors.black,
                                FontWeight: FontWeight.bold,
                                text: widget.dateCreation),

                            // DropDuwnButton(list: ["dw","dawdwa"],)
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                           if (Account().type != "user") ...{
            Container(
                alignment: Alignment.centerLeft,
                child: AllText.text(
                    fontsize: 18,
                    color: Colors.black,
                    FontWeight: FontWeight.bold,
                    text: "Assigné à")),
            const SizedBox(
              height: 8,
            ),
            if( widget.assgined || ts.assgined != null ) ...{
              if (widget.assgined || ts.assgined!.isNotEmpty  ) ...{
              Container(
                height: 80,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < ts.assgined!.length; i++) ...{
                                      const SizedBox(width: 8),
                                      Column(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FutureBuilder<String>(
                                            future: _fetchImage(ts.assgined![
                                                i]), // Ensuring this method is called here.
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator()); // Changed to show a loading spinner.
                                              } else if (snapshot.hasError) {
                                                print(snapshot.error);
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else if (snapshot.hasData) {
                                                return Container(
                                                  margin: const EdgeInsets.only(top: 0),
                                                  child: ClipRRect(
                                                                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                                                    child: CachedImage(
                                                      img: snapshot
                                                          .data!, // Directly use the URL from the snapshot.
                                                      box: BoxFit.cover,
                                                      height: 54,
                                                      width: 54,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const Text("No image found.");
                                              }
                                            },
                                          ),
                                          FutureBuilder<String>(
                                            future: _fullname(ts.assgined![
                                                i]), // Ensuring this method is called here.
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator()); // Changed to show a loading spinner.
                                              } else if (snapshot.hasError) {
                                                print(snapshot.error);
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else if (snapshot.hasData) {
                                                return AllText.text(
                                                    fontsize: 16,
                                                    color: Colors.black,
                                                    FontWeight: FontWeight.bold,
                                                    text: snapshot.data!);
                                              } else {
                                                return const Text("No image found.");
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                    }
                    ],
                  ),
                ),
              ),
            } else ...{
              ProfileButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AjouterTech(
                              titre: widget.titre,
                              id: widget.id,
                            )),
                  );
                },
                text: 'Ajouter',
                width: 200,
                outlindedbutton: true,
              ),
              // BlueBotton(ontap: () {

              // } , hint: "Ajouter",)
              const SizedBox(
                height: 24,
              )
            },

            }else ...{
              ProfileButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AjouterTech(
                              titre: widget.titre,
                              id: widget.id,
                            )),
                  );
                },
                text: 'Ajouter',
                width: 200,
                outlindedbutton: true,
              ),
              // BlueBotton(ontap: () {

              // } , hint: "Ajouter",)
              const SizedBox(
                height: 24,
              )
            },
            
          },
                      ],
                    );
                  }
                }
                return Container();
              }),
       
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder<List<String>>(
                    future: _fetchImageTask(), // Ensure this is being called here.
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                              child: AllText.text(
                                  fontsize: 14,
                                  color: Colors.black,
                                  FontWeight: FontWeight.bold,
                                  text: "Chargement"));
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return Container(
                              child: Row(
                                children: [
                                  for (var imageUrl in snapshot.data!) ...{
                                    Container(
                                      height: double.infinity,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 12),
                                      child: CachedImage(
                                        img:
                                            imageUrl, // Use actual image URL from the list
                                        box: BoxFit.cover,
                                      ),
                                    )
                                  }
                                ],
                              ),
                            );
                          } else {
                            return const Text("No images found.");
                          }
                      }
                    },
                  ))),
          const SizedBox(
            height: 24,
          )
        ]),
      ),
    );
  }
}
