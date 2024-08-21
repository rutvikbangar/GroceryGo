import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/pages/masterpage.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';

class addAddressPage extends StatefulWidget {

  @override
  State<addAddressPage> createState() => _addAddressPageState();
}

class _addAddressPageState extends State<addAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _landmarkFocusNode = FocusNode();
  final FocusNode _areaFocusNode = FocusNode();
  final FocusNode _numberFocusNode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    _streetController.dispose();
    _landmarkController.dispose();
    _areaController.dispose();
    _streetFocusNode.dispose();
    _landmarkFocusNode.dispose();
    _areaFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      //appBar: AppBar(),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
        gradient: const LinearGradient(
        colors: [Color(0XffFCFCFC), Color(0xffFEFEFE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
    ),),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Enter your Address in \nMumbai to continue...",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Image.asset("assets/images/location.png",width: width,height: height*0.20,),
                  SizedBox(height: 35,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _streetController,
                      focusNode: _streetFocusNode,
                      validator: (val) {
                        if (val != null) {
                          return null;
                        } else {
                          return "required parameter";
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Flat/ House no/ Floor/ Building",
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _landmarkController,
                      focusNode: _landmarkFocusNode,

                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Nearby landmark",
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _areaController,
                      focusNode: _areaFocusNode,
                      validator: (val) {
                        if (val != null) {
                          return null;
                        } else {
                          return "required parameter";
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Area/ Locality/ Sector",
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _numberController,
                      focusNode: _numberFocusNode,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val!.length == 10) {
                          return null;
                        } else {
                          return "Phone number must be 10 digit";
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Phone number ",
                      ),
                    ),
                  ),


                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: height * 0.08,
                      width: width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants().primarycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Perform login action
                            String totaladdress= "${_streetController.text},${_landmarkController.text},${_areaController.text}";
                            SubmitAddress(totaladdress);


                          }
                        },
                        child: Text(
                          "Submit",
                          style:
                          TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
  SubmitAddress(String address) async{

    try {
      int phone= int.parse(_numberController.text);
      await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .updateUserAddress(address,phone);
      nextScreenReplace(context, MasterPage());
    } catch (e){
      showSnackbar(context, Colors.red, e);
      setState(() {

      });

    }

  }

}
