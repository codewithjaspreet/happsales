
import 'AccountBase.dart';

class Account extends AccountBase {


  String? _localMediaPath;
  String? _isUploaded;
 // base entity attributes
  String? _id;
  String? _isDirty;
  String? _isDeleted1;
  String? _upSyncMessage;
  String? _downSyncMessage;
  String? _sCreatedOn;
  String? _sModifiedOn;
  String? _createdByUser;
  String? _modifiedByUser;
  String? _upSyncIndex;
  String? _ownerUserID;



  Account();
  

  String? get localMediaPath => _localMediaPath;

  set localMediaPath(String? value) {
    _localMediaPath = value;
  }

  String? get isUploaded => _isUploaded;

  set isUploaded(String? value) {
    _isUploaded = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

String? get isDirty => _isDirty;
set isDirty(String? value) => _isDirty = value;

String? get isDeleted1 => _isDeleted1;
set isDeleted1(String? value) => _isDeleted1 = value;

String? get upSyncMessage => _upSyncMessage;
set upSyncMessage(String? value) => _upSyncMessage = value;

String? get downSyncMessage => _downSyncMessage;
set downSyncMessage(String? value) => _downSyncMessage = value;

String? get sCreatedOn => _sCreatedOn;
set sCreatedOn(String? value) => _sCreatedOn = value;

String? get sModifiedOn => _sModifiedOn;
set sModifiedOn(String? value) => _sModifiedOn = value;

String? get createdByUser => _createdByUser;
set createdByUser(String? value) => _createdByUser = value;

String? get modifiedByUser => _modifiedByUser;
set modifiedByUser(String? value) => _modifiedByUser = value;

String? get upSyncIndex => _upSyncIndex;
set upSyncIndex(String? value) => _upSyncIndex = value;

String? get ownerUserID => _ownerUserID;
set ownerUserID(String? value) => _ownerUserID = value;

  

    


}
