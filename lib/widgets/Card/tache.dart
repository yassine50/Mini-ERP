import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe/Accessibilities/Tools.dart';
import 'package:pfe/View/Task/Task.dart';

import 'package:pfe/widgets/text/text.dart';

class TacheCard extends StatelessWidget {
  final bool assgined  ; 
  final String titre ; 
  final String desc ; 
  final String priority ; 
  final String status ;  
    final String dateCreation ; 
    final String? note;
    final int id ; 

  const TacheCard({super.key, required this.assgined, required this.titre, required this.priority, required this.dateCreation, required this.desc, required this.status, required this.id, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Task(note: note!, assgined:assgined, titre: titre, desc: desc, priority: priority, status:status , dateCreation: Tools.convert_date(int.parse(dateCreation)).year.toString() +"/"+Tools.convert_date(int.parse(dateCreation)).month.toString() +"/"+Tools.convert_date(int.parse(dateCreation)).day.toString(), id: id,)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
          width: 2,
          color: Color(0xFF3053EC),
        )),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AllText.text(
                  fontsize: 14,
                  color: Colors.black,
                  FontWeight: FontWeight.bold,
                  text: titre),
              Icon(Icons.more_vert)
            ],
          ),
             SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 24,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: AllText.text(
                        fontsize: 14,
                        color: Colors.white,
                        FontWeight: FontWeight.bold,
                        text: priority),
                  ),
                
                  if(assgined ==true) ...{
 Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 24,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: AllText.text(
                        fontsize: 14,
                        color: Colors.white,
                        FontWeight: FontWeight.bold,
                        text: status == "notAssgined" ? " Tâche non assignée": status == "complete" ? "complété"  :status),
                  ),
                  },
                 
                ],
              ),
              
             
            ],
          ),
            SizedBox(height: 8,),
          Row(
            children: [
              Icon(Icons.calendar_month_outlined),
              SizedBox(
                width: 8,
              ),
              AllText.text(
                  fontsize: 14,
                  color: Colors.black,
                  FontWeight: FontWeight.bold,
                  text: Tools.convert_date(int.parse(dateCreation)).year.toString() +"/"+Tools.convert_date(int.parse(dateCreation)).month.toString() +"/"+Tools.convert_date(int.parse(dateCreation)).day.toString() ,),
            ],
          )
        ]),
      ),
    );
  }
}
