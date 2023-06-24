import 'package:happsales_crm/database/models/BaseEntity.dart';

class TerritoryModelBase extends BaseEntity {
  String? _territoryID;
  String? _territoryCode;
  String? _territoryName;
  String? _description;
  String? _parentTerritoryID;
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
  String? _parentTerritoryName;
  String? _appUserName;
  String? _appUserGroupName;

  TerritoryModelBase();

  String? get territoryID => _territoryID;
  set territoryID(String? territoryID) => _territoryID = territoryID;

  String? get territoryCode => _territoryCode;
  set territoryCode(String? territoryCode) => _territoryCode = territoryCode;

  String? get territoryName => _territoryName;
  set territoryName(String? territoryName) => _territoryName = territoryName;

  String? get description => _description;
  set description(String? description) => _description = description;

  String? get parentTerritoryID => _parentTerritoryID;
  set parentTerritoryID(String? parentTerritoryID) =>
      _parentTerritoryID = parentTerritoryID;

  String? get createdOn => _createdOn;
  set createdOn(String? createdOn) => _createdOn = createdOn;

  String? get createdBy => _createdBy;
  set createdBy(String? createdBy) => _createdBy = createdBy;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? modifiedOn) => _modifiedOn = modifiedOn;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? modifiedBy) => _modifiedBy = modifiedBy;

  String? get isActive => _isActive;
  set isActive(String? isActive) => _isActive = isActive;

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

  String? get parentTerritoryName => _parentTerritoryName;
  set parentTerritoryName(String? parentTerritoryName) =>
      _parentTerritoryName = parentTerritoryName;

  String? get appUserName => _appUserName;
  set appUserName(String? appUserName) => _appUserName = appUserName;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? appUserGroupName) =>
      _appUserGroupName = appUserGroupName;

  Map<String, dynamic> toMap() {
    return {
      'TerritoryID': _territoryID,
      'TerritoryCode': _territoryCode,
      'TerritoryName': _territoryName,
      'Description': _description,
      'ParentTerritoryID': _parentTerritoryID,
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
      'ParentTerritoryName': _parentTerritoryName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  //from map

  TerritoryModelBase.fromMap(Map<String, dynamic> map) {
    _territoryID = map['TerritoryID'];
    _territoryCode = map['TerritoryCode'];
    _territoryName = map['TerritoryName'];
    _description = map['Description'];
    _parentTerritoryID = map['ParentTerritoryID'];
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
    _parentTerritoryName = map['ParentTerritoryName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
