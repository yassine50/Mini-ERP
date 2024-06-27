
import 'package:flutter/material.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/View/Notification/Notification.dart';
import 'package:pfe/widgets/text/text.dart'; // Ensure this import path is correct

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  HomeAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Salut ' +Account().fullName!,
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {
                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NotificationMain()),
  );
                // Handle notifications button action
              },
            ),
            Positioned(
              right: 11,
              top: 11,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),

        SizedBox(width: 16), // for spacing
      ],
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            Account().photo!, // Replace with your image URL.
          ),
        ),
      ),
    );
  }
}
