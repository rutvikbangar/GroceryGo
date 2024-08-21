import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocerygo/pages/category/allproduct.dart';
import 'package:grocerygo/pages/category/productview_model.dart';
import 'package:grocerygo/widgets/widget.dart';

class CategoryMain extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(9),
         crossAxisCount: 2,
       mainAxisSpacing: 11,
       crossAxisSpacing: 8,
       childAspectRatio: 0.9,
       children: [

         GestureDetector(
           onTap: (){
            nextScreen(context, AllProductView());
           },
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Color(0xffF7A593)),
               color: Color(0xffF7A593).withOpacity(0.2),),
             child: Column(
               children: [
                 SizedBox(height: 5,),
                 Image.asset("assets/images/product.png",height: 130,),
                 SizedBox(height: 10,),
                 Text("All Products",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)
               ],
             ),
           ),
         ),

         GestureDetector(
           onTap: (){
             nextScreen(context, ProductviewModel(category: "diary", header: "Diary & Eggs"));
           },
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Color(0xfffde598)),
               color: Color(0xffFDE598).withOpacity(0.1),),
             child: Column(
               children: [
                 SizedBox(height: 5,),
                 Image.asset("assets/images/diary.png",height: 130,),
                 SizedBox(height: 10,),
                 Text("Dairy & Eggs",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)
               ],
             ),
           ),
         ),

         GestureDetector(
           onTap: (){
             nextScreen(context, ProductviewModel(category: "fruitvegetable", header: "Fruits & Vegetable"));
           },
           child: Container(

             decoration: BoxDecoration(

                 color: Color(0xff53B175).withOpacity(0.1),
               border: Border.all( color: Color(0xff53B175) ),
               borderRadius: BorderRadius.circular(20)
             ),
             child: Column(
               children: [
                 SizedBox(height: 5,),
                 Image.asset("assets/images/fruits.png",height: 130,),
                 SizedBox(height: 10,),
                Text("Fruits  \n& Vegetable",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)
               ],
             ),

           ),
         ),

         GestureDetector(
           onTap: (){
             nextScreen(context, ProductviewModel(category: "breads", header: "Breads"));
           },
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Color(0xffD3B0E0)),
               color: Color(0xffD3B0E0).withOpacity(0.2),),
             child: Column(
               children: [
                 SizedBox(height: 5,),
                 Image.asset("assets/images/breads.png",height: 130,),
                 SizedBox(height: 10,),
                 Text("Breads",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)
               ],
             ),
           ),
         ),

         GestureDetector(
           onTap: (){
             nextScreen(context, ProductviewModel(category: "beverages", header: "Beverages"));
           },
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Color(0xffD3B0E0)),
               color: Color(0xffD3B0E0).withOpacity(0.2),),
             child: Column(
               children: [
                 SizedBox(height: 5,),
                 Image.asset("assets/images/beverages.png",height: 130,),
                 SizedBox(height: 10,),
                 Text("Beverages",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)
               ],
             ),
           ),
         ),

         GestureDetector(
           onTap: (){
             nextScreen(context, ProductviewModel(category: "chips", header: "Munchies & Chips"));
           },
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Color(0xffFDE598)),
               color: Color(0xffFDE598).withOpacity(0.15),),
             child: Column(
               children: [
                 SizedBox(height: 5,),
                 Image.asset("assets/images/chips.png",height: 129,),
                 SizedBox(height: 10,),
                 Text("Munchies \n& Chips",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)
               ],
             ),
           ),
         ),

       ],
     );

  }
}
