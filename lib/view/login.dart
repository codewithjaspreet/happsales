import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../viewmodels/login_view_model.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
// put login controller
  LoginController loginController = Get.put(LoginController());

  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";

  bool invisible = true;

  String password = "";

  bool _obscureText = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _orgController = TextEditingController();



  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form = GlobalKey<FormState>();
    return Scaffold(

      appBar: AppBar(
        title: Text("HappSales" , style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
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

              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(

                      children: [
                        Image.asset("assets/Icons/Android/5_Login/drawable-hdpi/img_login.png"),
                        SizedBox(height: 10.h,),
                        const Text("Login" , style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),

                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.h,),


              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      textAlign: TextAlign.left,
                      controller : loginController.emailController,

                      decoration: InputDecoration(
                        labelText: "email",

                        contentPadding: EdgeInsets.all(16.sp),


                        floatingLabelStyle: TextStyle(color: Colors.black),
                        hintText: "email *",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(

                          borderSide: BorderSide(color: Color(0xff00A6D6)),
                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),

                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },

                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(

                      obscureText: true,
                      controller : loginController.passwordController,
                      decoration: InputDecoration(

                        hintText: "Password *",
                        labelText: "Password",
                        suffixIcon:GestureDetector(
                           child: Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.sp),
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
                     /**/
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller : loginController.orgController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Organization Code *",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.sp),
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

                    ),
/**/
                    // forgot password line

                    GestureDetector(
                      onTap: () {
                        Get.to(ForgotPassword());
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Row(

                          children: [

                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],

                        ),
                      ),
                    ),
                    SizedBox(height: 30.h,),

                    GestureDetector(
                      onTap:  () {
                        if (form.currentState!.validate()) {
                          form.currentState!.save();
                          // loginController.login(email, password);
                        }
                      },

                      child: GestureDetector(
                        onTap: () {
                          print("Button Tap");
                          loginController.loginWithEmail();
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
                              child: Text('Login' ,style:  TextStyle(fontWeight: FontWeight.bold ,fontSize: 16.sp),),
                            )
                        ),
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

