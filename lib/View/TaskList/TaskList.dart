import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/DataClass/Task.dart';
import 'package:pfe/View/Createtask/Createtask.dart';
import 'package:pfe/widgets/Card/tache.dart';
import 'package:pfe/widgets/appBar/HomeAppBar.dart';
import 'package:pfe/widgets/text/text.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference tasks =
        FirebaseDatabase.instance.reference().child("/Tasks");
    return Scaffold(
      floatingActionButton: Account().type != "tech"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateTask()),
                );
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            )
          : null,
      appBar: HomeAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          Expanded(
              child: Account().type == "user"
                  ? Container(
                      // margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(children: [
                        SizedBox(
                          height: 12,
                        ),
                        Expanded(
                          child: StreamBuilder(
                              stream: tasks.onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  //Account().list_course = [] ;
                                  List<TaskData> tasks = [];
                                  DatabaseEvent data =
                                      snapshot.data as DatabaseEvent;
                                  if (data.snapshot.value != null &&
                                      data.snapshot.value is Map) {
                                    (data.snapshot.value
                                            as Map<dynamic, dynamic>)
                                        .entries
                                        .map((entry) {
                                      if (entry.value["createdBy"] ==
                                          Account().id) {
                                        TaskData ts = TaskData();
                                        ts.titre = entry.value["title"];
                                        ts.id = int.parse(entry.key);
                                        ts.desc = entry.value["desc"];
                                        ts.priority = entry.value["priority"];
                                        ts.status = entry.value["status"];
                                        if (entry.value["note"] != null) {
                                            ts.note= entry.value["note"];
                                        }
                                      
                                        tasks.add(ts);
                                      }
                                    }).toList();
                                    // state.league.team[index].nbVote = 5 ;
                                    return ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: tasks.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return TacheCard(
                                            note: tasks[index].note!,
                                            assgined: tasks[index].status !=
                                                    "notAssgined"
                                                ? true
                                                : false,
                                            titre: tasks[index].titre!,
                                            priority: tasks[index].priority!,
                                            dateCreation:
                                                tasks[index].id.toString(),
                                            desc: tasks[index].desc!,
                                            status: tasks[index].status!,
                                            id: tasks[index].id!,
                                          );
                                        });
                                  }
                                }
                                return Container();
                              }),
                        )
                      ]),
                    )
                  : DefaultTabController(
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
                                          ts.priority = entry.value["priority"];
                                          ts.status = entry.value["status"];
                                            if (entry.value["note"] != null) {
                                            ts.note= entry.value["note"];
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
                                              if (Account().type == "tech") {
                                                if (assgined.containsValue(
                                                    Account().id)) {
                                                    aFaire.add(ts);
                                                }
                                              }
                                            }
                                          } else {
                                            aFaire.add(ts);
                                          }
                                          
                                          } else if (ts.status == "en cours") {
                                             if (Account().type == "tech") {
                                            if (entry.value["assgined"] !=
                                                null) {
                                              Map assgined =
                                                  entry.value["assgined"];
                                              if (Account().type == "tech") {
                                                if (assgined.containsValue(
                                                    Account().id)) {
                                                      enCours.add(ts);
                                                }
                                              }
                                            }
                                          } else {
                                            enCours.add(ts);
                                          }
                                          
                                          } else if (ts.status == "complete") {
                                             if (Account().type == "tech") {
                                            if (entry.value["assgined"] !=
                                                null) {
                                              Map assgined =
                                                  entry.value["assgined"];
                                              if (Account().type == "tech") {
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
                                                            note:alltasks[
                                                                        index]
                                                                    .note! ,
                                                            assgined: alltasks[
                                                                        index]
                                                                    .status !=
                                                                "notAssgined",
                                                            dateCreation:
                                                                alltasks[index]
                                                                    .id
                                                                    .toString(),
                                                            titre:
                                                                alltasks[index]
                                                                    .titre!,
                                                            priority:
                                                                alltasks[index]
                                                                    .priority!,
                                                            desc:
                                                                alltasks[index]
                                                                    .desc!,
                                                            status:
                                                                alltasks[index]
                                                                    .status!,
                                                            id: alltasks[index]
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
                                                            note: alltasks[
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
                                                            titre: aFaire[index]
                                                                .titre!,
                                                            priority:
                                                                aFaire[index]
                                                                    .priority!,
                                                            desc: aFaire[index]
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
                                                              note: alltasks[
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
                                                            priority:
                                                                enCours[index]
                                                                    .priority!,
                                                            desc: enCours[index]
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
                                                              note: alltasks[
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
                                                            titre: fermer[index]
                                                                .titre!,
                                                            priority:
                                                                fermer[index]
                                                                    .priority!,
                                                            desc: fermer[index]
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
                    )
                    ),
        ]),
      ),
    );
  }
}
