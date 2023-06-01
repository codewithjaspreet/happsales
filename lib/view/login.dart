import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/dashboard/parent.dart';

import '../viewmodels/login_view_model.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  LoginController loginController = Get.put(LoginController());

  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final FocusNode _passwordFocusNode = FocusNode();

  bool _obscureText = true;
  Color _passwordIconColor = const Color(0xffB4C6D4);

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


      if(form.currentState!.validate()){

        SnackBar snackBar = const SnackBar(content: Text("Login Successful"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.offAll(() =>  DashBoardPage());
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

                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffff00a6d6)),
                        ),



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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(

                      onTap: () {
                        // Change the suffix icon color when the field is tapped
                        setState(() {

                          _passwordIconColor = const Color(0xffff00a6d6);
                        });
                      },
                      obscureText: _obscureText,
                      controller : loginController.passwordController,
                      decoration: InputDecoration(

                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffff00a6d6)),
                        ),


                        suffixIcon: IconButton(
                          icon: Icon(

                              _obscureText ? Icons.visibility_off : Icons.visibility,color: _passwordIconColor
                          ),
                          onPressed: _toggleObscureText,
                        ),

                        hintText: "Password *",
                        labelText: "Password",

                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.sp),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff00A6D6)),

                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),

                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
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
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffff00a6d6)),
                        ),
                        hintText: "Organization Code *",
                        labelText: "Organization Code",
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.sp),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffff00a6d6)),
                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Organisation Code';
                        }
                        return null;
                      },

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
                          mainAxisAlignment: MainAxisAlignment.center,

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
                              print("login tak aagya");
                              loginController.loginWithEmail();
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
