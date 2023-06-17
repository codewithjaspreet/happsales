import 'package:happsales_crm/database/Models/BaseEntity.dart';

class OpportunityTypeBase extends BaseEntity {
  String? opportunityTypeID;
  String? opportunityTypeCode;
  String? opportunityTypeName;
  String? internalCode;
  String? isDefault;
  String? sequentialOrder;
  String? createdOn;
  String? createdBy;
  String? modifiedOn;
  String? modifiedBy;
  String? uid;
  String? appUserID;
  String? appUserGroupID;
  String? isArchived;
  String? isActive;
  String? isDeleted;
  String? appUserName;
  String? appUserGroupName;

  OpportunityTypeBase();

  String? get getOpportunityTypeID => opportunityTypeID;
  set setOpportunityTypeID(String? value) {
    opportunityTypeID = value;
  }

  String? get getOpportunityTypeCode => opportunityTypeCode;
  set setOpportunityTypeCode(String? value) {
    opportunityTypeCode = value;
  }

  String? get getOpportunityTypeName => opportunityTypeName;
  set setOpportunityTypeName(String? value) {
    opportunityTypeName = value;
  }

  String? get getInternalCode => internalCode;
  set setInternalCode(String? value) {
    internalCode = value;
  }

  String? get getIsDefault => isDefault;
  set setIsDefault(String? value) {
    isDefault = value;
  }

  String? get getSequentialOrder => sequentialOrder;
  set setSequentialOrder(String? value) {
    sequentialOrder = value;
  }

  String? get getCreatedOn => createdOn;
  set setCreatedOn(String? value) {
    createdOn = value;
  }

  String? get getCreatedBy => createdBy;
  set setCreatedBy(String? value) {
    createdBy = value;
  }

  String? get getModifiedOn => modifiedOn;
  set setModifiedOn(String? value) {
    modifiedOn = value;
  }

  String? get getModifiedBy => modifiedBy;
  set setModifiedBy(String? value) {
    modifiedBy = value;
  }

  String? get getUid => uid;
  set setUid(String? value) {
    uid = value;
  }

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) {
    appUserID = value;
  }

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) {
    appUserGroupID = value;
  }

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) {
    isArchived = value;
  }

  String? get getIsActive => isActive;
  set setIsActive(String? value) {
    isActive = value;
  }

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) {
    isDeleted = value;
  }

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) {
    appUserName = value;
  }

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) {
    appUserGroupName = value;
  }
}
