import 'NoteMediaBase.dart';

class NoteMedia extends NoteMediaBase{


     String? _localMediaPath;
     String? _isUploaded;


     //getter 

      String? get localMediaPath => _localMediaPath;
      String? get isUploaded => _isUploaded;

      //setter

      set localMediaPath(String? localMediaPath) => _localMediaPath = localMediaPath;
      set isUploaded(String? isUploaded) => _isUploaded = isUploaded;
      


  NoteMedia();
}