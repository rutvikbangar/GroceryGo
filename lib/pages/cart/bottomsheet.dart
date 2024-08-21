import 'package:flutter/material.dart';
import 'package:grocerygo/widgets/constants.dart';

class PBottomSheet extends StatelessWidget {
  int price ;
    PBottomSheet({Key? key,required this.price}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Container(
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
                child: Text("Bill Summary",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              ),
              ListTile(
                leading: Text("Item Total & GST",style: buildSmallStyle()),
                trailing:Text("₹${price.toString()}",style: buildSmallStyle()) ,
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
                trailing: Text("₹${price+20+5}",style:  TextStyle
                  (fontSize: 17,fontWeight: FontWeight.w500)),
              ),
            ],

          ),
        ),

      ),

    );
  }

  TextStyle buildSmallStyle() => TextStyle(fontSize: 15,fontWeight: FontWeight.w500);
}


class ABottomSheet extends StatelessWidget {
  String address ;
  ABottomSheet({Key? key,required this.address}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.3,
      child: Container(
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
                child: Text("Delivery Address ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(address,style:buildSmallStyle() ,),
              )


            ],

          ),
        ),

      ),

    );
  }

  TextStyle buildSmallStyle() => TextStyle(fontSize: 15,);
}