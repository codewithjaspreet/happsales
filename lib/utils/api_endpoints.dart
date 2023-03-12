import 'package:get/get.dart';

import '../viewmodels/login_view_model.dart';

class ApiEndPoints {

  static LoginController loginController = Get. put(LoginController());
  static const String baseUrl = 'http://13.68.210.77:8080/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String forgotPassword = 'login/resetpassword';
  final String loginEmail = 'login';


  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6Ikphc3ByZWV0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvdXBuIjoiSEFQUFNBTEVTREVWIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9wcmltYXJ5c2lkIjoiMTg1MCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcHJpbWFyeWdyb3Vwc2lkIjoiMSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3NpZCI6ImVlYzgyNzMxLTk2ZmYtOWRkYy04MTliLWQ5ZjNmM2EwOWJjOSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZ3JvdXBzaWQiOiIxNTdhMmNjYS0xOTU0LTRlODktOWQzNS1hMDNiYmQ3MTM2M2QiLCJqdGkiOiJkMzlmZDFmOS0zN2QwLTRhNmItYmM0OC1mZmYxNmJmYTM0NTYiLCJleHAiOjE3MDk4MDI1MzYsImlzcyI6ImhhcHBzYWxlcy5jb20iLCJhdWQiOiJoYXBwc2FsZXMuY29tIn0.KLloWbg2EXRxaLwyT1LqK8RKBU-YiTx4c6AHZyQGcQ0";

  final String getAccountPaged = 'v1/DownSyncManager/GetAccountPaged';
  final String getContactPaged = 'v1/DownSyncManager/GetContactPaged';

  final String loginPhone = 'GetAppUser';
}

// http://13.68.210.77:8080/api/v1/DownSyncManager/GetAccountPaged
