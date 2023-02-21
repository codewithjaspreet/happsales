class ApiEndPoints {
  static final String baseUrl = 'http://13.68.210.77:8080/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String forgotPassword = 'resetpassword';
  final String loginEmail = 'login';

  final String loginPhone = 'GetAppUser';
}