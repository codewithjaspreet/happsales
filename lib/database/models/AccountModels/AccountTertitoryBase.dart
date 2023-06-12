import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountTerritoryBase extends BaseEntity {
  String? _accountTerritoryID;
  String? _accountTerritoryCode;
  String? _territoryID;
  String? _accountID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserGroupID;
  String? _appUserID;
  String? _isArchived;
  String? _isDeleted;
  String? _territoryName;
  String? _accountName;
  String? _appUserGroupName;
  String? _appUserName;

  AccountTerritoryBase();

  String? get accountTerritoryID => _accountTerritoryID;
  set accountTerritoryID(String? value) {
    _accountTerritoryID = value;
  }

  String? get accountTerritoryCode => _accountTerritoryCode;
  set accountTerritoryCode(String? value) {
    _accountTerritoryCode = value;
  }

  String? get territoryID => _territoryID;
  set territoryID(String? value) {
    _territoryID = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
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

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get territoryName => _territoryName;
  set territoryName(String? value) {
    _territoryName = value;
  }

  String? get accountName => _accountName;
  set accountName(String? value) {
    _accountName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  void fromMapObject(Map<String, dynamic> map) {
    _accountTerritoryID = map['AccountTerritoryID'];
    _accountTerritoryCode = map['AccountTerritoryCode'];
    _territoryID = map['TerritoryID'];
    _accountID = map['AccountID'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserGroupID = map['AppUserGroupID'];
    _appUserID = map['AppUserID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _territoryName = map['TerritoryName'];
    _accountName = map['AccountName'];
    _appUserGroupName = map['AppUserGroupName'];
    _appUserName = map['AppUserName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountTerritoryID': _accountTerritoryID,
      'AccountTerritoryCode': _accountTerritoryCode,
      'TerritoryID': _territoryID,
      'AccountID': _accountID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserGroupID': _appUserGroupID,
      'AppUserID': _appUserID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'TerritoryName': _territoryName,
      'AccountName': _accountName,
      'AppUserGroupName': _appUserGroupName,
      'AppUserName': _appUserName,
    };
  }
}
