import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityBusinessUnitBase extends BaseEntity {
  String? opportunityBusinessUnitID;
  String? opportunityBusinessUnitCode;
  String? opportunityID;
  String? businessUnitID;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? isActive;
  String? uid;
  String? appUserID;
  String? appUserGroupID;
  String? referenceIdentifier;
  String? isDeleted;
  String? isArchived;
  String? opportunityName;
  String? businessUnitName;
  String? appUserName;
  String? appUserGroupName;
OpportunityBusinessUnitBase();
  OpportunityBusinessUnitBase.fromMapObject(Map<String, dynamic> map) {
    opportunityBusinessUnitID = map['OpportunityBusinessUnitID'];
    opportunityBusinessUnitCode = map['OpportunityBusinessUnitCode'];
    opportunityID = map['OpportunityID'];
    businessUnitID = map['BusinessUnitID'];
    createdBy = map['CreatedBy'];
    createdOn = map['CreatedOn'];
    modifiedBy = map['ModifiedBy'];
    modifiedOn = map['ModifiedOn'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    referenceIdentifier = map['ReferenceIdentifier'];
    isDeleted = map['IsDeleted'];
    isArchived = map['IsArchived'];
    opportunityName = map['OpportunityName'];
    businessUnitName = map['BusinessUnitName'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityBusinessUnitID => opportunityBusinessUnitID;
  set setOpportunityBusinessUnitID(String? value) =>
      opportunityBusinessUnitID = value;

  String? get getOpportunityBusinessUnitCode => opportunityBusinessUnitCode;
  set setOpportunityBusinessUnitCode(String? value) =>
      opportunityBusinessUnitCode = value;

  String? get getOpportunityID => opportunityID;
  set setOpportunityID(String? value) => opportunityID = value;

  String? get getBusinessUnitID => businessUnitID;
  set setBusinessUnitID(String? value) => businessUnitID = value;

  String? get getCreatedBy => createdBy;
  set setCreatedBy(String? value) => createdBy = value;

  String? get getCreatedOn => createdOn;
  set setCreatedOn(String? value) => createdOn = value;

  String? get getModifiedBy => modifiedBy;
  set setModifiedBy(String? value) => modifiedBy = value;

  String? get getModifiedOn => modifiedOn;
  set setModifiedOn(String? value) => modifiedOn = value;

  String? get getIsActive => isActive;
  set setIsActive(String? value) => isActive = value;

  String? get getUid => uid;
  set setUid(String? value) => uid = value;

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) => appUserID = value;

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) => appUserGroupID = value;

  String? get getReferenceIdentifier => referenceIdentifier;
  set setReferenceIdentifier(String? value) => referenceIdentifier = value;

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) => isDeleted = value;

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) => isArchived = value;

  String? get getOpportunityName => opportunityName;
  set setOpportunityName(String? value) => opportunityName = value;

  String? get getBusinessUnitName => businessUnitName;
  set setBusinessUnitName(String? value) => businessUnitName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityBusinessUnitID': opportunityBusinessUnitID,
      'OpportunityBusinessUnitCode': opportunityBusinessUnitCode,
      'OpportunityID': opportunityID,
      'BusinessUnitID': businessUnitID,
      'CreatedBy': createdBy,
      'CreatedOn': createdOn,
      'ModifiedBy': modifiedBy,
      'ModifiedOn': modifiedOn,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'ReferenceIdentifier': referenceIdentifier,
      'IsDeleted': isDeleted,
      'IsArchived': isArchived,
      'OpportunityName': opportunityName,
      'BusinessUnitName': businessUnitName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
