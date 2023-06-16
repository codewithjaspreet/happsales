import '../../Models/BaseEntity.dart';

class ActivityBusinessUnitBase extends BaseEntity {
  String? _activityBusinessUnitID;
  String? _activityBusinessUnitCode;
  String? _activityID;
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
  String? _activityTitle;
  String? _businessUnitName;
  String? _appUserName;
  String? _appUserGroupName;

  ActivityBusinessUnitBase();

  String? get activityBusinessUnitID => _activityBusinessUnitID;
  set activityBusinessUnitID(String? value) => _activityBusinessUnitID = value;

  String? get activityBusinessUnitCode => _activityBusinessUnitCode;
  set activityBusinessUnitCode(String? value) => _activityBusinessUnitCode = value;

  String? get activityID => _activityID;
  set activityID(String? value) => _activityID = value;

  String? get businessUnitID => _businessUnitID;
  set businessUnitID(String? value) => _businessUnitID = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) => _referenceIdentifier = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) => _activityTitle = value;

  String? get businessUnitName => _businessUnitName;
  set businessUnitName(String? value) => _businessUnitName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  ActivityBusinessUnitBase.fromMapObject(Map<String, dynamic> map) {
    _activityBusinessUnitID = map['ActivityBusinessUnitID'];
    _activityBusinessUnitCode = map['ActivityBusinessUnitCode'];
    _activityID = map['ActivityID'];
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
    _activityTitle = map['ActivityTitle'];
    _businessUnitName = map['BusinessUnitName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityBusinessUnitID': _activityBusinessUnitID,
      'ActivityBusinessUnitCode': _activityBusinessUnitCode,
      'ActivityID': _activityID,
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
      'ActivityTitle': _activityTitle,
      'BusinessUnitName': _businessUnitName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
