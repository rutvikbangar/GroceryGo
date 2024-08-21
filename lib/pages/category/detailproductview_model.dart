import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/provider/cart_provider.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';
import 'package:provider/provider.dart';

class DetailProductviewModel extends StatefulWidget {
  final String title;
  final String description;
  final String quantity;
  final String image;
  final int price;

  const DetailProductviewModel({
    Key? key,
    required this.title,
    required this.description,
    required this.quantity,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  State<DetailProductviewModel> createState() => _DetailProductviewModelState();
}

class _DetailProductviewModelState extends State<DetailProductviewModel> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Sheight = size.height;
    final Swidth = size.width;

    return Scaffold(
      body: Consumer<CartModel>(builder: (context, cart, child) {
        var currentItem = cart.getCurrentItem(widget.title, widget.image, widget.price);
        return SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      child: Image.network(
                        widget.image,
                        height: Sheight * 0.4,
                        width: Swidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        widget.quantity,
                        style: TextStyle(
                          color: Color(0XFF7C7C7C),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(width: 10),


                        Row(
                          children: [
                            IconButton(
                          onPressed: () {
                            cart.removeItem(currentItem);
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Constants().primarycolor,
                          ),
                        ),
                          SizedBox(width: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffE2E2E2)),
                              color: Color(0xffE2E2E2).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: cart.cartitem.contains(currentItem) ? Text(
                              currentItem.no_of_item.toString(),
                              style: TextStyle(fontSize: 18),
                            ) :Text(
                              "0",
                              style: TextStyle(fontSize: 18),
                            ) ,
                          ),
                          SizedBox(width: 5),

                          IconButton(
                            onPressed: () {
                              cart.addItem(
                                title: widget.title,
                                imageurl: widget.image,
                                price: widget.price,
                              );
                            },
                            icon: Icon(
                              Icons.add,
                              color: Constants().primarycolor,
                            ),
                          ),],) ,

                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            "₹${widget.price.toString()}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        widget.description,
                        style: TextStyle(fontSize: 14, color: Color(0xff7C7C7C)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: Sheight * 0.08,
                        width: Swidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants().primarycolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                          ),
                          onPressed: () {
                            cart.cartitem.contains(currentItem)? showSnackbar(context, Constants().primarycolor, "Item already added") :
                            cart.addItem(title: widget.title, imageurl: widget.image, price: widget.price);
                          },
                          child:cart.cartitem.contains(currentItem)? Text(
                            "Added To Basket",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ) : Text(
                            "Add To Basket",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
