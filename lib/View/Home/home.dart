import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/DataClass/Task.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/widgets/Card/tache.dart';
import 'package:pfe/widgets/appBar/HomeAppBar.dart';
import 'package:pfe/widgets/text/text.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  Future<String> _numtech() async {
//  FB_Storage().imageTasks("tasks/"+widget.id.toString()) ;
//  print(id);
// print(await FB_RBD().GetData("/Accounts/"+id+"/fullName") );
    Map reuslt = await FB_RBD().GetData("/Accounts/");
    int i = 0;
    reuslt.forEach((k, v) {
      if (v["type"] == "technicien") {
        i++;
      }
      // print(v) ;
    });

    return i.toString();
  }

  Future<String> _numdoyen() async {
//  FB_Storage().imageTasks("tasks/"+widget.id.toString()) ;
//  print(id);
// print(await FB_RBD().GetData("/Accounts/"+id+"/fullName") );
    Map reuslt = await FB_RBD().GetData("/Accounts/");
    int i = 0;
    reuslt.forEach((k, v) {
      if (v["type"] == "doyen") {
        i++;
      }
      // print(v) ;
    });

    return i.toString();
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference tasks =
        FirebaseDatabase.instance.reference().child("/Tasks");
    return Scaffold(
      appBar: HomeAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder(
            stream: tasks.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //Account().list_course = [] ;
                List<TaskData> notAssginedtasks = [];
                List<TaskData> alltask = [];

                DatabaseEvent data = snapshot.data as DatabaseEvent;
                if (data.snapshot.value != null && data.snapshot.value is Map) {
                  (data.snapshot.value as Map<dynamic, dynamic>)
                      .entries
                      .map((entry) {
                    TaskData ts = TaskData();
                    ts.titre = entry.value["title"];
                    ts.id = int.parse(entry.key);
                    ts.desc = entry.value["desc"];
                    ts.priority = entry.value["priority"];
                    ts.status = entry.value["status"];
                     if(entry.value["note"] != null) {
  ts.note = entry.value["note"];
                                            }
                 

                    alltask.add(ts);
                    print(entry.value);
                    if (Account().type == "doyen" ||
                        Account().type == "admin") {
                      if (ts.status == "notAssgined") {
                        notAssginedtasks.add(ts);
                      }
                    } else {
                      if (entry.value["assgined"] != null) {
                        Map assgined = entry.value["assgined"];
                        if (Account().type == "tech") {
                          if (assgined.containsValue(Account().id)) {
                            notAssginedtasks.add(ts);
                          }
                        }
                      }
                      if (Account().type == "tech") {
                        // if(ts.)
                      } else {
                        notAssginedtasks.add(ts);
                      }
                    }
                  }).toList();
                  // state.league.team[index].nbVote = 5 ;
                  return Column(children: [
                    if (Account().type == "doyen") ...{
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 96,
                            width: 124,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: Colors.blue)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AllText.text(
                                    fontsize: 16,
                                    color: Colors.black,
                                    FontWeight: FontWeight.w400,
                                    text: "Tâche non assigner"),
                                AllText.text(
                                    fontsize: 20,
                                    color: Colors.black,
                                    FontWeight: FontWeight.bold,
                                    text: notAssginedtasks.length.toString()),
                              ],
                            ),
                          ),
                          Container(
                            height: 96,
                            width: 124,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: Colors.blue)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AllText.text(
                                    fontsize: 16,
                                    color: Colors.black,
                                    FontWeight: FontWeight.w400,
                                    text: "tous les techniciens"),
                                FutureBuilder<String>(
                                  future:
                                      _numtech(), // Ensuring this method is called here.
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
                                      return AllText.text(
                                          fontsize: 20,
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
                          ),
                        ],
                      )
                    },
                    if (Account().type == "admin") ...{
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 96,
                            width: 124,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: Colors.blue)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AllText.text(
                                    fontsize: 16,
                                    color: Colors.black,
                                    FontWeight: FontWeight.w400,
                                    text: "Tâche non assigner"),
                                AllText.text(
                                    fontsize: 20,
                                    color: Colors.black,
                                    FontWeight: FontWeight.bold,
                                    text: notAssginedtasks.length.toString()),
                              ],
                            ),
                          ),
                          Container(
                            height: 96,
                            width: 124,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: Colors.blue)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AllText.text(
                                    fontsize: 16,
                                    color: Colors.black,
                                    FontWeight: FontWeight.w400,
                                    text: "tous les tâche"),
                                AllText.text(
                                    fontsize: 20,
                                    color: Colors.black,
                                    FontWeight: FontWeight.bold,
                                    text: alltask.length.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 96,
                            width: 124,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: Colors.blue)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AllText.text(
                                    fontsize: 16,
                                    color: Colors.black,
                                    FontWeight: FontWeight.w400,
                                    text: " Responsable administratif"),
                                FutureBuilder<String>(
                                  future:
                                      _numdoyen(), // Ensuring this method is called here.
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
                                      return AllText.text(
                                          fontsize: 20,
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
                          ),
                          Container(
                            height: 96,
                            width: 124,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: Colors.blue)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AllText.text(
                                    fontsize: 16,
                                    color: Colors.black,
                                    FontWeight: FontWeight.w400,
                                    text: "tous les techniciens"),
                                FutureBuilder<String>(
                                  future:
                                      _numtech(), // Ensuring this method is called here.
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
                                      return AllText.text(
                                          fontsize: 20,
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
                          ),
                        ],
                      )
                    },
                    SizedBox(
                      height: 12,
                    ),
                    if (Account().type == "admin") ...{
                      Expanded(
                          child: DefaultTabController(
                        length: 4,
                        child: Column(
                          children: <Widget>[
                            ButtonsTabBar(
                                borderColor: Colors.blue,
                                backgroundColor: Colors.blue[600],
                                unselectedBackgroundColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                unselectedLabelStyle: TextStyle(
                                  color: Colors.blue[600],
                                  fontWeight: FontWeight.bold,
                                ),
                                borderWidth: 1,
                                unselectedBorderColor: Colors.blue,
                                radius: 8,
                                tabs: [
                                  Tab(
                                  text: '      toutes les tâches      ',
                                ),
                                Tab(
                                  text: '      a faire      ',
                                ),
                                Tab(
                                  text: '      en cours      ',
                                ),
                                Tab(
                                  text: '      tâche fermée      ',
                                ),
                                ]),
                            Expanded(
                                child: StreamBuilder(
                                    stream: tasks.onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        //Account().list_course = [] ;
                                        List<TaskData> alltasks = [];
                                        List<TaskData> aFaire = [];
                                        List<TaskData> enCours = [];
                                        List<TaskData> fermer = [];
                                        DatabaseEvent data =
                                            snapshot.data as DatabaseEvent;
                                        if (data.snapshot.value != null &&
                                            data.snapshot.value is Map) {
                                          (data.snapshot.value
                                                  as Map<dynamic, dynamic>)
                                              .entries
                                              .map((entry) {
                                            TaskData ts = TaskData();
                                            ts.titre = entry.value["title"];
                                            ts.id = int.parse(entry.key);
                                            ts.desc = entry.value["desc"];
                                            ts.priority =
                                                entry.value["priority"];
                                            ts.status = entry.value["status"];
                                            if(entry.value["note"] != null) {
  ts.note = entry.value["note"];
                                            }
                                          

                                            if (Account().type == "tech") {
                                              if (entry.value["assgined"] !=
                                                  null) {
                                                Map assgined =
                                                    entry.value["assgined"];
                                                if (Account().type == "tech") {
                                                  if (assgined.containsValue(
                                                      Account().id)) {
                                                    alltasks.add(ts);
                                                  }
                                                }
                                              }
                                            } else {
                                              alltasks.add(ts);
                                            }

                                            if (ts.status == "a faire") {
                                              if (Account().type == "tech") {
                                                if (entry.value["assgined"] !=
                                                    null) {
                                                  Map assgined =
                                                      entry.value["assgined"];
                                                  if (Account().type ==
                                                      "tech") {
                                                    if (assgined.containsValue(
                                                        Account().id)) {
                                                      aFaire.add(ts);
                                                    }
                                                  }
                                                }
                                              } else {
                                                aFaire.add(ts);
                                              }
                                            } else if (ts.status ==
                                                "en cours") {
                                              if (Account().type == "tech") {
                                                if (entry.value["assgined"] !=
                                                    null) {
                                                  Map assgined =
                                                      entry.value["assgined"];
                                                  if (Account().type ==
                                                      "tech") {
                                                    if (assgined.containsValue(
                                                        Account().id)) {
                                                      enCours.add(ts);
                                                    }
                                                  }
                                                }
                                              } else {
                                                enCours.add(ts);
                                              }
                                            } else if (ts.status ==
                                                "complete") {
                                              if (Account().type == "tech") {
                                                if (entry.value["assgined"] !=
                                                    null) {
                                                  Map assgined =
                                                      entry.value["assgined"];
                                                  if (Account().type ==
                                                      "tech") {
                                                    if (assgined.containsValue(
                                                        Account().id)) {
                                                      fermer.add(ts);
                                                    }
                                                  }
                                                }
                                              } else {
                                                fermer.add(ts);
                                              }
                                            }
                                          }).toList();
                                          // state.league.team[index].nbVote = 5 ;
                                          return TabBarView(
                                            children: [
                                              Container(
                                                // margin: EdgeInsets.symmetric(horizontal: 24),
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Expanded(
                                                      child: ListView.builder(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          itemCount:
                                                              alltasks.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return TacheCard(
                                                              note:  alltasks[
                                                                          index]
                                                                      .note!,
                                                              assgined: alltasks[
                                                                          index]
                                                                      .status !=
                                                                  "notAssgined",
                                                              dateCreation:
                                                                  alltasks[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                              titre: alltasks[
                                                                      index]
                                                                  .titre!,
                                                              priority: alltasks[
                                                                      index]
                                                                  .priority!,
                                                              desc: alltasks[
                                                                      index]
                                                                  .desc!,
                                                              status: alltasks[
                                                                      index]
                                                                  .status!,
                                                              id: alltasks[
                                                                      index]
                                                                  .id!,
                                                            );
                                                          }))
                                                ]),
                                              ),
                                              Container(
                                                // margin: EdgeInsets.symmetric(horizontal: 24),
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Expanded(
                                                      child: ListView.builder(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          itemCount:
                                                              aFaire.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return TacheCard(
                                                              note:aFaire[
                                                                          index]
                                                                      .note!,
                                                              assgined: aFaire[
                                                                          index]
                                                                      .status !=
                                                                  "notAssgined",
                                                              dateCreation:
                                                                  aFaire[index]
                                                                      .id
                                                                      .toString(),
                                                              titre:
                                                                  aFaire[index]
                                                                      .titre!,
                                                              priority: aFaire[
                                                                      index]
                                                                  .priority!,
                                                              desc:
                                                                  aFaire[index]
                                                                      .desc!,
                                                              status:
                                                                  aFaire[index]
                                                                      .status!,
                                                              id: aFaire[index]
                                                                  .id!,
                                                            );
                                                          }))
                                                ]),
                                              ),
                                              Container(
                                                // margin: EdgeInsets.symmetric(horizontal: 24),
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Expanded(
                                                      child: ListView.builder(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          itemCount:
                                                              enCours.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return TacheCard(
                                                                note:enCours[
                                                                          index]
                                                                      .note!,
                                                              assgined: enCours[
                                                                          index]
                                                                      .status !=
                                                                  "notAssgined",
                                                              dateCreation:
                                                                  enCours[index]
                                                                      .id
                                                                      .toString(),
                                                              titre:
                                                                  enCours[index]
                                                                      .titre!,
                                                              priority: enCours[
                                                                      index]
                                                                  .priority!,
                                                              desc:
                                                                  enCours[index]
                                                                      .desc!,
                                                              status:
                                                                  enCours[index]
                                                                      .status!,
                                                              id: enCours[index]
                                                                  .id!,
                                                            );
                                                          }))
                                                ]),
                                              ),
                                              Container(
                                                // margin: EdgeInsets.symmetric(horizontal: 24),
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Expanded(
                                                      child: ListView.builder(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          itemCount:
                                                              fermer.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return TacheCard(
                                                              note:fermer[
                                                                          index]
                                                                      .note!,
                                                              assgined: fermer[
                                                                          index]
                                                                      .status !=
                                                                  "notAssgined",
                                                              dateCreation:
                                                                  fermer[index]
                                                                      .id
                                                                      .toString(),
                                                              titre:
                                                                  fermer[index]
                                                                      .titre!,
                                                              priority: fermer[
                                                                      index]
                                                                  .priority!,
                                                              desc:
                                                                  fermer[index]
                                                                      .desc!,
                                                              status:
                                                                  fermer[index]
                                                                      .status!,
                                                              id: fermer[index]
                                                                  .id!,
                                                            );
                                                          }))
                                                ]),
                                              )
                                            ],
                                          );
                                        }
                                      }
                                      return Container();
                                    })),
                          ],
                        ),
                      )),
                    } else ...{
                      Container(
                        alignment: Alignment.centerLeft,
                        child: AllText.text(
                            fontsize: 20,
                            color: Colors.black,
                            FontWeight: FontWeight.bold,
                            text: Account().type == "doyen"
                                ? "tâche non assignée"
                                : "Tâches d'aujourd'hui"),
                      ),
                      Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: notAssginedtasks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TacheCard(
                                  note:  notAssginedtasks[index].note!,
                                  assgined: notAssginedtasks[index].status !=
                                          "notAssgined"
                                      ? true
                                      : false,
                                  titre: notAssginedtasks[index].titre!,
                                  priority: notAssginedtasks[index].priority!,
                                  dateCreation:
                                      notAssginedtasks[index].id.toString(),
                                  desc: notAssginedtasks[index].desc!,
                                  status: notAssginedtasks[index].status!,
                                  id: notAssginedtasks[index].id!,
                                );
                              }))
                    }
                  ]);
                }
              }
              return Container();
            }),
      ),
    );
  }
}
