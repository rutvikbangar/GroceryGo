import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/horizontalproductview.dart';
import 'package:grocerygo/widgets/widget.dart';

class StoreMainPage extends StatefulWidget {
  @override
  State<StoreMainPage> createState() => _StoreMainPageState();
}

class _StoreMainPageState extends State<StoreMainPage> {
  final TextEditingController searchcontroller = TextEditingController();
  Stream<QuerySnapshot>? stream;
  Stream<QuerySnapshot>? stream1;
  int _currentindex = 0;


  @override
  void initState() {
    super.initState();
    getproduct();
    getVegCategory();
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }
  getVegCategory() async{
    stream1 = await DatabaseService().getCategoryProduct("fruitvegetable");
    setState(() {
    });
  }

  getproduct() async {
    stream = await DatabaseService().getAllProduct();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left: 11.0, right: 11.0),
              child: SearchBar(
                leading: Icon(Icons.search),
                controller: searchcontroller,
                hintText: "Search Product",

                padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                backgroundColor: MaterialStatePropertyAll(Constants().lightgrey.withOpacity(0.1)),
                elevation: MaterialStatePropertyAll(0),
                shadowColor: MaterialStatePropertyAll(Constants().lightgrey.withOpacity(0.1)),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                CarouselSlider(
                  items: [
                    Promoimage(imageurl: "assets/images/grocery1.jpg"),
                    Promoimage(imageurl: "assets/images/grocery2.jpg"),
                    Promoimage(imageurl: "assets/images/grocery3.jpg"),
                  ],
                  options: CarouselOptions(
                    viewportFraction: 1.5,
                    autoPlay: true,
                    onPageChanged: (index, _) => updateindex(index),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < 3; i++)
                      buildContainerselect(_currentindex == i ? Constants().primarycolor : Constants().lightgrey.withOpacity(0.2)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Top Products :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 15,),
           HorizontalProductview(Tstream: stream,itemcount: 4,),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Top Vegies :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 15,),
            HorizontalProductview(Tstream: stream1,itemcount: 4,),
            
            


          ],
        ),
    );

  }

  Container buildContainerselect(Color color) {
    return Container(
      margin: EdgeInsets.only(right: 3),
      height: 4,
      width: 22,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  void updateindex(index) {
    setState(() {
      _currentindex = index;
    });
  }



}


