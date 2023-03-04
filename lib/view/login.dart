import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/dashboard/parent.dart';

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




   bool _obscureText = true;


  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _orgController = TextEditingController();



  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form = GlobalKey<FormState>();

    void _submitForm() {
      final isValid = form.currentState?.validate();
      if (isValid!) {
        // perform login action
        Get.to(DashBoardPage());
      }
    }
    return Scaffold(

      appBar: AppBar(
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
                      obscureText: true,
                      controller : loginController.emailController,
                      decoration: InputDecoration(

                        hintText: "Email *",
                        labelText: "email",

                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.sp),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffff00a6d6)),

                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),

                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          Get.snackbar("Error", "Please Enter a Valid Email ");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _emailController.text = value!;
                      },

                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(

                      obscureText: _obscureText,
                      controller : loginController.passwordController,
                      decoration: InputDecoration(

                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: _toggleObscureText,
                        ),

                        hintText: "Password *",
                        labelText: "Password",

                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.sp),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffff00a6d6)),

                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),

                        ),
                      ),

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
                        labelText: "Organization Code",
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.sp),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffff00a6d6)),
                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                        ),
                      ),


                    ),
/**/
                    // forgot password line

                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgotPassword());
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
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                        ),
                          child: ElevatedButton(
                            onPressed: () {
                              loginController.loginWithEmail();

                              print("Button Tap2");

                              _submitForm;
                              // loginController.loginWithEmail();
                            },
                            style:

                            ElevatedButton.styleFrom(shape: const StadiumBorder(),backgroundColor: const Color(0xff171A63)),
                            child: Text('Login' ,style:  TextStyle(fontWeight: FontWeight.bold ,fontSize: 16.sp),),
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

