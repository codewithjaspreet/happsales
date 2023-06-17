import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityNameBase extends BaseEntity {
  String? opportunityNameID;
  String? opportunityNameCode;
  String? opportunityNameEntry;
  String? description;
  String? createdOn;
  String? createdBy;
  String? modifiedOn;
  String? modifiedBy;
  String? isActive;
  String? uid;
  String? appUserID;
  String? appUserGroupID;
  String? referenceIdentifier;
  String? appUserName;
  String? appUserGroupName;
OpportunityNameBase ();
  OpportunityNameBase.fromMapObject(Map<String, dynamic> map) {
    opportunityNameID = map['OpportunityNameID'];
    opportunityNameCode = map['OpportunityNameCode'];
    opportunityNameEntry = map['OpportunityNameEntry'];
    description = map['Description'];
    createdOn = map['CreatedOn'];
    createdBy = map['CreatedBy'];
    modifiedOn = map['ModifiedOn'];
    modifiedBy = map['ModifiedBy'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    referenceIdentifier = map['ReferenceIdentifier'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityNameID => opportunityNameID;
  set setOpportunityNameID(String? value) => opportunityNameID = value;

  String? get getOpportunityNameCode => opportunityNameCode;
  set setOpportunityNameCode(String? value) => opportunityNameCode = value;

  String? get getOpportunityNameEntry => opportunityNameEntry;
  set setOpportunityNameEntry(String? value) => opportunityNameEntry = value;

  String? get getDescription => description;
  set setDescription(String? value) => description = value;

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

  String? get getReferenceIdentifier => referenceIdentifier;
  set setReferenceIdentifier(String? value) => referenceIdentifier = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityNameID': opportunityNameID,
      'OpportunityNameCode': opportunityNameCode,
      'OpportunityNameEntry': opportunityNameEntry,
      'Description': description,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'ReferenceIdentifier': referenceIdentifier,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
