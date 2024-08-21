import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocerygo/auth/loginpage.dart';
import 'package:grocerygo/helper/helperfunction.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:grocerygo/widgets/widget.dart';

class Authservice{
 final FirebaseAuth firebaseAuth = FirebaseAuth.instance ;

 // register
Future registeruserwithEmailandPassword (String fullname,String email,String password) async {
 try{
   UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;
    if(user != null){
      await DatabaseService(uid: user.uid).updateuserNameandEmail(fullname, email);
      return true;


    }


 } on FirebaseAuthException catch(e){
   return e.message;
 }

}
Future logInUserwithEmailandPassword(String email,String password) async {
  try{
 UserCredential userCredential =await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
User user = userCredential.user!;
if(user!=null){
  return true;

}

  } on FirebaseAuthException catch(e){
    return e.message;
  }

}


Future signOut() async{
  try {
    await HelperFunction.saveUserLogInStatus(false);
    await HelperFunction.saveUserNamewStatus("");
    await HelperFunction.saveUserEmailStatus("");
    await firebaseAuth.signOut();
  }catch (e){
    return null;
  }
}



}