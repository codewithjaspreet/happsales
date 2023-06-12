import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountCategoryBase extends BaseEntity{
  String? _accountCategoryID;
  String? _accountCategoryCode;
  String? _accountCategoryName;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  String? get accountCategoryID {
    return _accountCategoryID;
  }

  set accountCategoryID(String? value) {
    _accountCategoryID = value;
  }

  String? get accountCategoryCode {
    return _accountCategoryCode;
  }

  set accountCategoryCode(String? value) {
    _accountCategoryCode = value;
  }

  String? get accountCategoryName {
    return _accountCategoryName;
  }

  set accountCategoryName(String? value) {
    _accountCategoryName = value;
  }

  String? get createdOn {
    return _createdOn;
  }

  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get createdBy {
    return _createdBy;
  }

  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get modifiedOn {
    return _modifiedOn;
  }

  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get modifiedBy {
    return _modifiedBy;
  }

  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get isActive {
    return _isActive;
  }

  set isActive(String? value) {
    _isActive = value;
  }

  String? get uid {
    return _uid;
  }

  set uid(String? value) {
    _uid = value;
  }

  String? get appUserID {
    return _appUserID;
  }

  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get appUserGroupID {
    return _appUserGroupID;
  }

  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  String? get isArchived {
    return _isArchived;
  }

  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted {
    return _isDeleted;
  }

  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get appUserName {
    return _appUserName;
  }

  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName {
    return _appUserGroupName;
  }

  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  AccountCategoryBase();

  AccountCategoryBase.fromMapObject(Map<String, dynamic> map) {
    _accountCategoryID = map['AccountCategoryID'];
    _accountCategoryCode = map['AccountCategoryCode'];
    _accountCategoryName = map['AccountCategoryName'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountCategoryID': _accountCategoryID,
      'AccountCategoryCode': _accountCategoryCode,
      'AccountCategoryName': _accountCategoryName,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
