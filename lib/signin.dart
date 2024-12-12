import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/forgotPassword.dart';
import 'package:flutter_login/rest/rest_api.dart';
import 'package:flutter_login/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SharedPreferences sharedPreferences;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successful! Welcome back!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffb51837),
                Color(0xff661c3a),
                Color(0xff301939),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Hello\nSign in!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(
                          color: Color(0xffb51837),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                          color: Color(0xffb51837),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()),
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 4, 72, 129),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffb51837),
                              Color(0xff661c3a),
                              Color(0xff301939),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              emailController.text.isNotEmpty && passwordController.text.isNotEmpty
                                  ? doLogin(emailController.text,passwordController.text)
                                  : Fluttertoast.showToast(msg: 'All field are required',textColor: Colors.red);
                            },
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()),
                                  );
                                },
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 4, 72, 129),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  doLogin(String email , String password) async{
    sharedPreferences=await SharedPreferences.getInstance();
    var res=await userLogin(email.trim(), password.trim());


    if(res['success']){
      String userEmail=res['user'][0]['email'];
      String userId=res['user'][0]['id'].toString();
      sharedPreferences.setString('userid', userId);
      sharedPreferences.setString('usermail', userEmail);

          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    }else{
      Fluttertoast.showToast(msg: "Email and Password not valid?",textColor: Colors.red);
    }
  }
}
