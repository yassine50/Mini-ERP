import 'dart:math';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pfe/DataClass/Account.dart';

import '../Accessibilities/Tools.dart';

class FB_RBD {
  Future<bool> Update_Data(String path, Map<String, Object> value) async {
    bool verif = true;
    DatabaseReference ref = FirebaseDatabase.instance.ref(path);
    try {
      await ref.update(value);
    } on firebase_core.FirebaseException catch (e) {
      FB_RBD fb = FB_RBD() ;
      verif = false;
    }
    return verif;
  }

  Future<String> get_key(String path, String val) async {
    String res = '';
    await FirebaseDatabase.instance.ref(path).get().then((snapshot) {
      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value as Map;
        values.forEach((key, value) {
          if (value == val) {
            res = key;
          }
        });
      } else {}
    });
    return res;
  }

  void Push_Data(String path, Object value) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(path);
    try {
      await ref.push().set(value);
    } on firebase_core.FirebaseException catch (e) {
      FB_RBD fb = FB_RBD() ;
      fb.Update_Data("/logFile/"+Tools.Cast_email(Account().id!)+"/"+Tools.Cast_email(Account().id!)+"/"+Tools().timestampRelative.toString(), {
        "path":path.toString(),
        "log" : e.toString()
      });
      print(e);
    }
  }

Future<Map<dynamic, dynamic>> GetData(String path) async {
  final ref = FirebaseDatabase.instance.ref();
  try {
    final snapshot = await ref.child(path).get();
    if (snapshot.value != null && snapshot.value is Map) {
      // Safe cast to Map<dynamic, dynamic>
      return Map<dynamic, dynamic>.from(snapshot.value as Map);
    } else {
      throw Exception('The data at the specified path is not a Map.');
    }
  } on Error catch (error) {
    final fb = FB_RBD();
    fb.Update_Data("/logFile/${Tools.Cast_email(Account().id!)}", {
      "path": path,
      "log": error.toString()
    });
    print('Caught error: $error');
    throw Exception('An error occurred during the database operation');
  } on FirebaseException catch (e) {
    final fb = FB_RBD();
    fb.Update_Data("/logFile/${Tools.Cast_email(Account().id!)}", {
      "path": path,
      "log": e.toString()
    });
    throw Exception('An error occurred during the database operation');
  }
}

  Future<int> Number_node(String path) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(path);
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;
    int nodeCount = snapshot.value != null ? (snapshot.value as Map).keys.length : 0;
    return nodeCount;
  }

  Object Get_Data_Ref(Query ref) async {
    final snapshot = await ref.get();
    return snapshot.value;
  }

  Future<bool> Set_Data(String path, Object value, String child) async {
    bool verif = true;
    DatabaseReference ref = FirebaseDatabase.instance.ref(path);
    try {
      await ref.child(child).set(value);
    } on firebase_core.FirebaseException catch (e) {
     // print('yesssssssssssssssss');
      FB_RBD fb = FB_RBD() ;
      fb.Update_Data("/logFile/"+ Tools.Cast_email(Account().id!)+"/"+Tools.Cast_email(Account().id!)+"/"+Tools().timestampRelative.toString(), {
        "path":path.toString(),
        "log" : e.toString()
      });
      verif = false;
      //print(e);
    }on Error catch (error) {
      FB_RBD fb = FB_RBD() ;
       fb.Update_Data("/logFile/"+Tools.Cast_email(Account().id!)+"/"+Tools.Cast_email(Account().id!)+"/"+Tools().timestampRelative.toString(), {
        "log" : error.toString()
      });
      print("yessssssss");
      verif = false;
      throw Exception('An error occurred during the database operation');
      print('Caught error: $error');
      // Handle the error here
    }
    return verif;
  }

  Future<bool> Delete_Data(String path) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(path);
    try {
      await ref.remove();
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
    return true;
  }


  Future<void> Run_Transaction(String path, int incValue) async {
    DatabaseReference postRef = FirebaseDatabase.instance.ref(path);
    TransactionResult result = await postRef.runTransaction((Object? post) {
      // Ensure a post at the ref exists.
      if (post == null) {
        return Transaction.abort();
      }
      int newVal = int.parse(post.toString()) + incValue;
      //Do Something with Post
      return Transaction.success(newVal);
    });
  }

  Future<bool> verif_path(String path) async {
    if (path[0] == '/') path = path.replaceRange(0, 1, '');

    List<String> pathChunks = path.split('/');
    if (pathChunks.length > 2) {
      return verif_path_child(
          pathChunks[0], path.replaceRange(0, pathChunks[0].length + 1, ''));
    } else {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child(path).get();
      return !snapshot.exists;
    }
  }

  Future<bool> verif_path_child(String path, String childPath) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(path).get();
    print("here");
    print(snapshot.children) ;
    return !snapshot.hasChild(childPath);
  }
}
