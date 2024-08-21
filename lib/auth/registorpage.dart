import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocerygo/auth/addaddresspage.dart';
import 'package:grocerygo/auth/loginpage.dart';
import 'package:grocerygo/auth/registorpage.dart';
import 'package:grocerygo/helper/helperfunction.dart';
import 'package:grocerygo/pages/masterpage.dart';
import 'package:grocerygo/service/authservice.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';
import 'package:lottie/lottie.dart';

class Registorpage extends StatefulWidget {
  @override
  _RegistorpageState createState() => _RegistorpageState();
}

class _RegistorpageState extends State<Registorpage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  Authservice authservice =Authservice();
  bool tap = true;
  bool _isloading = false;
  void passwordtoggle() {
    setState(() {
      tap = !tap;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body:_isloading? Center(
          child: Lottie.asset("assets/animations/scootyboy.json",repeat: true,width: 140,height: 140)
      ) :  SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "GroceryGo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Welcome to our store",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Fullname",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Constants().lightgrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      validator: (val) {
                        if (val == null) {
                          return "Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Enter your name",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Constants().lightgrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please Enter a valid Email";
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Enter your email",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Constants().lightgrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: tap,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be atleast 6 character";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Enter your password",
                        suffixIcon: IconButton(
                            onPressed: passwordtoggle,
                            icon: Icon(
                                tap ? Icons.visibility_off : Icons.visibility)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
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
                            // Perform signup action
                            register();
                            // _emailController.clear();
                            // _nameController.clear();
                            // _passwordController.clear();
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Center(
                    child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Log in",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      nextScreen(context, LoginPage());
                                    })
                            ])),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  register() async{
setState(() {
    _isloading = true;
});
 await authservice.registeruserwithEmailandPassword(_nameController.text, _emailController.text, _passwordController.text).then((value) async {
   if(value==true){
    await HelperFunction.saveUserLogInStatus(value);
    await HelperFunction.saveUserNamewStatus(_nameController.text);
    await HelperFunction.saveUserEmailStatus(_emailController.text);
      nextScreenReplace(context, addAddressPage());
   }else{
     // snackbar
     showSnackbar(context, Colors.red, value);
     setState(() {
    _isloading = false;
     });

   }
 });



  }

}


