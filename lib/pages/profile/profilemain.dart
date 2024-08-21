
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocerygo/auth/loginpage.dart';
import 'package:grocerygo/pages/profile/myorder.dart';
import 'package:grocerygo/pages/profile/myprofile.dart';
import 'package:grocerygo/pages/profile/viewaddresspage.dart';

import 'package:grocerygo/service/authservice.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';

import '../../service/database_service.dart';


class ProfilePage extends StatelessWidget {
  Authservice authservice = Authservice();

String fullname;
String email;

  ProfilePage({Key? key,required this.fullname,required this.email}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png",),
                radius: 35,),
            ),
            SizedBox(width: 5,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0,left: 8.0),
                  child: Text(fullname,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(email,style: TextStyle(fontSize: 15,color: Colors.grey),),
                ),

              ],
            )
          ],
        ),

       SizedBox(height: 40,),
        ProfileListTile(title: "Profile", leading:Icons.perm_identity, page: MyProfilePage()),
        Padding(padding: EdgeInsets.only(left: 16,right: 16),child: Divider(color: Colors.grey.shade200,),),
         ProfileListTile(title: "My orders", leading: Icons.shopping_bag_outlined, page: MyOrderPage()),
        Padding(padding: EdgeInsets.only(left: 16,right: 16),child: Divider(color: Colors.grey.shade200,),),
        ProfileListTile(title: "Addresses", leading: Icons.location_on_outlined, page: viewAddressPage()),
        SizedBox(height: 30,),
        Center(
          child: GestureDetector(
            onTap: () async {
              await authservice.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
            },
            child: Container(
              alignment: Alignment.center,
              width: 85,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400)
              ),
              child: Text("Log Out",style: TextStyle(color: Constants().primarycolor,fontWeight: FontWeight.w700),),
            ),
          ),
        )

      ],
    );
  }
}

class ProfileListTile extends StatelessWidget {
  String title;
  IconData leading;

  Widget page;

  ProfileListTile({Key? key,required this.title,required this.leading,required this.page }):super(key: key);



  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        nextScreen(context, page);
      },
      leading: Icon(leading),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),

    );
  }
}

// ElevatedButton(
// onPressed: () async {
// await authservice.signOut();
// Navigator.of(context).pushAndRemoveUntil(
// MaterialPageRoute(builder: (context) => LoginPage()),
// (route) => false);
// },
// child: Text("signout")),