

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocerygo/pages/masterpage.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MasterPage()),
              (route) => false);



    });
  }
  Widget build(BuildContext context) {
    return Scaffold(

      body:Center(
          child: Lottie.asset("assets/animations/successful.json")
      )
    );
  }
}
