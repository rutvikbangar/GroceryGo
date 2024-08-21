import 'package:flutter/material.dart';

void nextScreen(context, page) {
  Navigator.push(context, PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0); // Animation starts from right
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  ));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
void showSnackbar(context, color, message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar
    (content: Text(message, style: TextStyle(fontSize: 14),),
      backgroundColor: color,duration: Duration(seconds: 3),
      action : SnackBarAction(label: "Ok", onPressed:(){},)));}


class Promoimage extends StatelessWidget {
  final String imageurl;
  const Promoimage({
    Key? key,
    required this.imageurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        imageurl,
        fit: BoxFit.cover,height: 100,
      ),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(4.0, 4.0),
            color: Colors.grey,
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}