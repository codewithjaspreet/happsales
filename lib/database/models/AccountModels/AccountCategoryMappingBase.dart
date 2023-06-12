import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountCategoryMappingBase extends BaseEntity{
  String? _accountCategoryMappingID;
  String? _accountCategoryMappingCode;
  String? _accountID;
  String? _accountCategoryID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _accountName;
  String? _accountCategoryName;
  String? _appUserName;
  String? _appUserGroupName;

  AccountCategoryMappingBase();

  String? get accountCategoryMappingID {
    return _accountCategoryMappingID;
  }

  set accountCategoryMappingID(String? value) {
    _accountCategoryMappingID = value;
  }

  String? get accountCategoryMappingCode {
    return _accountCategoryMappingCode;
  }

  set accountCategoryMappingCode(String? value) {
    _accountCategoryMappingCode = value;
  }

  String? get accountID {
    return _accountID;
  }

  set accountID(String? value) {
    _accountID = value;
  }

  String? get accountCategoryID {
    return _accountCategoryID;
  }

  set accountCategoryID(String? value) {
    _accountCategoryID = value;
  }

  String? get createdBy {
    return _createdBy;
  }

  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get createdOn {
    return _createdOn;
  }

  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get modifiedBy {
    return _modifiedBy;
  }

  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get modifiedOn {
    return _modifiedOn;
  }

  set modifiedOn(String? value) {
    _modifiedOn = value;
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

  String? get accountName {
    return _accountName;
  }

  set accountName(String? value) {
    _accountName = value;
  }

  String? get accountCategoryName {
    return _accountCategoryName;
  }

  set accountCategoryName(String? value) {
    _accountCategoryName = value;
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

  Map<String, dynamic> toMap() {
    return {
      'AccountCategoryMappingID': _accountCategoryMappingID,
      'AccountCategoryMappingCode': _accountCategoryMappingCode,
      'AccountID': _accountID,
      'AccountCategoryID': _accountCategoryID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'AccountName': _accountName,
      'AccountCategoryName': _accountCategoryName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  AccountCategoryMappingBase.fromMapObject(Map<String, dynamic> map) {
    accountCategoryMappingID = map['AccountCategoryMappingID'];
    accountCategoryMappingCode = map['AccountCategoryMappingCode'];
    accountID = map['AccountID'];
    accountCategoryID = map['AccountCategoryID'];
    createdBy = map['CreatedBy'];
    createdOn = map['CreatedOn'];
    modifiedBy = map['ModifiedBy'];
    modifiedOn = map['ModifiedOn'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    isArchived = map['IsArchived'];
    isDeleted = map['IsDeleted'];
    accountName = map['AccountName'];
    accountCategoryName = map['AccountCategoryName'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }
}
