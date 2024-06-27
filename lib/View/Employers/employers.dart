import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/View/CreateAccount/CreateAccount.dart';
import 'package:pfe/View/Createtask/Createtask.dart';
import 'package:pfe/widgets/Card/empCard.dart';
import 'package:pfe/widgets/Card/tache.dart';
import 'package:pfe/widgets/appBar/HomeAppBar.dart';

class Employers extends StatefulWidget {
  const Employers({super.key});

  @override
  State<Employers> createState() => _EmployersState();
}

class _EmployersState extends State<Employers> {
  final DatabaseReference account =
      FirebaseDatabase.instance.reference().child("/Accounts");
  final DatabaseReference task =
      FirebaseDatabase.instance.reference().child("/Tasks");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Account().type != "tech"
          ? FloatingActionButton(
              onPressed: () {
                Tech tech = Tech();
                tech.fullName = "";
                tech.email = "";
                tech.phone = "";
                tech.photo = "";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateAccount(
                            tech: tech,
                            update: false,
                          )),
                );
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            )
          : null,
      appBar: HomeAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder(
            stream: account.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //Account().list_course = [] ;
                List<Tech> alltech = [];
                List<Tech> alldoyen = [];
                List<Tech> allusers = [];

                DatabaseEvent data = snapshot.data as DatabaseEvent;
                if (data.snapshot.value != null && data.snapshot.value is Map) {
                  (data.snapshot.value as Map<dynamic, dynamic>)
                      .entries
                      .map((entry) {
                    Tech tec = Tech();
                    tec.id = entry.key;
                    tec.fullName = entry.value["fullName"];
                    tec.phone = entry.value["phone"];
                    tec.afaire = entry.value["afaire"];
                    tec.tacheEnCours = entry.value["tacheEnCours"];
                    tec.type = entry.value["type"];
                    tec.email = entry.value["email"];
                    if (tec.type == "technicien") {
                      alltech.add(tec);
                    } else if (tec.type == "doyen") {
                      alldoyen.add(tec);
                    } else if (tec.type == "utilisateur") {
                      allusers.add(tec);
                    }
                  }).toList();
                  // state.league.team[index].nbVote = 5 ;
                  return Column(children: [
                    Expanded(
                        child: DefaultTabController(
                      length: 3,
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
                                  text: '    Tous les techniciens   ',
                                ),
                                Tab(
                                  text: '      Tout responsable administratif      ',
                                ),
                                Tab(
                                  text: '    Tous les utilisateurs    ',
                                ),
                              ]),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount: alltech.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return EmpCard(
                                                tec: alltech[index],
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
                                            padding: const EdgeInsets.all(8),
                                            itemCount: alldoyen.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return EmpCard(
                                                tec: alldoyen[index],
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
                                            padding: const EdgeInsets.all(8),
                                            itemCount: allusers.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return EmpCard(
                                                tec: allusers[index],
                                              );
                                            }))
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ]);
                }
              }
              return Container();
            }),
      ),
    );
  }
}
