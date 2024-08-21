import 'package:flutter/cupertino.dart';


class CartItem {
  final String title;
  final String imageurl;
   int no_of_item;
  final int price;

  CartItem({required this.title,this.no_of_item = 1,required this.price,required this.imageurl});


}

class CartModel extends ChangeNotifier{
  List<CartItem> _cartitem = [];

  List<CartItem> get cartitem => _cartitem;

 getCurrentItem (String title,String imageurl,int price){
   var currentItem = _cartitem.firstWhere(
         (item) => item.title == title,
     orElse: () => CartItem(
         title: title,
         price: price,
         imageurl: imageurl,
       no_of_item: 0,
     ),

   );
   return currentItem;

}


  void addItem ({
    required title,
    required imageurl,
    required price,
}){
    var currentItem = _cartitem.firstWhere(
        (item) => item.title == title,
      orElse: () => CartItem(
        title: title,
        price: price,
        imageurl: imageurl
    ),

    );
    if(_cartitem.contains(currentItem)){
      currentItem.no_of_item++;
    }else{
      _cartitem.add(currentItem);
    }
    notifyListeners();
  }

void removeItem(CartItem cartItem){

   if(cartItem.no_of_item == 1){
     _cartitem.remove(cartItem);
   }else{
     cartItem.no_of_item--;
   }

   notifyListeners();

}
  void removeItemCompletly(CartItem cartItem){

   _cartitem.remove(cartItem);
   notifyListeners();

  }

int getTotalPrice(){
    int total =0;
    for(int i=0 ; i<_cartitem.length ; i++){
      total = total + (_cartitem[i].price)*_cartitem[i].no_of_item;

    }
    return total;
}




}