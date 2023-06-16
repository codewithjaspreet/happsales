import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityPermissionBase extends BaseEntity {
  String? _activityPermissionID;
  String? _activityPermissionCode;
  String? _activityID;
  String? _appUserID;
  String? _permissionLevel;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _activityTitle;
  String? _appUserName;
  String? _appUserGroupName;

  String? get activityPermissionID => _activityPermissionID;
  set activityPermissionID(String? value) => _activityPermissionID = value;

  String? get activityPermissionCode => _activityPermissionCode;
  set activityPermissionCode(String? value) => _activityPermissionCode = value;

  String? get activityID => _activityID;
  set activityID(String? value) => _activityID = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get permissionLevel => _permissionLevel;
  set permissionLevel(String? value) => _permissionLevel = value;

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

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) => _activityTitle = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  ActivityPermissionBase();

  ActivityPermissionBase.fromMapObject(Map<String, dynamic> map) {
    _activityPermissionID = map['ActivityPermissionID'];
    _activityPermissionCode = map['ActivityPermissionCode'];
    _activityID = map['ActivityID'];
    _appUserID = map['AppUserID'];
    _permissionLevel = map['PermissionLevel'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _activityTitle = map['ActivityTitle'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityPermissionID': _activityPermissionID,
      'ActivityPermissionCode': _activityPermissionCode,
      'ActivityID': _activityID,
      'AppUserID': _appUserID,
      'PermissionLevel': _permissionLevel,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'ActivityTitle': _activityTitle,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
