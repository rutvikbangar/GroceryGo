import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/pages/profile/orderdetail.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';

class MyOrderPage extends StatefulWidget {
  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  Stream? order;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  getOrders() async {
    order = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getorderedProduct();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Sheight = MediaQuery.of(context).size.height;
    final Swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Constants().cartcolor,
      ),
      body: Container(
        height: Sheight,
        width: Swidth,
        color: Color(0xffeff3f9),
        child: StreamBuilder(
          stream: order,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Constants().primarycolor,));
            } else if (snapshot.hasError) {
              return Center(child: Text("An error occurred: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No orders yet"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return ListTile(
                    onTap: () {

                      List<int> price = List<int>.from(ds["price"]);
                      List<int> no_of_items = List<int>.from(ds["no_of_item"]);
                      List<String> title = List<String>.from(ds["title"]);
                      String status = ds["status"];
                      int total = ds["total"];
                      String orderid = ds["orderid"];
                      String date = ds["date"];
                      String time = ds["time"];

                      nextScreen(
                        context,
                        OrderDetail(
                          date :date,
                          time : time,
                          orderid: orderid ,
                          title: title,
                          no_of_items: no_of_items,
                          price: price,
                          status: status,
                          total: total,
                        ),
                      );
                    },
                    title: Text("Order id : #${ds["orderid"]}"),
                    subtitle: Text("${ds["date"]} at ${ds["time"]}"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

}
