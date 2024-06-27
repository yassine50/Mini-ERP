import 'package:firebase_auth/firebase_auth.dart';
import 'package:pfe/backendClass/fb_rdb.dart';

class FirebaseAuths {
   static  Future<bool> signUp(String email, String password) async {
    bool verif = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // error = 'weak-password';
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // error = 'email-already-in-use';
        // print('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        // error = 'invalid-email';
        print('invalid-email');
      }
      verif = false;
    } on Error catch (error) {
      throw Exception('An error occurred during the database operation');
      verif = false;
    }
    return verif;
  }
   static Future Change_password(String password) async {
    bool verif = true;
    User? user = await FirebaseAuth.instance.currentUser;
    user?.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      verif = false;
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
    return verif;
  }

  static  Future<int> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
   //   userCredential.user!.sendEmailVerification();

      // if (userCredential.user!.emailVerified) {
      //   return 1;
      // } else {
      //   userCredential.user!.sendEmailVerification();
      //   return -10;
      // }
      return 1 ; 
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        return -11;
      } else if (e.code == 'wrong-password') {
        return -12;
      }
    }on Error catch (error) {
      print(error);
      throw Exception('An error occurred during the database operation');
    }
    return -1;
  }

   static Future ResetPassword(String email) async {
    bool verif = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // error = 'user-not-found';
      }
      // print(e.code);
      verif = false;
    }on Error catch (error) {
 
      print(error);
      throw Exception('An error occurred during the database operation');
      verif = false;
    }
    return verif;
  }
}