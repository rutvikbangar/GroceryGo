import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/widgets/constants.dart';

import '../../service/database_service.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String fullname = '';
  int phone = 0;
  String email = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getingAddressandPhone();
  }

  getingAddressandPhone() async {
    DocumentSnapshot docRef = await DatabaseService(
        uid: FirebaseAuth.instance.currentUser!.uid
    ).getAlluserdetails();

    setState(() {
      fullname = docRef["fullname"];
      phone = docRef["phone"];
      email = docRef["email"];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Constants().primarycolor,))
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Name",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            buildContainerProfile(Swidth, fullname),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Mobile Number",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            buildContainerProfile(Swidth, phone.toString()),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Email Address",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            buildContainerProfile(Swidth, email),
          ],
        ),
      ),
    );
  }

  Container buildContainerProfile(double Swidth, String title) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      alignment: Alignment.centerLeft,
      height: 70,
      width: Swidth * 0.90,
      decoration: BoxDecoration(
        color: Constants().cartcolor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
