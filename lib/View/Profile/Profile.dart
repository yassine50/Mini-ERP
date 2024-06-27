import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/View/Profile/widget/TopBar.dart';

import 'package:pfe/View/Profile/widget/info.dart';
import 'package:pfe/View/Profile/widget/pass.dart';
import 'package:pfe/View/Profile/widget/taskProfile.dart';
import 'package:pfe/widgets/text/text.dart';

class Profile extends StatelessWidget {
  final bool me ; 
  final Tech tech ; 
  const Profile({super.key,  this.me = true, required this.tech});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(tech: tech, me: me,),
          //  SizedBox(height: 24,),

          Expanded(
            child: ContainedTabBarView(
              tabBarProperties: TabBarProperties(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
              ),
              tabs:  [
                Text("Information"),
               me ? Text("Mot de passe"):Text("Tâches") ,
              ],
              views: 
              [
                Info(me: me, tech: tech,),
                // Container(color: Colors.green), // Replace with actual team search view
                me ?  Pass():TaskProfile( tech: tech,)
              ],
              onChange: (index) => print('Selected index: $index'),
            ),
          )
        ],
      ),
    );
  }
}
