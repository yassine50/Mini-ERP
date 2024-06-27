import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe/Accessibilities/Tools.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/widgets/button/blueButton.dart';
import 'package:pfe/widgets/button/profileButton.dart';
import 'package:pfe/widgets/forms/inputFild.dart';
import 'package:pfe/widgets/text/text.dart';

class Info extends StatefulWidget {
  final bool me;
  final Tech tech;
  const Info({super.key, required this.me, required this.tech});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
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

  TextEditingController nom = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController date = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    if (widget.me) {
      nom.text = Account().fullName!;
      phone.text = Account().phone!;
      // date.text = widget.tech.!;
    } else {
      nom.text = widget.tech.fullName!;
      phone.text = widget.tech.phone!;

      // date.text = widget.tech.!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: false,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            AllText.text(
                fontsize: 16,
                color: Colors.black,
                FontWeight: FontWeight.w400,
                text: "Nom et Prénom"),
            SizedBox(
              height: 8,
            ),
            InputFild(
              controller: nom,
              hint: "Entrez votre nom et prénom",
            
            ),
            SizedBox(
              height: 12,
            ),
            AllText.text(
                fontsize: 16,
                color: Colors.black,
                FontWeight: FontWeight.w400,
                text: "Téléphone"),
            SizedBox(
              height: 8,
            ),
            InputFild(
                controller: phone,
                hint: "Entrez votre Téléphone",
                ),
            SizedBox(
              height: 12,
            ),
            AllText.text(
                fontsize: 16,
                color: Colors.black,
                FontWeight: FontWeight.w400,
                text: "Date de naissance"),
            SizedBox(
              height: 8,
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ProfileButton(
                  onTap: () {
                    if (nom.text != "" && phone.text != "") {
                     if (widget.me) {
                        
                        FB_RBD().Update_Data("Accounts/" + Account().id!, {
                          "fullName": nom.text,
                          "phone": phone.text,
                        });
                         setState(() {
                          Account().fullName =  nom.text ;
                      Account().phone = phone.text ;  
                      });
                      } else {
                         FB_RBD().Update_Data("Accounts/" + widget.tech.id!, {
                          "fullName": nom.text,
                          "phone": phone.text,
                        });
                         setState(() {
                          widget.tech.fullName =  nom.text ;
                      widget.tech.phone = phone.text ;  
                      });
                      }
                     
                    
                    } else {
                      
                    }
                  },
                  text: 'Confirmer',
                  width: 130,
                  outlindedbutton: false,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
