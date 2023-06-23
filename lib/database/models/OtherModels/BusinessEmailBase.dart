import 'package:happsales_crm/database/models/BaseEntity.dart';

class BusinessEmailBase extends BaseEntity {
  String? _businessEmailID;
  String? _businessEmailCode;
  String? _businessEmailAddress;
  String? _purpose;
  String? _remarks;
  String? _isApproved;
  String? _hsRemarks;
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

  BusinessEmailBase();

  // BusinessEmailID
  String? get businessEmailID => _businessEmailID;
  set businessEmailID(String? value) {
    _businessEmailID = value;
  }

  // BusinessEmailCode
  String? get businessEmailCode => _businessEmailCode;
  set businessEmailCode(String? value) {
    _businessEmailCode = value;
  }

  // BusinessEmailAddress
  String? get businessEmailAddress => _businessEmailAddress;
  set businessEmailAddress(String? value) {
    _businessEmailAddress = value;
  }

  // Purpose
  String? get purpose => _purpose;
  set purpose(String? value) {
    _purpose = value;
  }

  // Remarks
  String? get remarks => _remarks;
  set remarks(String? value) {
    _remarks = value;
  }

  // IsApproved
  String? get isApproved => _isApproved;
  set isApproved(String? value) {
    _isApproved = value;
  }

  // HSRemarks
  String? get hsRemarks => _hsRemarks;
  set hsRemarks(String? value) {
    _hsRemarks = value;
  }

  // CreatedOn
  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  // CreatedBy
  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  // ModifiedOn
  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  // ModifiedBy
  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  // IsActive
  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  // Uid
  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  // AppUserID
  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  // AppUserGroupID
  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  // IsArchived
  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  // IsDeleted
  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  // AppUserName
  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  // AppUserGroupName
  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'BusinessEmailID': businessEmailID,
      'BusinessEmailCode': businessEmailCode,
      'BusinessEmailAddress': businessEmailAddress,
      'Purpose': purpose,
      'Remarks': remarks,
      'IsApproved': isApproved,
      'HSRemarks': hsRemarks,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   BusinessEmailBase.fromMap(Map<String, dynamic> map) {
    _businessEmailID = map['BusinessEmailID'];
    _businessEmailCode = map['BusinessEmailCode'];
    _businessEmailAddress = map['BusinessEmailAddress'];
    _purpose = map['Purpose'];
    _remarks = map['Remarks'];
    _isApproved = map['IsApproved'];
    _hsRemarks = map['HSRemarks'];
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
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
