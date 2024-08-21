import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/pages/cart/bottomsheet.dart';
import 'package:grocerygo/pages/cart/succes.dart';
import 'package:grocerygo/pages/masterpage.dart';
import 'package:grocerygo/provider/cart_provider.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});


  @override
  State<CheckoutPage> createState() => _CheckoutPageState();

}

class _CheckoutPageState extends State<CheckoutPage> {
   String address = "";
   int phone = 0;
 //  String? formattedDate ;
  // String? formattedTime ;
   bool _isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getingAddressandPhone();

  }
  getingAddressandPhone() async {
      DocumentSnapshot Docref = await DatabaseService(
          uid: FirebaseAuth.instance.currentUser!.uid).getAlluserdetails();
      setState(() {
        address = Docref["address"];
        phone = Docref["phone"];
        _isloading = false;
      });


  }


  @override
  Widget build(BuildContext context) {
    final Sheight = MediaQuery.of(context).size.height;
    final Swidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffeff3f9),
        title: Text("Checkout",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body:_isloading? Center(child: CircularProgressIndicator(color: Constants().primarycolor,),) :

      Consumer<CartModel>(builder: (context,cart,child){
        return Container(
          height: Sheight,
          width: Swidth,
          color: Color(0xffeff3f9),
          child:  Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 120,
                   child: SingleChildScrollView(
                     child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Constants().whitetile,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
                              ),
                              child: ListView.builder(
                                  itemCount: cart.cartitem.length,
                                  shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context,index){
                                    var cartproduct = cart.cartitem[index];
                                    return ListTile(

                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                      leading: Image.network(cartproduct.imageurl,height: 100,),
                                      title: Text(cartproduct.title,style: TextStyle(fontSize: 17),),
                                      subtitle: Text("Quantity ${cartproduct.no_of_item.toString()}",style: TextStyle(fontSize: 15)),
                                      trailing: Text("₹${(cartproduct.price*cartproduct.no_of_item).toString()}",style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),),


                                    );

                                  }),
                            ),

                            SizedBox(height: 20,),
                            Container(
                              color: Constants().whitetile,
                              child: ListTile(
                                tileColor: Constants().whitetile,
                                onTap: (){},
                                leading: Icon(Icons.phone),
                                title: Text("Phone number"),

                                subtitle: Text(phone.toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Colors.grey),),

                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Constants().whitetile,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
                              ),
                              child: ListTile(

                                onTap: (){
                                 showModalBottomSheet(
                                     context: context,
                                     isScrollControlled: true,
                                     builder: (context) => PBottomSheet(price: cart.getTotalPrice())
                                 );
                                },
                                leading: Icon(Icons.payment),
                                title: Text("To Pay :  ₹${cart.getTotalPrice()+25}"),
                                trailing: Icon(Icons.arrow_forward_ios),
                                subtitle: Text("Incl. all taxes and charges",style: TextStyle(fontSize: 16,color: Colors.grey),),

                              ),
                            ),
                            Container(
                              color: Constants().whitetile,
                              child: ListTile(
                                tileColor: Constants().whitetile,
                                onTap: (){
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) => ABottomSheet(address: address,)
                                  );
                                },
                                leading: Icon(Icons.home_work_outlined),
                                title: Text("Delevery address"),
                                trailing: Icon(Icons.arrow_forward_ios),
                                subtitle: Text(address,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Colors.grey),),

                              ),
                            ),



                          ],

                        ),
                   ),
                    ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "To Pay",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "₹${cart.getTotalPrice()+25}",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 72,
                          width: Swidth * 0.7,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants().primarycolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isloading = true;
                              });
                              List<int> price = [];
                              List<int> no_of_item = [];
                              List<String> title = [];
                              for(int i=0; i<cart.cartitem.length;i++){
                                price.add(cart.cartitem[i].price);
                                no_of_item.add(cart.cartitem[i].no_of_item);
                                title.add(cart.cartitem[i].title);
                              }
                             await takeorderatcheckout(price, no_of_item, title, (cart.getTotalPrice()+25));
                            cart.cartitem.clear();

                            },
                            child: Text(
                              "Place Order",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            )
          
        );
      })

    );
  }


   takeorderatcheckout(List<int> price,List<int> no_of_item,List<String> title,int total,) async{
   try {
     DateTime now = DateTime.now();
     String formattedDate = DateFormat('EEEE, MMM d, y').format(now);
     String formattedTime = DateFormat('h:mm a').format(now);
   await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).
     takeorder(price, no_of_item, title, total, formattedDate, formattedTime).whenComplete(() {
       setState(() {

       });

       nextScreenReplace(context, SuccessScreen());

     });

   }catch(e){
     setState(() {
       _isloading=false;
     });

     showSnackbar(context, Colors.red, e);
   }

   }
}


