import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountBuyingProcessBase extends BaseEntity{
  String? _accountBuyingProcessID;
  String? _accountBuyingProcessCode;
  String? _buyingProcess;
  String? _accountID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _accountName;
  String? _appUserName;
  String? _appUserGroupName;

  String? get accountBuyingProcessID {
    return _accountBuyingProcessID;
  }

  set accountBuyingProcessID(String? value) {
    _accountBuyingProcessID = value;
  }

  String? get accountBuyingProcessCode {
    return _accountBuyingProcessCode;
  }

  set accountBuyingProcessCode(String? value) {
    _accountBuyingProcessCode = value;
  }

  String? get buyingProcess {
    return _buyingProcess;
  }

  set buyingProcess(String? value) {
    _buyingProcess = value;
  }

  String? get accountID {
    return _accountID;
  }

  set accountID(String? value) {
    _accountID = value;
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

  String? get deviceIdentifier {
    return _deviceIdentifier;
  }

  set deviceIdentifier(String? value) {
    _deviceIdentifier = value;
  }

  String? get referenceIdentifier {
    return _referenceIdentifier;
  }

  set referenceIdentifier(String? value) {
    _referenceIdentifier = value;
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

  AccountBuyingProcessBase();

  AccountBuyingProcessBase.fromMapObject(Map<String, dynamic> map) {
    _accountBuyingProcessID = map['AccountBuyingProcessID'];
    _accountBuyingProcessCode = map['AccountBuyingProcessCode'];
    _buyingProcess = map['BuyingProcess'];
    _accountID = map['AccountID'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _accountName = map['AccountName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountBuyingProcessID': _accountBuyingProcessID,
      'AccountBuyingProcessCode': _accountBuyingProcessCode,
      'BuyingProcess': _buyingProcess,
      'AccountID': _accountID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'DeviceIdentifier': _deviceIdentifier,
      'ReferenceIdentifier': _referenceIdentifier,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'AccountName': _accountName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
