import 'package:flutter/material.dart';
import 'package:pfe/widgets/cashedImage/cashedImage.dart';
import 'package:pfe/widgets/text/text.dart';


class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
         border: Border.all(color: Colors.black.withOpacity(0.05),width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
     
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max, // Make the column take all available space
              mainAxisAlignment: MainAxisAlignment.center, // Center the text vertically
              children: [
                AllText.text(
                  text: "game alert!",
                  fontsize: 14,
                  FontWeight: FontWeight.bold,
                  color: Theme.of(context).shadowColor,
                ),
                SizedBox(height: 8,),
                Flexible( // Makes text wrap and fill the container
                  child: AllText.text(
                    text: "The match between Real Madrid and Barcelona has been started!",
                    fontsize: 12,
                    FontWeight: FontWeight.normal,
                    color: Colors.grey,
                  
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}