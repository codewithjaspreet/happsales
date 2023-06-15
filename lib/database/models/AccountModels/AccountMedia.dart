import 'AccountMediaBase.dart';

class AccountMedia extends AccountMediaBase{

   String? _LocalMediaPath;

  String? get LocalMediaPath => _LocalMediaPath;

  set LocalMediaPath(String? value) {
    _LocalMediaPath = value;
  }
   String? _IsUploaded;

  String? get IsUploaded => _IsUploaded;

  set IsUploaded(String? value) {
    _IsUploaded = value;
  }



  AccountMedia();
}