import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityProductDetailAttributeBase extends BaseEntity {
  String? opportunityProductDetailAttributeID;
  String? opportunityProductDetailAttributeCode;
  String? opportunityProductDetailID;
  String? attributeID;
  String? attributeValueID;
  String? attributeValue;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? isActive;
  String? uid;
  String? referenceIdentifier;
  String? appUserID;
  String? appUserGroupID;
  String? isArchived;
  String? isDeleted;
  String? opportunityProductDetailCode;
  String? attributeName;
  String? attributeValueName;
  String? appUserName;
  String? appUserGroupName;

  OpportunityProductDetailAttributeBase();


  String? get getOpportunityProductDetailAttributeID =>
      opportunityProductDetailAttributeID;
  set setOpportunityProductDetailAttributeID(String? value) =>
      opportunityProductDetailAttributeID = value;

  String? get getOpportunityProductDetailAttributeCode =>
      opportunityProductDetailAttributeCode;
  set setOpportunityProductDetailAttributeCode(String? value) =>
      opportunityProductDetailAttributeCode = value;

  String? get getOpportunityProductDetailID => opportunityProductDetailID;
  set setOpportunityProductDetailID(String? value) =>
      opportunityProductDetailID = value;

  String? get getAttributeID => attributeID;
  set setAttributeID(String? value) => attributeID = value;

  String? get getAttributeValueID => attributeValueID;
  set setAttributeValueID(String? value) => attributeValueID = value;

  String? get getAttributeValue => attributeValue;
  set setAttributeValue(String? value) => attributeValue = value;

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

  String? get getReferenceIdentifier => referenceIdentifier;
  set setReferenceIdentifier(String? value) => referenceIdentifier = value;

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) => appUserID = value;

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) => appUserGroupID = value;

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) => isArchived = value;

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) => isDeleted = value;

  String? get getOpportunityProductDetailCode =>
      opportunityProductDetailCode;
  set setOpportunityProductDetailCode(String? value) =>
      opportunityProductDetailCode = value;

  String? get getAttributeName => attributeName;
  set setAttributeName(String? value) => attributeName = value;

  String? get getAttributeValueName => attributeValueName;
  set setAttributeValueName(String? value) => attributeValueName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'opportunityProductDetailAttributeID': opportunityProductDetailAttributeID,
      'opportunityProductDetailAttributeCode': opportunityProductDetailAttributeCode,
      'opportunityProductDetailID': opportunityProductDetailID,
      'attributeID': attributeID,
      'attributeValueID': attributeValueID,
      'attributeValue': attributeValue,
      'createdBy': createdBy,
      'createdOn': createdOn,
      'modifiedBy': modifiedBy,
      'modifiedOn': modifiedOn,
      'isActive': isActive,
      'uid': uid,
      'referenceIdentifier': referenceIdentifier,
      'appUserID': appUserID,
      'appUserGroupID': appUserGroupID,
      'isArchived': isArchived,
      'isDeleted': isDeleted,
      'opportunityProductDetailCode': opportunityProductDetailCode,
      'attributeName': attributeName,
      'attributeValueName': attributeValueName,
      'appUserName': appUserName,
      'appUserGroupName': appUserGroupName,
    };
  }
}
