import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUserTertitoryBase  extends BaseEntity{ 
  String? _appUserTerritoryID;
  String? _appUserTerritoryCode;
  String? _appUserID;
  String? _territoryID;
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
  String? _territoryName;
  String? _appUserGroupName;
AppUserTertitoryBase();
  // Getters
  String? get appUserTerritoryID => _appUserTerritoryID;
  String? get appUserTerritoryCode => _appUserTerritoryCode;
  String? get appUserID => _appUserID;
  String? get territoryID => _territoryID;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get modifiedBy => _modifiedBy;
  String? get modifiedOn => _modifiedOn;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get appUserGroupID => _appUserGroupID;
  String? get isArchived => _isArchived;
  String? get isDeleted => _isDeleted;
  String? get appUserName => _appUserName;
  String? get territoryName => _territoryName;
  String? get appUserGroupName => _appUserGroupName;

  // Setters
  set appUserTerritoryID(String? value) {
    _appUserTerritoryID = value;
  }

  set appUserTerritoryCode(String? value) {
    _appUserTerritoryCode = value;
  }

  set appUserID(String? value) {
    _appUserID = value;
  }

  set territoryID(String? value) {
    _territoryID = value;
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

  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  set isArchived(String? value) {
    _isArchived = value;
  }

  set isDeleted(String? value) {
    _isDeleted = value;
  }

  set appUserName(String? value) {
    _appUserName = value;
  }

  set territoryName(String? value) {
    _territoryName = value;
  }

  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'AppUserTerritoryID': _appUserTerritoryID,
      'AppUserTerritoryCode': _appUserTerritoryCode,
      'AppUserID': _appUserID,
      'TerritoryID': _territoryID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'TerritoryName': _territoryName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  AppUserTertitoryBase.fromMap(Map<String, dynamic> map) {

    _appUserTerritoryID = map['AppUserTerritoryID'];
    _appUserTerritoryCode = map['AppUserTerritoryCode'];
    _appUserID = map['AppUserID'];
    _territoryID = map['TerritoryID'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _territoryName = map['TerritoryName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
