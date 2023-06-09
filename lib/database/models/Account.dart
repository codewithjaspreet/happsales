
import 'AccountBase.dart';

class Account extends AccountBase {


  String? _localMediaPath;
  String? _isUploaded;


  Account();
  

  String? get localMediaPath => _localMediaPath;

  set localMediaPath(String? value) {
    _localMediaPath = value;
  }

  String? get isUploaded => _isUploaded;

  set isUploaded(String? value) {
    _isUploaded = value;
  }
    


}
