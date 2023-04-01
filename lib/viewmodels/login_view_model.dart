import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/dashboard/parent.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_endpoints.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController orgController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController forgotOrgController = TextEditingController();
  TextEditingController forgotEmailController = TextEditingController();

  Future<String> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'LoginName': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'GroupCode': orgController.text.trim(),
      };
      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // If the response is successful, parse the JSON data and extract the token
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse);
        String token = jsonResponse['token'];

        print('token is $token');
        print('user email is${emailController.text.trim()}');

        // Save the token to shared preferences for future use
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        SharedPreferences cred = await SharedPreferences.getInstance();
        cred.setString('email', emailController.text.trim());

        // Navigate to the home screen or other relevant screen
        Get.off(const DashBoardPage());

        return token;



      } else {
        // If the response is not successful, display an error message
        // throw Exception('Failed to login: ${response.statusCode}');

        Get.snackbar(
          "Invalid Credentials",
          "Please Enter Valid Email or Password or Organization Code",
          icon: const Icon(

              Icons.error, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xff1b1e44),
          borderRadius: 20,
          margin: EdgeInsets.all(15.sp),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,

        );
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: EdgeInsets.all(20.sp),
              children: [Text(error.toString())],
            );
          });


    }

    return '';


  }
  //
  // Future<void> login(String username, String password) async {
  //   // Validate user credentials
  //   bool isValid = await authenticate(username, password);
  //
  //   if (isValid) {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //     // Save the user's credentials
  //     prefs.setBool('isLoggedIn', true);
  //     prefs.setString('username', username);
  //     prefs.setString('password', password);
  //   }
  // }

  Future<String> forgotPassword(String loginName, String emailAddress, String groupCode) async {

    // the api url for the reset password

    var apiUrl  = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.forgotPassword;

    // the body of the request
    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'LoginName': nameController.text.trim(),
          'EmailAddress': forgotEmailController.text.trim(),
          'GroupCode': forgotEmailController.text.trim(),
        }));

    // if the response is successful



    if (response.statusCode == 200) {

      Get.snackbar("Password Changed Successfully", "done");

      // here we can add an email sending service to send the email
      return 'Password reset instructions have been sent to your email.';
    } else {

      // if the response is not successful, display an error message
      return 'Something went wrong. Please try again later.';
    }
  }
}

