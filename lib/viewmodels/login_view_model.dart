import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_endpoints.dart';
import '../view/home_screen.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController orgController = TextEditingController();

  Future<void> loginWithEmail() async {
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
        String token = jsonResponse['token'];

        print(token);

        // Save the token to shared preferences for future use
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Navigate to the home screen or other relevant screen
        Get.off(const HomeScreen());
      } else {
        // If the response is not successful, display an error message
        throw Exception('Failed to login: ${response.statusCode}');
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
  }

}