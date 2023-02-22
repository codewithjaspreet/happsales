import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../viewmodels/login_view_model.dart';

class ForgotPassword extends StatefulWidget {


  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _LoginState();
}

class _LoginState extends State<ForgotPassword> {
  String email = "";

  LoginController loginController = Get.put(LoginController());


  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _orgController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();


  String password = "";



  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("HappSales" , style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Column(
                children: [
                  Image.asset("assets/logo.png"),
                  const Text("Forgot Password" , style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),

                ],
              ),
              SizedBox(height: 50.h,),


              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      controller : loginController.nameController,
                      decoration: InputDecoration(
                        hintText: "UserName *",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),

                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller : loginController.orgController,

                      decoration: InputDecoration(

                        hintText: "Organisation Code *",

                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),

                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: loginController.emailController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Email *",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),

                    // forgot password line

                    SizedBox(
                      height: 20.h,
                    ),

                    GestureDetector(
                      onTap:  () {

                        loginController.forgotPassword;


                        // if (form.currentState!.validate()) {
                        //   form.currentState!.save();
                        //   // loginController.login(email, password);
                        // }
                      },

                      child: Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              print("Button Tap2");
                              // loginController.loginWithEmail();
                            },
                            style: ElevatedButton.styleFrom(shape: StadiumBorder(),backgroundColor: Color(0xff171A63),primary: Colors.white),
                            child: Text('Confirm' ,style:  TextStyle(fontSize: 16.sp , fontWeight: FontWeight.bold),),
                          )
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}

