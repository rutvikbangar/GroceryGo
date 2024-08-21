


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/pages/profile/profilemain.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:grocerygo/widgets/constants.dart';

class viewAddressPage extends StatefulWidget {


  @override
  State<viewAddressPage> createState() => _viewAddressPageState();
}

class _viewAddressPageState extends State<viewAddressPage> {
  String address = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getingAddress();
  }

  getingAddress() async {
    DocumentSnapshot docRef = await DatabaseService(
        uid: FirebaseAuth.instance.currentUser!.uid
    ).getAlluserdetails();

    setState(() {
      address = docRef["address"];
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Addresses",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body:_isLoading?Center(child: CircularProgressIndicator(color: Constants().primarycolor,)) :
      Column(
        children: [
          SizedBox(height: 20,),
          ListTile(
              title: Text("Home"),
              leading: Icon(Icons.location_on),
            subtitle: Text(address,style: TextStyle(fontSize: 16,color: Colors.grey),),



          )


        ],

      ),
    );
  }
}
