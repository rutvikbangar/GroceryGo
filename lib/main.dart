
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocerygo/auth/addaddresspage.dart';
import 'package:grocerygo/auth/loginpage.dart';
import 'package:grocerygo/helper/helperfunction.dart';
import 'package:grocerygo/pages/masterpage.dart';
import 'package:grocerygo/provider/cart_provider.dart';
import 'package:grocerygo/service/database_service.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(create: (context)=> CartModel(),
    child: MyApp(),
    ),
      );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Widget> _homePage;

  @override
  void initState() {
    super.initState();
    _homePage = _determineHomePage();
  }

  Future<Widget> _determineHomePage() async {
    bool isSignedIn = await HelperFunction.getUserLogInStatus() ?? false;
    if (isSignedIn) {
      bool hasAddress = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getaddressStatus();
      if (hasAddress) {
        return MasterPage();
      } else {
        return addAddressPage();
      }
    } else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,

      home: FutureBuilder<Widget>(
        future: _homePage,
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
                    child: Lottie.asset("assets/animations/scootyboy.json",repeat: true,width: 140,height: 140)
                )
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return Scaffold(
              body: Center(child: Text('No data')),
            );
          }
        },
      ),

    );
  }
}
