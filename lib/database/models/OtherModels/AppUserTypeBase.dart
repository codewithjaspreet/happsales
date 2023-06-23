import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUserTypeBase extends BaseEntity {
  String? _appUserTypeID;
  String? _appUserTypeCode;
  String? _appUserTypeName;
  String? _isExternalUser;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;

  String? _appUserName;
  String? _appUserGroupName;

  // Getters
  String? get appUserTypeID => _appUserTypeID;
  String? get appUserTypeCode => _appUserTypeCode;
  String? get appUserTypeName => _appUserTypeName;
  String? get isExternalUser => _isExternalUser;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get modifiedBy => _modifiedBy;
  String? get modifiedOn => _modifiedOn;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get appUserID => _appUserID;
  String? get appUserGroupID => _appUserGroupID;
  String? get isDeleted => _isDeleted;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;


AppUserTypeBase();
  // Setters
  set appUserTypeID(String? value) {
    _appUserTypeID = value;
  }

  set appUserTypeCode(String? value) {
    _appUserTypeCode = value;
  }

  set appUserTypeName(String? value) {
    _appUserTypeName = value;
  }

  set isExternalUser(String? value) {
    _isExternalUser = value;
  }

  set createdBy(String? value) {
    _createdBy = value;
  }

  set createdOn(String? value) {
    _createdOn = value;
  }

  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  set isActive(String? value) {
    _isActive = value;
  }

  set uid(String? value) {
    _uid = value;
  }

  set appUserID(String? value) {
    _appUserID = value;
  }

  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  set isDeleted(String? value) {
    _isDeleted = value;
  }

  set appUserName(String? value) {
    _appUserName = value;
  }

  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'AppUserTypeID': _appUserTypeID,
      'AppUserTypeCode': _appUserTypeCode,
      'AppUserTypeName': _appUserTypeName,
      'IsExternalUser': _isExternalUser,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  AppUserTypeBase.fromMap(Map<String, dynamic> map) {

    _appUserTypeID = map['AppUserTypeID'];
    _appUserTypeCode = map['AppUserTypeCode'];
    _appUserTypeName = map['AppUserTypeName'];
    _isExternalUser = map['IsExternalUser'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
