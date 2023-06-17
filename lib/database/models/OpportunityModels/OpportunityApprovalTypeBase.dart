import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityApprovalTypeBase extends BaseEntity {
  String? opportunityApprovalTypeID;
  String? opportunityApprovalTypeCode;
  String? opportunityApprovalTypeName;
  String? description;
  String? opportunityTypeID;
  String? internalCode;
  String? createdOn;
  String? createdBy;
  String? modifiedOn;
  String? modifiedBy;
  String? isActive;
  String? uid;
  String? appUserID;
  String? appUserGroupID;
  String? isArchived;
  String? isDeleted;
  String? opportunityTypeName;
  String? appUserName;
  String? appUserGroupName;
OpportunityApprovalTypeBase();
  OpportunityApprovalTypeBase.fromMapObject(Map<String, dynamic> map) {
    opportunityApprovalTypeID = map['OpportunityApprovalTypeID'];
    opportunityApprovalTypeCode = map['OpportunityApprovalTypeCode'];
    opportunityApprovalTypeName = map['OpportunityApprovalTypeName'];
    description = map['Description'];
    opportunityTypeID = map['OpportunityTypeID'];
    internalCode = map['InternalCode'];
    createdOn = map['CreatedOn'];
    createdBy = map['CreatedBy'];
    modifiedOn = map['ModifiedOn'];
    modifiedBy = map['ModifiedBy'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    isArchived = map['IsArchived'];
    isDeleted = map['IsDeleted'];
    opportunityTypeName = map['OpportunityTypeName'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityApprovalTypeID => opportunityApprovalTypeID;
  set setOpportunityApprovalTypeID(String? value) =>
      opportunityApprovalTypeID = value;

  String? get getOpportunityApprovalTypeCode => opportunityApprovalTypeCode;
  set setOpportunityApprovalTypeCode(String? value) =>
      opportunityApprovalTypeCode = value;

  String? get getOpportunityApprovalTypeName => opportunityApprovalTypeName;
  set setOpportunityApprovalTypeName(String? value) =>
      opportunityApprovalTypeName = value;

  String? get getDescription => description;
  set setDescription(String? value) => description = value;

  String? get getOpportunityTypeID => opportunityTypeID;
  set setOpportunityTypeID(String? value) => opportunityTypeID = value;

  String? get getInternalCode => internalCode;
  set setInternalCode(String? value) => internalCode = value;

  String? get getCreatedOn => createdOn;
  set setCreatedOn(String? value) => createdOn = value;

  String? get getCreatedBy => createdBy;
  set setCreatedBy(String? value) => createdBy = value;

  String? get getModifiedOn => modifiedOn;
  set setModifiedOn(String? value) => modifiedOn = value;

  String? get getModifiedBy => modifiedBy;
  set setModifiedBy(String? value) => modifiedBy = value;

  String? get getIsActive => isActive;
  set setIsActive(String? value) => isActive = value;

  String? get getUid => uid;
  set setUid(String? value) => uid = value;

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) => appUserID = value;

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) => appUserGroupID = value;

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) => isArchived = value;

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) => isDeleted = value;

  String? get getOpportunityTypeName => opportunityTypeName;
  set setOpportunityTypeName(String? value) => opportunityTypeName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityApprovalTypeID': opportunityApprovalTypeID,
      'OpportunityApprovalTypeCode': opportunityApprovalTypeCode,
      'OpportunityApprovalTypeName': opportunityApprovalTypeName,
      'Description': description,
      'OpportunityTypeID': opportunityTypeID,
      'InternalCode': internalCode,
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
      'OpportunityTypeName': opportunityTypeName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
