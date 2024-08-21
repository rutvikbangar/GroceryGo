import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/helper/helperfunction.dart';
import 'package:grocerygo/pages/cart/cartmain.dart';
import 'package:grocerygo/pages/category/categorymain.dart';
import 'package:grocerygo/pages/profile/profilemain.dart';
import 'package:grocerygo/pages/store/storepage.dart';
import 'package:grocerygo/provider/cart_provider.dart';
import 'package:grocerygo/service/authservice.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:provider/provider.dart';


class MasterPage extends StatefulWidget {
  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  Authservice authservice = Authservice();
  String fullname = "";
  String email = "";
  String address = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserNameandEmailfromSF();

  }


  getUserNameandEmailfromSF() async {
    await HelperFunction.getUserNamewStatus().then((value) => {
          setState(() {
            fullname = value!;
          }),
        });
    await HelperFunction.getUserEmailStatus().then((value) => {
          setState(() {
            email = value!;
          })
        });
  }

  int currentindex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,

        title: <Widget>[
          Text("Hii ${fullname} ",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
          Text("Find Products",style: TextStyle(fontWeight: FontWeight.w600),),
          Text("My Cart",style: TextStyle(fontWeight: FontWeight.w600),),
          Text(""),

        ][currentindex],
        centerTitle: currentindex==0?false : true,


      ),
      body:  <Widget>[

        /// Store page
        StoreMainPage(),
        /// Category page
        CategoryMain(),
        /// Cart page
        CartMainPage(),
        /// Profile page
        ProfilePage(fullname : fullname,email : email),

      ][currentindex],

      bottomNavigationBar: NavigationBar(

        onDestinationSelected: (int index){
          setState(() {
            currentindex = index;
          });
        },
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        indicatorColor: Color(0xff53B175),
        selectedIndex: currentindex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.storefront,) ,
            icon: Icon(Icons.storefront_outlined), label: "Store",),

          NavigationDestination(
            // selectedIcon:Icon(Icons.category,)  ,
              icon: Image.asset("assets/images/kk.png"), label: "Category"),
          Consumer<CartModel>(builder: (context,cart,child) {
          return NavigationDestination(
                selectedIcon: Badge(
                  backgroundColor: cart.cartitem.isEmpty? Colors.transparent : Colors.red,
                  label: cart.cartitem.isEmpty? null : Text(cart.cartitem.length.toString()),
                  child: Icon(Icons.shopping_cart),),
                icon: Badge(
                  backgroundColor:cart.cartitem.isEmpty? Colors.transparent : Colors.red,
                  label:  cart.cartitem.isEmpty? null : Text(cart.cartitem.length.toString()),
                  child: Icon(Icons.shopping_cart_outlined),
                ), label: "Cart");

          }),
          NavigationDestination(
              selectedIcon: Icon(CupertinoIcons.person_fill,) ,
              icon: Icon(CupertinoIcons.person,), label: "Profile"),
        ],
      ),


    );
  }
}

//
// ElevatedButton(
// onPressed: () async {
// await authservice.signOut();
// Navigator.of(context).pushAndRemoveUntil(
// MaterialPageRoute(builder: (context) => LoginPage()),
// (route) => false);
// },
// child: Text("signout")),