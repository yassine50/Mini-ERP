import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  final String imageUrl ; 
  const ProfileAvatar({super.key, required this.imageUrl,});

  @override
  State<ProfileAvatar> createState() => ProfileAvatarState();
}

class ProfileAvatarState extends State<ProfileAvatar> {
 static  XFile? img ; 
   
  @override
  Widget build(BuildContext context) {
    Future<void> pick() async {
     img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
      // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        img =img ; 
      });
  }
    return GestureDetector(
      onTap:  (){
        pick(); 
      },
      child:Container(
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
                  backgroundImage: widget.imageUrl.isNotEmpty
                      ? CachedNetworkImageProvider(widget.imageUrl)
                      : AssetImage( img == null ?   "": img!.path) as ImageProvider,
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
    );
  }
}