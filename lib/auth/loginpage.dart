import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocerygo/auth/registorpage.dart';
import 'package:grocerygo/helper/helperfunction.dart';
import 'package:grocerygo/pages/masterpage.dart';
import 'package:grocerygo/service/authservice.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:grocerygo/widgets/constants.dart';
import 'package:grocerygo/widgets/widget.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Authservice authservice = Authservice();
  bool _isLoading = false;
  bool _obscureText = true; // for password visibility toggle

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await authservice.logInUserwithEmailandPassword(
        _emailController.text,
        _passwordController.text,
      ).then((value) async {
      if (value==true) {
        // Fetch user data from Firestore
        QuerySnapshot snapshot = await DatabaseService(
        uid: FirebaseAuth.instance.currentUser!.uid,
      ).getuserdataforLogin(_emailController.text);

      // Save user data and navigate to the next screen
      await HelperFunction.saveUserLogInStatus(value);
      await HelperFunction.saveUserEmailStatus(_emailController.text);
      await HelperFunction.saveUserNamewStatus(snapshot.docs[0]["fullname"]);

      nextScreenReplace(context, MasterPage());
    } else {
    showSnackbar(context, Colors.red, value);
    _isLoading = false;
    }
      });


    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: _isLoading
          ? Center(
        child: Lottie.asset("assets/animations/scootyboy.json",repeat: true,width: 140,height: 140)
      )
          : SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.35,
                  width: width,
                  child: Image.asset("assets/images/login.png"),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Get your groceries\n with GroceryGo",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(val!)
                          ? null
                          : "Please Enter a valid Email";
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
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
                    obscureText: _obscureText,
                    validator: (val) {
                      if (val!.length < 6) {
                        return "Password must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: TextStyle(fontSize: 14),
                      hintText: "Enter your password",
                      suffixIcon: IconButton(
                        onPressed: _togglePasswordVisibility,
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
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
                          // Perform login action
                          _login();
                          // _emailController.clear();
                          // _passwordController.clear();
                        }
                      },
                      child: Text(
                        "Login",
                        style:
                        TextStyle(color: Colors.white, fontSize: 15,),
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
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "SignUp",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              nextScreen(context, Registorpage());
                            },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
