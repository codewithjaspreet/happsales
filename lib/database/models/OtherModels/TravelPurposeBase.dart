import 'package:happsales_crm/database/models/BaseEntity.dart';

class TravelPurposeBase extends BaseEntity {
  String? _travelPurposeID;
  String? _travelPurposeCode;
  String? _travelPurposeName;
  String? _travelPurposeDescription;
  String? _businessFeatureID;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _businessFeatureName;
  String? _appUserName;
  String? _appUserGroupName;

  TravelPurposeBase();

  String? get travelPurposeID => _travelPurposeID;
  set travelPurposeID(String? travelPurposeID) =>
      _travelPurposeID = travelPurposeID;

  String? get travelPurposeCode => _travelPurposeCode;
  set travelPurposeCode(String? travelPurposeCode) =>
      _travelPurposeCode = travelPurposeCode;

  String? get travelPurposeName => _travelPurposeName;
  set travelPurposeName(String? travelPurposeName) =>
      _travelPurposeName = travelPurposeName;

  String? get travelPurposeDescription => _travelPurposeDescription;
  set travelPurposeDescription(String? travelPurposeDescription) =>
      _travelPurposeDescription = travelPurposeDescription;

  String? get businessFeatureID => _businessFeatureID;
  set businessFeatureID(String? businessFeatureID) =>
      _businessFeatureID = businessFeatureID;

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

  String? get isDeleted => _isDeleted;
  set isDeleted(String? isDeleted) => _isDeleted = isDeleted;

  String? get businessFeatureName => _businessFeatureName;
  set businessFeatureName(String? businessFeatureName) =>
      _businessFeatureName = businessFeatureName;

  String? get appUserName => _appUserName;
  set appUserName(String? appUserName) => _appUserName = appUserName;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? appUserGroupName) =>
      _appUserGroupName = appUserGroupName;

  Map<String, dynamic> toMap() {
    return {
      'TravelPurposeID': _travelPurposeID,
      'TravelPurposeCode': _travelPurposeCode,
      'TravelPurposeName': _travelPurposeName,
      'TravelPurposeDescription': _travelPurposeDescription,
      'BusinessFeatureID': _businessFeatureID,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
      'BusinessFeatureName': _businessFeatureName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
// frommap
  TravelPurposeBase.fromMap(Map<String, dynamic> map) {
    _travelPurposeID = map['TravelPurposeID'];
    _travelPurposeCode = map['TravelPurposeCode'];
    _travelPurposeName = map['TravelPurposeName'];
    _travelPurposeDescription = map['TravelPurposeDescription'];
    _businessFeatureID = map['BusinessFeatureID'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _businessFeatureName = map['BusinessFeatureName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
