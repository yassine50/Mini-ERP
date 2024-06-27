import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/View/AjouterTech/ajouterTech.dart';
import 'package:pfe/View/Profile/Profile.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/backendClass/fb_storage.dart';
import 'package:pfe/widgets/cashedImage/cashedImage.dart';
import 'package:pfe/widgets/text/text.dart';

class RechrcheEquipe extends StatefulWidget {
   Tech tec ; 
  final VoidCallback ontap;
  final bool send;
  final int Index;
  final int afaire;
  final int tacheEnCours;
  final String phone;
  final String name;
  final String id;
  final String email;
  final int taskId;
   RechrcheEquipe({
    super.key,
    required this.send,
    required this.Index,
    required this.afaire,
    required this.tacheEnCours,
    required this.phone,
    required this.name,
    required this.id,
    required this.email,
    required this.ontap,
    required this.taskId, required this.tec,
  });

  @override
  State<RechrcheEquipe> createState() => _RechrcheEquipeState();
}

class _RechrcheEquipeState extends State<RechrcheEquipe> {
  late bool send;
  Future<String> _fetchImage() async {
    print("/profile/" + widget.id.toString() + "/profileimage");
//  FB_Storage().imageTasks("tasks/"+widget.id.toString()) ;
      widget.tec.photo   =  await FB_Storage() .Get_file("/profile/" + widget.id.toString() + "/profileimage");
    return await FB_Storage() .Get_file("/profile/" + widget.id.toString() + "/profileimage");
  }

  @override
  void initState() {
    send = widget.send;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Profile(
                tech: widget.tec,
                    me: false,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(width: 8),
            Container(
              width: 65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "team_" + widget.Index.toString(),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        child: FutureBuilder<String>(
                          future:
                              _fetchImage(), // Ensuring this method is called here.
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child:
                                      CircularProgressIndicator()); // Changed to show a loading spinner.
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              return CachedImage(
                                img: snapshot
                                    .data!, // Directly use the URL from the snapshot.
                                box: BoxFit.cover,
                                height: 54,
                                width: 54,
                              );
                            } else {
                              return Text("No image found.");
                            }
                          },
                        )),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: 2,
              height: 100,
              color: Colors.grey,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Tache A faire: " + widget.afaire.toString(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tache en cours: " + widget.tacheEnCours.toString(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone: " + widget.phone.toString(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 6, right: 6),
                  height: 40,
                  width: 90,
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 6, right: 6),
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: send
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        border: Border.all(
                          color: send
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                    child: GestureDetector(
                      onTap: () async {
                        if (send == false) {
                         await  FB_RBD().Update_Data(
                              "Tasks/" +
                                  widget.taskId.toString() +
                                  "/assgined/",
                              {widget.id: widget.id});

                             await FB_RBD().Update_Data(
                              "Tasks/" +
                                  widget.taskId.toString() 
                                  ,
                              {"status": "a faire"});

                        } else {
                         await  FB_RBD().Delete_Data("Tasks/" +
                              widget.taskId.toString() +
                              "/assgined/" +
                              widget.id);
                             int verif= await FB_RBD().Number_node( "Tasks/" +widget.taskId.toString()+"/assgined") ; 
                             if(verif == 0 ) {
                              FB_RBD().Update_Data(
                              "Tasks/" +
                                  widget.taskId.toString() 
                                  ,
                              {"status": "notAssgined"});
                             }
                        }

                        setState(() => send = !send);
                      },
                      child: Text(
                        send ? "Annuler" : "Ajouter",
                        style: TextStyle(
                          color: send
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
