import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityContactBase extends BaseEntity {
  String? opportunityContactID;
  String? opportunityContactCode;
  String? opportunityID;
  String? contactID;
  String? description;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? isActive;
  String? uid;
  String? appUserID;
  String? appUserGroupID;
  String? isArchived;
  String? isDeleted;
  String? referenceIdentifier;
  String? opportunityName;
  String? contactName;
  String? appUserName;
  String? appUserGroupName;
  String? firstName;

  OpportunityContactBase();

  OpportunityContactBase.fromMapObject(Map<String, dynamic> map) {
    opportunityContactID = map['OpportunityContactID'];
    opportunityContactCode = map['OpportunityContactCode'];
    opportunityID = map['OpportunityID'];
    contactID = map['ContactID'];
    description = map['Description'];
    createdBy = map['CreatedBy'];
    createdOn = map['CreatedOn'];
    modifiedBy = map['ModifiedBy'];
    modifiedOn = map['ModifiedOn'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    isArchived = map['IsArchived'];
    isDeleted = map['IsDeleted'];
    referenceIdentifier = map['ReferenceIdentifier'];
    opportunityName = map['OpportunityName'];
    contactName = map['ContactName'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
    firstName = map['FirstName'];
  }

  String? get getOpportunityContactID => opportunityContactID;
  set setOpportunityContactID(String? value) => opportunityContactID = value;

  String? get getOpportunityContactCode => opportunityContactCode;
  set setOpportunityContactCode(String? value) =>
      opportunityContactCode = value;

  String? get getOpportunityID => opportunityID;
  set setOpportunityID(String? value) => opportunityID = value;

  String? get getContactID => contactID;
  set setContactID(String? value) => contactID = value;

  String? get getDescription => description;
  set setDescription(String? value) => description = value;

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

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) => isArchived = value;

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) => isDeleted = value;

  String? get getReferenceIdentifier => referenceIdentifier;
  set setReferenceIdentifier(String? value) => referenceIdentifier = value;

  String? get getOpportunityName => opportunityName;
  set setOpportunityName(String? value) => opportunityName = value;

  String? get getContactName => contactName;
  set setContactName(String? value) => contactName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  String? get getFirstName => firstName;
  set setFirstName(String? value) => firstName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityContactID': opportunityContactID,
      'OpportunityContactCode': opportunityContactCode,
      'OpportunityID': opportunityID,
      'ContactID': contactID,
      'Description': description,
      'CreatedBy': createdBy,
      'CreatedOn': createdOn,
      'ModifiedBy': modifiedBy,
      'ModifiedOn': modifiedOn,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'ReferenceIdentifier': referenceIdentifier,
      'OpportunityName': opportunityName,
      'ContactName': contactName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
      'FirstName': firstName,
    };
  }
}
