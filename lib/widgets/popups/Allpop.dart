import 'package:flutter/material.dart';
import 'package:pfe/Accessibilities/Tools.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/widgets/text/text.dart';

class Allpups {
  static  warningPopup(BuildContext context, String warningText) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var realHeight = MediaQuery.of(context).size.height;
        var realWidth = MediaQuery.of(context).size.width;
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor:
             Colors.white,
            child: Container(
              height: realHeight * 0.33,
              width: realHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/warrning.png")),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                         "Avertissement!" ,
                            style: TextStyle(
                              height: 1.3,
                              decoration: TextDecoration.none,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: 
                                  Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10,left: 24,right: 24),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            warningText,
                         
                          ),
                        ),
                      )),
                  SizedBox(
                    height: realHeight * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 38,
                      width: realHeight * 0.3,
                      decoration: BoxDecoration(
                        color: Color(0xFF3053EC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: AllText.text(fontsize: 14, color: Colors.white, FontWeight: FontWeight.w400, text: "Fermer")
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
    static  succsess(BuildContext context, String warningText) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var realHeight = MediaQuery.of(context).size.height;
        var realWidth = MediaQuery.of(context).size.width;
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor:
             Colors.white,
            child: Container(
              height: realHeight * 0.33,
              width: realHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/succes.png")),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                         "Succès!" ,
                            style: TextStyle(
                              height: 1.3,
                              decoration: TextDecoration.none,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: 
                                  Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10,left: 24,right: 24),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            warningText,
                         
                          ),
                        ),
                      )),
                  SizedBox(
                    height: realHeight * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 38,
                      width: realHeight * 0.3,
                      decoration: BoxDecoration(
                        color: Color(0xFF3053EC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: AllText.text(fontsize: 14, color: Colors.white, FontWeight: FontWeight.w400, text: "Fermer")
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }


     static  loading(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var realHeight = MediaQuery.of(context).size.height;
        var realWidth = MediaQuery.of(context).size.width;
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor:
             Colors.white,
             surfaceTintColor :Colors.white , 
            child: Container(
              height: realHeight * 0.33,
              width: realHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 60,
                    width: 150,
                   child: Image.asset("assets/images/logo.png"),
                  ),
                  CircularProgressIndicator(),


                  AllText.text(fontsize: 14, color: Colors.black, FontWeight: FontWeight.bold, text: "Chargement")

                
                ],
              ),
            ));
      },
    );
  }




    static  confirm(BuildContext context, String warningText, Tech tec ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var realHeight = MediaQuery.of(context).size.height;
        var realWidth = MediaQuery.of(context).size.width;
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor:
             Colors.white,
            child: Container(
              height: realHeight * 0.33,
              width: realHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/succes.png")),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                         "Succès!" ,
                            style: TextStyle(
                              height: 1.3,
                              decoration: TextDecoration.none,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: 
                                  Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10,left: 24,right: 24),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            warningText,
                         
                          ),
                        ),
                      )),
                  SizedBox(
                    height: realHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 38,
                      width: realHeight * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: AllText.text(fontsize: 14, color: Colors.black, FontWeight: FontWeight.w400, text: "Non")
                      ),
                    ),
                  ),
                     GestureDetector(
                    onTap: () {

                      FB_RBD().Update_Data("Accounts/"+Tools.Cast_email(tec.email!), {
                                
                
                                    "deleted": true,
                                   
                                 
                                  
                                });
                                Navigator.pop(context);
                   
                    },
                    child: Container(
                      height: 38,
                      width: realHeight * 0.15,
                      decoration: BoxDecoration(
                        color: Color(0xFF3053EC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: AllText.text(fontsize: 14, color: Colors.white, FontWeight: FontWeight.w400, text: "Oui")
                      ),
                    ),
                  )

                  ],)
                 
                ],
              ),
            ));
      },
    );
  }
   static  confirmtsk(BuildContext context, String warningText,String taskid) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var realHeight = MediaQuery.of(context).size.height;
        var realWidth = MediaQuery.of(context).size.width;
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor:
             Colors.white,
            child: Container(
              height: realHeight * 0.33,
              width: realHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/succes.png")),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                         "Succès!" ,
                            style: TextStyle(
                              height: 1.3,
                              decoration: TextDecoration.none,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: 
                                  Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10,left: 24,right: 24),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            warningText,
                         
                          ),
                        ),
                      )),
                  SizedBox(
                    height: realHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 38,
                      width: realHeight * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: AllText.text(fontsize: 14, color: Colors.black, FontWeight: FontWeight.w400, text: "Non")
                      ),
                    ),
                  ),
                     GestureDetector(
                    onTap: () {
                      FB_RBD().Delete_Data("Tasks/"+taskid);

                     
                                Navigator.pop(context); Navigator.pop(context);
                                

                   
                    },
                    child: Container(
                      height: 38,
                      width: realHeight * 0.15,
                      decoration: BoxDecoration(
                        color: Color(0xFF3053EC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: AllText.text(fontsize: 14, color: Colors.white, FontWeight: FontWeight.w400, text: "Oui")
                      ),
                    ),
                  )

                  ],)
                 
                ],
              ),
            ));
      },
    );
  }
}
  
