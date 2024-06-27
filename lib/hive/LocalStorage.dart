import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pfe/DataClass/Account.dart';

class LocalStorage {
  static Future<void> SaveUser() async {
    await Hive.initFlutter();
    await Hive.openBox("user");
    var account = Hive.box('user');
    await account.put('user', Account().toJson());
  }

  static Future<void> GetUser() async {
    await Hive.initFlutter();
    await Hive.openBox("user");
    var box = Hive.box('user');
    if (box.get('user') != null) {
      print(box.get('user'));
      Map<dynamic, dynamic> user = box.get('user');

      Account().id = user["id"];
      Account().email = user["email"];
      Account().fullName = user["fullName"];
      Account().password = user["password"];
      Account().phone = user["phone"];
      Account().photo = user["photo"];
      Account().type = user["type"];
    }
  }

  static Future<void> DeleteUser() async {
    await Hive.initFlutter();
    var box = await Hive.openBox("user");
    await box.delete('user');
  }
}
