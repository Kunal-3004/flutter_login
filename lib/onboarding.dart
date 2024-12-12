import 'package:flutter/material.dart';
import 'package:flutter_login/signin.dart';
import 'package:flutter_login/signup.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 120),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffb51837),
            Color(0xff661c3a),
            Color(0xff301939)
          ],begin: Alignment.topLeft,end: Alignment.topRight)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/health-service_17306625.png",
              color: Colors.white,
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Medical Services",style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(
              height: 100,
            ),
            Text("Welcome Back",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.only(top: 12,bottom: 12),
              margin: EdgeInsets.only(left: 40,right: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    print("SIGN IN button pressed");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                  },
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.only(top: 12,bottom: 12),
              margin: EdgeInsets.only(left: 40,right: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                  },
                  child: Text("SIGN UP",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
