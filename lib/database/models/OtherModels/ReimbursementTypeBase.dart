import 'package:happsales_crm/database/models/BaseEntity.dart';

class ReimbursementTypeBase extends BaseEntity {
  String? _reimbursementTypeID;
  String? _reimbursementTypeCode;
  String? _reimbursementTypeName;
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

  ReimbursementTypeBase();

  String? get reimbursementTypeID => _reimbursementTypeID;
  set reimbursementTypeID(String? value) {
    _reimbursementTypeID = value;
  }

  String? get reimbursementTypeCode => _reimbursementTypeCode;
  set reimbursementTypeCode(String? value) {
    _reimbursementTypeCode = value;
  }

  String? get reimbursementTypeName => _reimbursementTypeName;
  set reimbursementTypeName(String? value) {
    _reimbursementTypeName = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'ReimbursementTypeID': _reimbursementTypeID,
      'ReimbursementTypeCode': _reimbursementTypeCode,
      'ReimbursementTypeName': _reimbursementTypeName,
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
    };
  }

  ReimbursementTypeBase.fromMapObject(Map<String, dynamic> map) {
    _reimbursementTypeID = map['ReimbursementTypeID'];
    _reimbursementTypeCode = map['ReimbursementTypeCode'];
    _reimbursementTypeName = map['ReimbursementTypeName'];
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

  }
}
