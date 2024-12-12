import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/rest/rest_api.dart';
import 'package:flutter_login/signin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({super.key
  });

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  final FirebaseAuth auth=FirebaseAuth.instance;
  
  Future<void> _signup() async{
    try{
      UserCredential userCredential=await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: 
            Text("Signup Successful!")
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      }
      else {
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
          padding: EdgeInsets.only(top: 30,),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffb51837),
              Color(0xff661c3a),
              Color(0xff301939)
            ],begin: Alignment.topLeft,end: Alignment.topRight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Create Your\nAccount",
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
                  padding: EdgeInsets.only(top: 50,left: 30,right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
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
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Enter Name",
                          prefixIcon: Icon(Icons.person_outline,size: 30,),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
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
                        decoration: const InputDecoration(
                          hintText: "Enter Email",
                          prefixIcon: Icon(Icons.email_outlined,size: 30,),
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
                        decoration: const InputDecoration(
                          hintText: "Enter Password",
                          prefixIcon: Icon(Icons.lock_outlined,size: 30,),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xffb51837),
                            Color(0xff661c3a),
                            Color(0xff301939)
                          ],begin: Alignment.topLeft,end: Alignment.topRight),borderRadius: BorderRadius.circular(30),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                             nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty
                                 ? doRegister(nameController.text,emailController.text,passwordController.text)
                                 : Fluttertoast.showToast(msg: 'All field are required',textColor: Colors.red);
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/13,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                                },
                                child: Text(
                                  "SIGN IN",
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
                      )
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

  doRegister(String name, String email, String password) async {
    var res =await userRegister(name, email, password);

    if(res['success']){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
    }
    else{
      Fluttertoast.showToast(msg: "Required Fields are not valid !",textColor: Colors.red);
    }
  }
}
