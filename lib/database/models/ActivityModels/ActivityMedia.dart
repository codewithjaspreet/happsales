import 'package:happsales_crm/database/models/ActivityModels/ActivityMediaBase.dart';

class ActivityMedia extends ActivityMediaBase{
  

     String? _isUploaded;
     String? _localMediaPath;

     // getters for both 
      String? get isUploaded => _isUploaded;
      String? get localMediaPath => _localMediaPath;

      // setters for both

      set isUploaded(String? isUploaded) => _isUploaded = isUploaded;
      set localMediaPath(String? localMediaPath) => _localMediaPath = localMediaPath;
      ActivityMedia();
}