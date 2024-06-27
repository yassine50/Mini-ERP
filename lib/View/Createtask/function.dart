// import 'dart:ffi';

// import 'package:image_picker/image_picker.dart';
// import 'package:pfe/Accessibilities/Tools.dart';
// import 'package:pfe/DataClass/Account.dart';
// import 'package:pfe/backendClass/fb_rdb.dart';
// import 'package:pfe/backendClass/fb_storage.dart';

// class FunctionsTask {
//     FB_RBD fb = FB_RBD();
//   FB_Storage storage = FB_Storage();
//    final ImagePicker _picker = ImagePicker();
//     void pickUploadProfilePic() async {
//     final image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (image == null) {
//       // Get.back();
//     } else {
//       print(image?.path);
//       bool verif = await storage.Upload_File(
//           image!.path, Account().id! + "/profilepic.jpg");
//       if (verif) {
//         fb.Update_Data('/Accounts/' + Tools.Cast_email(Account().id!),
//             {'profile_pic': true});
//         fb.Update_Data("/Accounts/${Account().id!}/Achievement/23/", {
//           "status": true ,
//         });

//         Account().photo = await storage.Get_file(Account().id! + "/profilepic.jpg");
       
    
//                 }
//        else {
//       //  
//         // Popups_Manger().warningPopup(
//         //     context, AppLocalizations.of(context)!.image_not_upload);
//       }
//     }
//   }




//       Future<void> pick() async {
//     // final image = await ImagePicker().pickImage(
//     //   source: ImageSource.gallery,
//     // );
//     // return image!.path ; 
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//   }
// }