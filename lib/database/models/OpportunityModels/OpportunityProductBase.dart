import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityProductBase extends BaseEntity {
  String? opportunityProductID;
  String? opportunityProductCode;
  String? opportunityID;
  String? productID;
  String? price;
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
  String? productName;
  String? appUserName;
  String? appUserGroupName;

  OpportunityProductBase();

  OpportunityProductBase.fromMapObject(Map<String, dynamic> map) {
    opportunityProductID = map['OpportunityProductID'];
    opportunityProductCode = map['OpportunityProductCode'];
    opportunityID = map['OpportunityID'];
    productID = map['ProductID'];
    price = map['Price'];
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
    productName = map['ProductName'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityProductID => opportunityProductID;
  set setOpportunityProductID(String? value) =>
      opportunityProductID = value;

  String? get getOpportunityProductCode => opportunityProductCode;
  set setOpportunityProductCode(String? value) =>
      opportunityProductCode = value;

  String? get getOpportunityID => opportunityID;
  set setOpportunityID(String? value) => opportunityID = value;

  String? get getProductID => productID;
  set setProductID(String? value) => productID = value;

  String? get getPrice => price;
  set setPrice(String? value) => price = value;

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
  set setReferenceIdentifier(String? value) =>
      referenceIdentifier = value;

  String? get getOpportunityName => opportunityName;
  set setOpportunityName(String? value) =>
      opportunityName = value;

  String? get getProductName => productName;
  set setProductName(String? value) => productName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) =>
      appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityProductID': opportunityProductID,
      'OpportunityProductCode': opportunityProductCode,
      'OpportunityID': opportunityID,
      'ProductID': productID,
      'Price': price,
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
      'ProductName': productName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
