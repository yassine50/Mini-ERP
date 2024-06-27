import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfe/widgets/button/blueButton.dart';
import 'package:pfe/widgets/text/text.dart';

class Gallary extends StatefulWidget {
  const Gallary({super.key});

  @override
  State<Gallary> createState() => GallaryState();
}

class GallaryState extends State<Gallary> {
  static List<XFile> images = [];

  Future<void> pick() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (img != null) {
      setState(() {
        images.add(img);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return images.isEmpty
      ? GestureDetector(
          onTap: pick,
          child: Container(
            height: 169,
            width: 169,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(29)),
              border: Border.all(color: Colors.grey)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                AllText.text(fontsize: 12, color: Colors.black, FontWeight: FontWeight.w400, text: "Ajouter Image")
              ]
            ),
          ),
        )
      : Column(
          children: [
           Wrap(
                  spacing: 5.0, // horizontal spacing between items
                  runSpacing: 5.0, // vertical spacing between lines
                  children: List.generate(images.length, (index) {
                    return Container(
                      width: (MediaQuery.of(context).size.width - 20) / 4, // Adjust the width as necessary
                      height: (MediaQuery.of(context).size.width - 20) / 4, // Adjust the height as necessary
                      child: Image.asset(images[index].path, fit: BoxFit.cover),
                    );
                  }),
                ),
                 SizedBox(height: 12),
            
            BlueBotton(ontap: pick, hint: "Ajouter Image"),
            SizedBox(height: 12)
          ],
        );
  }
}
