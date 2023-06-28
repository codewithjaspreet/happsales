import 'package:happsales_crm/database/models/BaseEntity.dart';

class DesignationBase extends BaseEntity {
  String? _designationID;
  String? _designationCode;
  String? _designationName;
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

  DesignationBase();

  String? get designationID => _designationID;
  String? get designationCode => _designationCode;
  String? get designationName => _designationName;
  String? get createdOn => _createdOn;
  String? get createdBy => _createdBy;
  String? get modifiedOn => _modifiedOn;
  String? get modifiedBy => _modifiedBy;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get appUserID => _appUserID;
  String? get appUserGroupID => _appUserGroupID;
  String? get isArchived => _isArchived;
  String? get isDeleted => _isDeleted;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;

  set designationID(String? designationID) {
    _designationID = designationID;
  }

  set designationCode(String? designationCode) {
    _designationCode = designationCode;
  }

  set designationName(String? designationName) {
    _designationName = designationName;
  }

  set createdOn(String? createdOn) {
    _createdOn = createdOn;
  }

  set createdBy(String? createdBy) {
    _createdBy = createdBy;
  }

  set modifiedOn(String? modifiedOn) {
    _modifiedOn = modifiedOn;
  }

  set modifiedBy(String? modifiedBy) {
    _modifiedBy = modifiedBy;
  }

  set isActive(String? isActive) {
    _isActive = isActive;
  }

  set uid(String? uid) {
    _uid = uid;
  }

  set appUserID(String? appUserID) {
    _appUserID = appUserID;
  }

  set appUserGroupID(String? appUserGroupID) {
    _appUserGroupID = appUserGroupID;
  }

  set isArchived(String? isArchived) {
    _isArchived = isArchived;
  }

  set isDeleted(String? isDeleted) {
    _isDeleted = isDeleted;
  }

  set appUserName(String? appUserName) {
    _appUserName = appUserName;
  }

  set appUserGroupName(String? appUserGroupName) {
    _appUserGroupName = appUserGroupName;
  }

  DesignationBase.fromMap(Map<String, dynamic> map)
      : _designationID = map['DesignationID'],
        _designationCode = map['DesignationCode'],
        _designationName = map['DesignationName'],
        _createdOn = map['CreatedOn'],
        _createdBy = map['CreatedBy'],
        _modifiedOn = map['ModifiedOn'],
        _modifiedBy = map['ModifiedBy'],
        _isActive = map['IsActive'],
        _uid = map['Uid'],
        _appUserID = map['AppUserID'],
        _appUserGroupID = map['AppUserGroupID'],
        _isArchived = map['IsArchived'],
        _isDeleted = map['IsDeleted'],
        _appUserName = map['AppUserName'],
        _appUserGroupName = map['AppUserGroupName'];

  Map<String, dynamic> toMap() {
    return {
      'DesignationID': _designationID,
      'DesignationCode': _designationCode,
      'DesignationName': _designationName,
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
