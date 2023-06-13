import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountBusinessUnitBase  extends BaseEntity{
  String? _accountBusinessUnitID;
  String? _accountBusinessUnitCode;
  String? _accountID;
  String? _businessUnitID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _referenceIdentifier;
  String? _isDeleted;
  String? _isArchived;
  String? _accountName;
  String? _businessUnitName;
  String? _appUserName;
  String? _appUserGroupName;

  AccountBusinessUnitBase();

  String? get accountBusinessUnitID {
    return _accountBusinessUnitID;
  }

  set accountBusinessUnitID(String? value) {
    _accountBusinessUnitID = value;
  }

  String? get accountBusinessUnitCode {
    return _accountBusinessUnitCode;
  }

  set accountBusinessUnitCode(String? value) {
    _accountBusinessUnitCode = value;
  }

  String? get accountID {
    return _accountID;
  }

  set accountID(String? value) {
    _accountID = value;
  }

  String? get businessUnitID {
    return _businessUnitID;
  }

  set businessUnitID(String? value) {
    _businessUnitID = value;
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

  String? get referenceIdentifier {
    return _referenceIdentifier;
  }

  set referenceIdentifier(String? value) {
    _referenceIdentifier = value;
  }

  String? get isDeleted {
    return _isDeleted;
  }

  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get isArchived {
    return _isArchived;
  }

  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get accountName {
    return _accountName;
  }

  set accountName(String? value) {
    _accountName = value;
  }

  String? get businessUnitName {
    return _businessUnitName;
  }

  set businessUnitName(String? value) {
    _businessUnitName = value;
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

  AccountBusinessUnitBase.fromMapObject(Map<String, dynamic> map) {
    _accountBusinessUnitID = map['AccountBusinessUnitID'];
    _accountBusinessUnitCode = map['AccountBusinessUnitCode'];
    _accountID = map['AccountID'];
    _businessUnitID = map['BusinessUnitID'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _isDeleted = map['IsDeleted'];
    _isArchived = map['IsArchived'];
    _accountName = map['AccountName'];
    _businessUnitName = map['BusinessUnitName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountBusinessUnitID': _accountBusinessUnitID,
      'AccountBusinessUnitCode': _accountBusinessUnitCode,
      'AccountID': _accountID,
      'BusinessUnitID': _businessUnitID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'ReferenceIdentifier': _referenceIdentifier,
      'IsDeleted': _isDeleted,
      'IsArchived': _isArchived,
      'AccountName': _accountName,
      'BusinessUnitName': _businessUnitName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
