import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/DataClass/tech.dart';
import 'package:pfe/View/Employers/employers.dart';
import 'package:pfe/View/Home/home.dart';
import 'package:pfe/View/Profile/Profile.dart';
import 'package:pfe/View/TaskList/TaskList.dart';


class GoogleNavBar extends StatefulWidget {
  const GoogleNavBar({super.key});

  @override
  State<GoogleNavBar> createState() => GoogleNavBarState();
}

class GoogleNavBarState extends State<GoogleNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
       List<Widget> _widgetOptions = 

  Account().type=="user" ?  <Widget>[
    TaskList(),
    Profile(me: true, tech: Tech(),)
  ] :  Account().type=="admin"  ?
   <Widget>[
    Home(),
    TaskList(),
    Employers(),
    Profile(me: true,tech: Tech())
  ]
   :
  <Widget>[
    Home(),
    TaskList(),
    Profile(me: true,tech: Tech())
  ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(context).primaryColor,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              // tabBackgroundColor: Colors.grey[100]!,
              tabActiveBorder: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              color: Colors.black,
              tabs: [
                if(Account().type != "user" ) ...{
 GButton(
                  textColor: Theme.of(context).primaryColor,
                  iconActiveColor: Theme.of(context).primaryColor,
                  icon: _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  text: 'Accueil',
                ),
                },
               
                GButton(
                  textColor: Theme.of(context).primaryColor,
                  iconActiveColor: Theme.of(context).primaryColor,
                  icon: _selectedIndex == 1
                      ? Icons.content_paste
                      : Icons.content_paste,
                  text: 'Tache',
                ),
                if(Account().type == "admin") ...{
                   GButton(
                  textColor: Theme.of(context).primaryColor,
                  iconActiveColor: Theme.of(context).primaryColor,
                  // iconColor: _selectedIndex == 2 ? Theme.of(context).shadowColor:Theme.of(context).shadowColor ,
                  icon: _selectedIndex == 2
                      ? Icons.people
                      : Icons.people_outline,
                  text: 'EMP',
                ),
                },
                GButton(
                  textColor: Theme.of(context).primaryColor,
                  iconActiveColor: Theme.of(context).primaryColor,
                  // iconColor: _selectedIndex == 2 ? Theme.of(context).shadowColor:Theme.of(context).shadowColor ,
                  icon: _selectedIndex == 2
                      ? Icons.person
                      : Icons.person_outlined,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
