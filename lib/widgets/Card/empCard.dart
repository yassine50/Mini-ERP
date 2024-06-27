import 'package:flutter/material.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/View/CreateAccount/CreateAccount.dart';
import 'package:pfe/View/Profile/Profile.dart';
import 'package:pfe/backendClass/fb_rdb.dart';
import 'package:pfe/backendClass/fb_storage.dart';
import 'package:pfe/widgets/button/blueButton.dart';
import 'package:pfe/widgets/button/profileButton.dart';
import 'package:pfe/widgets/cashedImage/cashedImage.dart';
import 'package:pfe/widgets/popups/Allpop.dart';
import 'package:pfe/widgets/text/text.dart';

class EmpCard extends StatefulWidget {
  final Tech tec;
  const EmpCard({super.key, required this.tec});

  @override
  State<EmpCard> createState() => _EmpCardState();
}

class _EmpCardState extends State<EmpCard> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Profile(
                tech:widget.tec ,
                    me: false,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // SizedBox(width: 8),
            Container(
              width: 65,
              child:  FutureBuilder<String>(
                    future: _fetchImage(
                        widget.tec.id!), // Ensuring this method is called here.
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child:
                                CircularProgressIndicator()); // Changed to show a loading spinner.
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        widget.tec.photo = snapshot.data! ; 
                        return CachedImage(
                              img: snapshot
                                  .data!, // Directly use the URL from the snapshot.
                              box: BoxFit.cover,
                              height: 120,
                              width: 65,
                            );
                      } else {
                        return Text("No image found.");
                      }
                    },
                  ),
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              width: 2,
              height: 100,
              color: Colors.grey,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                       Text(
                    widget.tec.fullName!,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                    ],
                  ),
                   Text(
                        "Email: " + widget.tec.email!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                       Text(
                        "Phone: " + widget.tec.phone!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                       Text(
                         widget.tec.type=="doyen" ?"type: responsable administratif ":
                        "type: " + widget.tec.type!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                  
              
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                     Allpups.confirm (context, "Êtes-vous sûr de vouloir supprimer ce compte ? Cette action est irréversible.",widget.tec );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: AllText.text(
                        fontsize: 14,
                        color: Colors.white,
                        FontWeight: FontWeight.w400,
                        text: "Supprimer"),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccount(tech: widget.tec,update: true,)),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: AllText.text(
                        fontsize: 14,
                        color: Colors.white,
                        FontWeight: FontWeight.w400,
                        text: "Modifer"),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
