import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityStatusBase extends BaseEntity {
  String? _activityStatusID;
  String? _activityStatusCode;
  String? _activityStatusName;
  String? _internalCode;
  String? _displayInApp;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  String? get activityStatusID => _activityStatusID;
  set activityStatusID(String? value) => _activityStatusID = value;

  String? get activityStatusCode => _activityStatusCode;
  set activityStatusCode(String? value) => _activityStatusCode = value;

  String? get activityStatusName => _activityStatusName;
  set activityStatusName(String? value) => _activityStatusName = value;

  String? get internalCode => _internalCode;
  set internalCode(String? value) => _internalCode = value;

  String? get displayInApp => _displayInApp;
  set displayInApp(String? value) => _displayInApp = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  ActivityStatusBase();

  ActivityStatusBase.fromMapObject(Map<String, dynamic> map) {
    _activityStatusID = map['ActivityStatusID'];
    _activityStatusCode = map['ActivityStatusCode'];
    _activityStatusName = map['ActivityStatusName'];
    _internalCode = map['InternalCode'];
    _displayInApp = map['DisplayInApp'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityStatusID': _activityStatusID,
      'ActivityStatusCode': _activityStatusCode,
      'ActivityStatusName': _activityStatusName,
      'InternalCode': _internalCode,
      'DisplayInApp': _displayInApp,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
