import 'package:happsales_crm/database/models/BaseEntity.dart';

class UserRoleBase extends BaseEntity {
  String? _userRoleID;
  String? _userRoleCode;
  String? _userRoleName;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _isSystemDefined;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  UserRoleBase();

  String? get userRoleID => _userRoleID;
  set userRoleID(String? userRoleID) => _userRoleID = userRoleID;

  String? get userRoleCode => _userRoleCode;
  set userRoleCode(String? userRoleCode) => _userRoleCode = userRoleCode;

  String? get userRoleName => _userRoleName;
  set userRoleName(String? userRoleName) => _userRoleName = userRoleName;

  String? get createdBy => _createdBy;
  set createdBy(String? createdBy) => _createdBy = createdBy;

  String? get createdOn => _createdOn;
  set createdOn(String? createdOn) => _createdOn = createdOn;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? modifiedBy) => _modifiedBy = modifiedBy;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? modifiedOn) => _modifiedOn = modifiedOn;

  String? get isActive => _isActive;
  set isActive(String? isActive) => _isActive = isActive;

  String? get isSystemDefined => _isSystemDefined;
  set isSystemDefined(String? isSystemDefined) =>
      _isSystemDefined = isSystemDefined;

  String? get uid => _uid;
  set uid(String? uid) => _uid = uid;

  String? get appUserID => _appUserID;
  set appUserID(String? appUserID) => _appUserID = appUserID;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? appUserGroupID) =>
      _appUserGroupID = appUserGroupID;

  String? get isArchived => _isArchived;
  set isArchived(String? isArchived) => _isArchived = isArchived;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? isDeleted) => _isDeleted = isDeleted;

  String? get appUserName => _appUserName;
  set appUserName(String? appUserName) => _appUserName = appUserName;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? appUserGroupName) =>
      _appUserGroupName = appUserGroupName;

  Map<String, dynamic> toMap() {
    return {
      'UserRoleID': _userRoleID,
      'UserRoleCode': _userRoleCode,
      'UserRoleName': _userRoleName,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'IsSystemDefined': _isSystemDefined,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

 //FROMmap

  UserRoleBase.fromMap(Map<String, dynamic> map) {
    _userRoleID = map['UserRoleID'];
    _userRoleCode = map['UserRoleCode'];
    _userRoleName = map['UserRoleName'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _isSystemDefined = map['IsSystemDefined'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
