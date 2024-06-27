import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/backendClass/fb_storage.dart';
import 'package:pfe/widgets/Card/rechercheEquipeCard.dart';
import 'package:pfe/widgets/button/profileButton.dart';
import 'package:pfe/widgets/cashedImage/cashedImage.dart';
import 'package:pfe/widgets/forms/search.dart';
import 'package:pfe/widgets/text/text.dart';

class AjouterTech extends StatefulWidget {
  final String titre;
  final int id;
  const AjouterTech({super.key, required this.titre, required this.id});

  @override
  State<AjouterTech> createState() => AjouterTechState();
}

class AjouterTechState extends State<AjouterTech> {
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

  static List<Tech> techss = [];
  final DatabaseReference techs =
      FirebaseDatabase.instance.reference().child("/Accounts");
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DatabaseReference task = FirebaseDatabase.instance
        .reference()
        .child("/Tasks/" + widget.id.toString() + "/assgined");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).shadowColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(21)),
                  color: Color(0xFFD9D9D9)),
              child: AllText.text(
                  fontsize: 18,
                  color: Colors.black,
                  FontWeight: FontWeight.bold,
                  text: widget.titre),
              //  InputFildTitre(controller: titre, hint: 'Titre de la tâche',) ,
            ),
            Search(
              ontap: () {
                setState(() {
                  search.text = search.text;
                });
              },
              controller: search,
              hint: 'Recherche',
            ),
            Expanded(
              child: StreamBuilder(
                  stream: techs.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //Account().list_course = [] ;
                      List<Tech> AllTech = [];
                      DatabaseEvent data = snapshot.data as DatabaseEvent;
                      if (data.snapshot.value != null &&
                          data.snapshot.value is Map) {
                        (data.snapshot.value as Map<dynamic, dynamic>)
                            .entries
                            .map((entry) {
                          if (search.text == "") {
                          } else {}
                          if (entry.value["type"] == "technicien") {
                            Tech te = Tech();
                            te.afaire = entry.value["afaire"];
                            te.id = entry.key.toString();
                            te.fullName = entry.value["fullName"];
                            te.phone = entry.value["phone"];
                            te.tacheEnCours = entry.value["tacheEnCours"];
                            te.email = entry.value["email"];
                            te.type = entry.value["type"] ; 
                          
                            if (search.text == "") {
                              AllTech.add(te);
                            } else {
                              if (te.fullName!.contains(search.text)) {
                                AllTech.add(te);
                              }
                            }
                          }
                        }).toList();
                        // state.league.team[index].nbVote = 5 ;
                        return ListView.builder(
                          itemCount: AllTech.length,
                          itemBuilder: (context, index) {
                            return RechrcheEquipe(
                              tec: AllTech[index],
                              taskId: widget.id,
                              send: false,
                              Index: 0,
                              tacheEnCours: AllTech[index].tacheEnCours!,
                              afaire: AllTech[index].afaire!,
                              name: AllTech[index].fullName!,
                              phone: AllTech[index].phone!,
                              id: AllTech[index].id!,
                              email: AllTech[index].email!,
                              ontap: () {},
                            );
                          },
                        );
                      }
                    }
                    return Container();
                  }),
            ),
            StreamBuilder(
                stream: task.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //Account().list_course = [] ;
                    List<String> Allid = [];
                    DatabaseEvent data = snapshot.data as DatabaseEvent;
                    if (data.snapshot.value != null &&
                        data.snapshot.value is Map) {
                      (data.snapshot.value as Map<dynamic, dynamic>)
                          .entries
                          .map((entry) {
                        print(entry.value);
                        Allid.add(entry.value);
                      }).toList();
                      // state.league.team[index].nbVote = 5 ;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AllText.text(
                                  fontsize: 18,
                                  color: Colors.black,
                                  FontWeight: FontWeight.bold,
                                  text: "Tech Ajouter"),
                              AllText.text(
                                  fontsize: 20,
                                  color: Colors.grey,
                                  FontWeight: FontWeight.bold,
                                  text: Allid.length.toString())
                            ],
                          ),
                          Container(
                            height: 100,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < Allid.length; i++) ...{
                                      SizedBox(width: 8),
                                      Column(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FutureBuilder<String>(
                                            future: _fetchImage(Allid[
                                                i]), // Ensuring this method is called here.
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator()); // Changed to show a loading spinner.
                                              } else if (snapshot.hasError) {
                                                print(snapshot.error);
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else if (snapshot.hasData) {
                                                return Container(
                                                  margin: EdgeInsets.only(top: 18),
                                                  child: ClipRRect(
                                                                          borderRadius: BorderRadius.all(Radius.circular(40)),
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
                                                return Text("No image found.");
                                              }
                                            },
                                          ),
                                          FutureBuilder<String>(
                                            future: _fullname(Allid[
                                                i]), // Ensuring this method is called here.
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
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
                                                return Text("No image found.");
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 8),
                                    }
                                  ],
                                )),
                          ),
                        ],
                      );
                    }
                  }
                  return Container();
                }),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       ProfileButton(
            //         onTap: () {},
            //         text: 'Annuler',
            //         width: 125,
            //         outlindedbutton: true,
            //       ),
            //       ProfileButton(
            //         onTap: () {},
            //         text: 'Confirmer',
            //         width: 125,
            //         outlindedbutton: false,
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            )
          ],
        ),
      ),
    );
  }
}
