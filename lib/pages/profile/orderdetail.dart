

import 'package:flutter/material.dart';
import 'package:grocerygo/pages/cart/bottomsheet.dart';
import 'package:grocerygo/widgets/constants.dart';

class OrderDetail extends StatelessWidget {
 List<int> price;
 List<int> no_of_items;
 List<String> title;
 String status;
 int total;
 String orderid;
 String date;
 String time;

OrderDetail({Key? key,required this.title,required this.no_of_items,required this.price,
 required this.status,required this.total,required this.orderid,required this.time,required this.date }):super(key: key);

  @override
  Widget build(BuildContext context) {
    final Sheight = MediaQuery.of(context).size.height;
    final Swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().cartcolor,
      ),
      body: Container(
        height: Sheight,
        width: Swidth,
        color: Color(0xffeff3f9),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(

                decoration: BoxDecoration(
                    color: Constants().whitetile,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: price.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Text(title[index],style: TextStyle(fontSize: 17)),
                        subtitle: Text("Quantity ${no_of_items[index]}",style: TextStyle(fontSize: 15)),
                        trailing: Text("₹${price[index]}",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),

                      );

                    }),),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    color: Constants().whitetile,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                ),

                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0,left: 8),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Bill Summary",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                      ListTile(
                        leading: Text("Item Total & GST",style: buildSmallStyle()),
                        trailing:Text("₹${total.toString()}",style: buildSmallStyle()) ,
                      ),
                      ListTile(
                        leading: Text("Handling charge",style: buildSmallStyle()),
                        trailing:Text('₹5',style: buildSmallStyle()) ,
                      ),
                      ListTile(
                        leading: Text("Delivery charge",style: buildSmallStyle()),
                        trailing:Text('₹20',style: buildSmallStyle()) ,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                        child: Divider(),
                      ),
                      ListTile(
                        leading:  Text("Total",style: TextStyle
                          (fontSize: 17,fontWeight: FontWeight.w500),),
                        trailing: Text("₹${total+20+5}",style:  TextStyle
                          (fontSize: 17,fontWeight: FontWeight.w500)),
                      ),
                    ],

                  ),
                ),

              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    color: Constants().whitetile,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                ),

                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0,left: 8),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Order Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                      ListTile(
                        title: Text("Order ID ",style: TextStyle(fontSize: 15,color: Colors.grey)),
                        subtitle:Text("#${orderid}",style: buildSmallStyle()) ,
                      ),
                      ListTile(
                        title: Text("Order Placed",style:TextStyle(fontSize: 15,color: Colors.grey)),
                        subtitle:Text("${date} at ${time}",style: buildSmallStyle()) ,
                      ),



                    ],

                  ),
                ),

              ),


            ],
          ),
        ),
      ),
    );
  }
 TextStyle buildSmallStyle() => TextStyle(fontSize: 15,fontWeight: FontWeight.w500);
}
