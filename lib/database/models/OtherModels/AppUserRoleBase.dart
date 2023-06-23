
import '../../Models/BaseEntity.dart';

class AppUserRoleBase extends BaseEntity {
  String? _appUserRoleID;
  String? _appUserRoleCode;
  String? _appUserID;
  String? _userRoleID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _userRoleName;
  String? _appUserGroupName;


AppUserRoleBase();
  String? get appUserRoleID => _appUserRoleID;
  set appUserRoleID(String? value) {
    _appUserRoleID = value;
  }

  String? get appUserRoleCode => _appUserRoleCode;
  set appUserRoleCode(String? value) {
    _appUserRoleCode = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get userRoleID => _userRoleID;
  set userRoleID(String? value) {
    _userRoleID = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;

  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get appUserName => _appUserName;

  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get userRoleName => _userRoleName;

  set userRoleName(String? value) {
    _userRoleName = value;
  }

  String? get appUserGroupName => _appUserGroupName;

  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

   Map<String, dynamic> toMap() {
    return {
      'appUserRoleID': _appUserRoleID,
      'appUserRoleCode': _appUserRoleCode,
      'appUserID': _appUserID,
      'userRoleID': _userRoleID,
      'createdBy': _createdBy,
      'createdOn': _createdOn,
      'modifiedBy': _modifiedBy,
      'modifiedOn': _modifiedOn,
      'isActive': _isActive,
      'uid': _uid,
      'appUserGroupID': _appUserGroupID,
      'isArchived': _isArchived,
      'isDeleted': _isDeleted,
      'appUserName': _appUserName,
      'userRoleName': _userRoleName,
      'appUserGroupName': _appUserGroupName,
    };
  }

   AppUserRoleBase.fromMap(Map<String, dynamic> map) {
    _appUserRoleID = map['appUserRoleID'];
    _appUserRoleCode = map['appUserRoleCode'];
    _appUserID = map['appUserID'];
    _userRoleID = map['userRoleID'];
    _createdBy = map['createdBy'];
    _createdOn = map['createdOn'];
    _modifiedBy = map['modifiedBy'];
    _modifiedOn = map['modifiedOn'];
    _isActive = map['isActive'];
    _uid = map['uid'];
    _appUserGroupID = map['appUserGroupID'];
    _isArchived = map['isArchived'];
    _isDeleted = map['isDeleted'];
    _appUserName = map['appUserName'];
    _userRoleName = map['userRoleName'];
    _appUserGroupName = map['appUserGroupName'];

   }

  }