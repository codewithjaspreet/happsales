import 'package:happsales_crm/database/models/OpportunityModels/OpportunityMediaBase.dart';

class OpportunityMedia extends OpportunityMediaBase{


   String? _localMediaPath;

    String? get localMediaPath => _localMediaPath;

    set localMediaPath(String? localMediaPath) {
      _localMediaPath = localMediaPath;
    }

    String? _isUploaded;

    String? get isUploaded => _isUploaded;

    set isUploaded(String? isUploaded) {
      _isUploaded = isUploaded;
    }
    
  OpportunityMedia();

}