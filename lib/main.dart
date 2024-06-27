import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfe/DataClass/Account.dart';
import 'package:pfe/View/googleNav/googleNav.dart';
import 'package:pfe/View/login/Login.dart';
import 'package:pfe/firebase_options.dart';
import 'package:pfe/hive/LocalStorage.dart';
// import 'package:pfe/widgets/forms/inputFild.dart';
// import 'package:pfe/widgets/text/text.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorage.GetUser();
  runApp(Account().id == null
      ? const MainApp()
      : MaterialApp(debugShowCheckedModeBanner: false, home: GoogleNavBar()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}
