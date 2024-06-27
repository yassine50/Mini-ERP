import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pfe/DataClass/Task.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/widgets/Card/tache.dart';

class TaskProfile extends StatefulWidget {
  final Tech tech ;
  const TaskProfile({super.key, required this.tech});

  @override
  State<TaskProfile> createState() => _TaskProfileState();
}

class _TaskProfileState extends State<TaskProfile> {
  @override
  Widget build(BuildContext context) {
     final DatabaseReference tasks =
        FirebaseDatabase.instance.reference().child("/Tasks");
    return Expanded(
                              child: StreamBuilder(
                                  stream: tasks.onValue,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      //Account().list_course = [] ;
                                      List<TaskData> alltasks = [];

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
                                       

                                          
                                            if (entry.value["assgined"] !=
                                                null) {
                                              Map assgined =
                                                  entry.value["assgined"];
                                          
                                                if (assgined.containsValue(
                                                  widget.tech. id)) {
                                                  alltasks.add(ts);
                                                }
                                              
                                            }
                                         

                                        
                                         
                                          
                                        }).toList();
                                        // state.league.team[index].nbVote = 5 ;
                                        return  Container(
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
                                            );
                                      }
                                    }
                                    return Container();
                                  }));
  }
}