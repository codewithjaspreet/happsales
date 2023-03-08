class ApiEndPoints {
  static const String baseUrl = 'http://13.68.210.77:8080/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String forgotPassword = 'login/resetpassword';
  final String loginEmail = 'login';

  final String getAccountPaged  = 'v1/DownSyncManager/GetAccountPaged';

  final String loginPhone = 'GetAppUser';
}


// http://13.68.210.77:8080/api/v1/DownSyncManager/GetAccountPaged