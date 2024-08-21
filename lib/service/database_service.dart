import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
 final String? uid;
 DatabaseService({this.uid});

 // collection reference
final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
final CollectionReference productCollection = FirebaseFirestore.instance.collection("products");

// update user info
Future updateuserNameandEmail(String fullname, String email) async {
  return await userCollection.doc(uid).set({
  "uid" : uid,
    "fullname" : fullname,
    "email" : email,
    "isaddressed" : false,
  });
}
//update user address
  Future updateUserAddress(String address,int phone) async {
  return await userCollection.doc(uid).update({
    "address" : address,
    "isaddressed" : true,
    "phone" : phone
  });
  }
  // get address status
  Future<bool> getaddressStatus() async {
  DocumentSnapshot snapshot = await userCollection.doc(uid).get();
  bool addressstatus=snapshot['isaddressed'];
  return addressstatus;
  }

//taking only those docs from user collection whose email match entered email
Future getuserdataforLogin (String email) async {
QuerySnapshot snapshot = await userCollection.where("email" , isEqualTo: email).get();
return snapshot;
}



Future createProduct(String title,String description,String category,String quantity,String image, int price) async{

    await productCollection.add({
      "title" : title,
      "description"  : description,
      "category" : category,
      "quantity" : quantity,
      "price" : price,
      "image" : image,

    });

}
Future<Stream<QuerySnapshot>> getCategoryProduct(String category) async{
return productCollection.where("category", isEqualTo: category).snapshots();
}
  Future<Stream<QuerySnapshot>> getAllProduct() async{
    return  productCollection.snapshots();
  }

Future<DocumentSnapshot> getAlluserdetails() async{
  DocumentSnapshot Docref = await userCollection.doc(uid).get();
  return Docref;

}
Future takeorder(List<int> price,List<int> no_of_item,List<String> title,int total,String date,String time) async {
  DocumentReference docref = await userCollection.doc(uid).collection("myorder").add({
    "title" : title,
    "no_of_item" : no_of_item,
    "price" : price,
    "total" : total,
    "date" : date,
    "time" : time,
    "status" : "ordered",


  });
  await docref.update({
    "orderid" : docref.id,
  });

}

Future <Stream<QuerySnapshot>> getorderedProduct() async {

   return userCollection.doc(uid).collection("myorder").snapshots();

}
}