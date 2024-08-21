import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocerygo/pages/category/detailproductview_model.dart';
import 'package:grocerygo/provider/cart_provider.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class ProductviewModel extends StatefulWidget {

  final String category;
  final String header;


  const ProductviewModel({Key? key, required this.category,required this.header}) : super(key:key);
  @override
  State<ProductviewModel> createState() => _ProductviewModelState();
}

class _ProductviewModelState extends State<ProductviewModel> {

  Stream<QuerySnapshot>? stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  getCategory() async {
    stream =
        await DatabaseService().getCategoryProduct(widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.header,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<CartModel>(builder: (context,cart,child){
        return StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("An error occurred: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No data available"));
              } else {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 0.7
                    ),
                    itemCount:snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      var currentItem = cart.getCurrentItem(ds["title"], ds["image"], ds["price"]);
                      return GestureDetector(
                        onTap: () {
                        // detail
                          nextScreen(context,DetailProductviewModel(title: ds["title"],
                            description: ds["description"],
                            quantity: ds["quantity"],
                            image: ds["image"],
                            price: ds["price"],
                          ) ) ;


                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                            Border.all(color: Colors.grey.withOpacity(0.2)),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  child: Image.network(
                                    ds["image"],
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )),

                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  ds["title"],
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  ds["quantity"],
                                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xff7C7C7C)),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Spacer(), Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("₹${ds["price"].toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                    cart.cartitem.contains(currentItem) ? Row(children: [
                                      IconButton(
                                          onPressed: () {
                                            //remove from cart
                                            cart.removeItem(currentItem);
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color: Constants().primarycolor, size: 20,
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 28,
                                          width: 28,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Color(0xffE2E2E2)),
                                              color: Color(0xffE2E2E2).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8)),
                                          child: Text(
                                            currentItem.no_of_item.toString(),
                                            style: TextStyle(fontSize: 16),
                                          )),

                                      IconButton(
                                          onPressed: () {
                                            //add to cart
                                            cart.addItem(title: ds["title"], imageurl: ds["image"], price: ds["price"]);
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: Constants().primarycolor,size: 20,
                                          )),


                                    ],) : IconButton(icon: Image.asset("assets/images/add.png",height: 40,),onPressed: (){cart.addItem(title: ds["title"], imageurl: ds["image"], price: ds["price"]);},)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
            });

      })



    );
  }
}

