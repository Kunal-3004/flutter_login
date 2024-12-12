import 'package:flutter/material.dart';
import 'package:flutter_login/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/onboarding.dart';  // Or your main screen
import 'package:flutter_login/signin.dart';  // Or your main screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences _sharedPreferences;
  @override
  void initState() {
    super.initState();
    isLogin();
  }
  void isLogin() async{
    _sharedPreferences=await SharedPreferences.getInstance();

    if(_sharedPreferences.getString('userid')==null && _sharedPreferences.getString('usermail')==null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>onBoarding()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/health-service_17306625.png", height: 120, width: 120),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Medical Services",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
