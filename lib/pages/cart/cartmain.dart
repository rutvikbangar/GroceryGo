import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/pages/cart/checkout.dart';
import 'package:grocerygo/provider/cart_provider.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';
import 'package:provider/provider.dart';

class CartMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Sheight = size.height;
    final Swidth = size.width;
    return Consumer<CartModel>(builder: (context, cart, child) {
      if (cart.cartitem.isEmpty) {
        return Center(
          child: Text("No product inside the cart"),
        );
      } else {

        return Container(
          width: Swidth,
          height: Sheight,
          child: Stack(
            children: [
              Positioned(
                bottom: 120,
                top: 0,
                right: 0,
                left: 0,
                child: ListView.builder(
                  shrinkWrap: true,

                  itemCount: cart.cartitem.length,
                  itemBuilder: (context, index) {
                    var cartproduct = cart.cartitem[index];
                    return Container(
                      height: 125,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                cartproduct.imageurl,
                                height: 100,
                                width: 90,
                              ),
                              SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Swidth * 0.6,
                                    child: Text(
                                      cartproduct.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          //remove from cart
                                          cart.removeItem(cartproduct);
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Constants().primarycolor,
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 28,
                                        width: 28,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffE2E2E2)),
                                          color: Color(0xffE2E2E2).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          cartproduct.no_of_item.toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          //add to cart
                                          cart.addItem(
                                            title: cartproduct.title,
                                            imageurl: cartproduct.imageurl,
                                            price: cartproduct.price,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Constants().primarycolor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cart.removeItemCompletly(cartproduct);
                                      },
                                      icon: Icon(
                                        CupertinoIcons.delete_solid,
                                        size: 20,
                                        color: Constants().primarycolor,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      "₹${(cartproduct.price * cartproduct.no_of_item).toString()}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Divider(),
                          ),
                        ],
                      ),
                    );
                  },
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
                              "Cart Toal",
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "₹${cart.getTotalPrice()}",
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
                          onPressed: () {
                            nextScreen(context, CheckoutPage());
                          },
                          child: Text(
                            "Go to Checkout",
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
          ),
        );
      }


    });
  }
}




