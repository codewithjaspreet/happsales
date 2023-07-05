import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityStageTypeBase extends BaseEntity {
  String? _opportunityStageTypeID;
  String? _opportunityStageTypeCode;
  String? _opportunityStageID;
  String? _opportunityTypeID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  String? get opportunityStageTypeID => _opportunityStageTypeID;
  set opportunityStageTypeID(String? value) {
    _opportunityStageTypeID = value;
  }

  String? get opportunityStageTypeCode => _opportunityStageTypeCode;
  set opportunityStageTypeCode(String? value) {
    _opportunityStageTypeCode = value;
  }

  String? get opportunityStageID => _opportunityStageID;
  set opportunityStageID(String? value) {
    _opportunityStageID = value;
  }

  String? get opportunityTypeID => _opportunityTypeID;
  set opportunityTypeID(String? value) {
    _opportunityTypeID = value;
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
}
