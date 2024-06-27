import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfe/Accessibilities/Tools.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/View/login/Login.dart';
import 'package:pfe/backendClass/fb_storage.dart';
import 'package:pfe/hive/LocalStorage.dart';
import 'package:pfe/widgets/avatarPhoto/ProfileAvatar.dart';
import 'package:pfe/widgets/popups/Allpop.dart';
import 'package:pfe/widgets/text/text.dart';

class TopBar extends StatefulWidget {
  final Tech tech;
  final bool me;
  const TopBar({super.key, required this.tech, required this.me});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  static XFile? img;
  Future<void> pick() async {
    img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      Allpups.loading(context);
      await FB_Storage().Upload_File(
          img!.path, "profileimage", Tools.Cast_email(Account().email!));

      Account().photo = await FB_Storage()
          .Get_file("/profile/" + Account().id! + "/profileimage");
      setState(() {
        Account().photo = Account().photo;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 282,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Theme.of(context).primaryColor, Color(0xFF0F297A)],
        ),
      ),
      // color: Theme.of(context).primaryColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 60),
                // margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                    ),
                    AllText.text(
                        text: "Profil",
                        fontsize: 18,
                        FontWeight: FontWeight.w700,
                        color: Colors.white),
                    SizedBox(
                      width: 20,
                    ),
                    if (widget.me) ...{
                      GestureDetector(
                        onTap: () {
                          Account().id = "";
                          Account().email = "";
                          Account().fullName = "";
                          Account().password = "";
                          Account().phone = "";
                          Account().photo = "";
                          Account().type = "";
                          LocalStorage.DeleteUser();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.logout),
                              SizedBox(
                                width: 4,
                              ),
                              AllText.text(
                                  fontsize: 14,
                                  color: Colors.black,
                                  FontWeight: FontWeight.w500,
                                  text: "Déconnecter"),
                            ],
                          ),
                        ),
                      )
                    },
                  ],
                )),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  "assets/image/leftProfile.svg",
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (widget.me) {
                          pick();
                        }
                      },
                      child: Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: CircleAvatar(
                                radius: 47.5 - 2,
                                backgroundColor: Colors.grey.shade800,
                                backgroundImage: widget.me
                                    ? CachedNetworkImageProvider(
                                        Account().photo!)
                                    : CachedNetworkImageProvider(
                                        widget.tech.photo!),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              bottom: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    AllText.text(
                        text: widget.me
                            ? Account().fullName!
                            : widget.tech.fullName!,
                        fontsize: 18,
                        FontWeight: FontWeight.w700,
                        color: Colors.white)
                  ],
                ),
                Container(
                  height: 110,
                  width: 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color(0xFFF5F5F5).withOpacity(0.6)),
                ),
                Column(
                  children: [
                    AllText.text(
                        text: "Type",
                        fontsize: 18,
                        FontWeight: FontWeight.w700,
                        color: Colors.white),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        AllText.text(
                            text: widget.me
                                ? Account().type! == "doyen"
                                    ? "Responsable administratif"
                                    : Account().type! == "tech"
                                        ? "Technicien"
                                        : Account().type!
                                : widget.tech.type!,
                            fontsize: 14,
                            FontWeight: FontWeight.w400,
                            color: Colors.white)
                      ],
                    )
                  ],
                ),
//  SvgPicture.asset(
//   "assets/image/rigthProfile.svg",
// ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            SvgPicture.asset(
              "assets/images/bottomProfile.svg",
            ),
          ],
        ),
      ),
    );
  }
}
