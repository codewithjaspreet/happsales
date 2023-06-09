
import 'AccountBase.dart';

class Account extends AccountBase {


  String? _localMediaPath;
  String? _isUploaded;


  Account();

  
    

  String? getLocalMediaPath() {
    return _localMediaPath;
  }

  void setLocalMediaPath(String localMediaPath) {
    _localMediaPath = localMediaPath;
  }

  String? getIsUploaded() {
    return _isUploaded;
  }

  void setIsUploaded(String isUploaded) {
    _isUploaded = isUploaded;
  }
}
