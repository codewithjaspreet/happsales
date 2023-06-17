import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityProductDetailBase extends BaseEntity {
  String? opportunityProductDetailID;
  String? opportunityProductDetailCode;
  String? opportunityProductID;
  String? attribute;
  String? price;
  String? quantity;
  String? amount;
  String? remarks;
  String? supplierAccountID;
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
  String? opportunityProductCode;
  String? supplierAccountName;
  String? appUserName;
  String? appUserGroupName;

  OpportunityProductDetailBase();

  

  String? get getOpportunityProductDetailID => opportunityProductDetailID;
  set setOpportunityProductDetailID(String? value) =>
      opportunityProductDetailID = value;

  String? get getOpportunityProductDetailCode =>
      opportunityProductDetailCode;
  set setOpportunityProductDetailCode(String? value) =>
      opportunityProductDetailCode = value;

  String? get getOpportunityProductID => opportunityProductID;
  set setOpportunityProductID(String? value) =>
      opportunityProductID = value;

  String? get getAttribute => attribute;
  set setAttribute(String? value) => attribute = value;

  String? get getPrice => price;
  set setPrice(String? value) => price = value;

  String? get getQuantity => quantity;
  set setQuantity(String? value) => quantity = value;

  String? get getAmount => amount;
  set setAmount(String? value) => amount = value;

  String? get getRemarks => remarks;
  set setRemarks(String? value) => remarks = value;

  String? get getSupplierAccountID => supplierAccountID;
  set setSupplierAccountID(String? value) => supplierAccountID = value;

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

  String? get getOpportunityProductCode => opportunityProductCode;
  set setOpportunityProductCode(String? value) =>
      opportunityProductCode = value;

  String? get getSupplierAccountName => supplierAccountName;
  set setSupplierAccountName(String? value) =>
      supplierAccountName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'opportunityProductDetailID': opportunityProductDetailID,
      'opportunityProductDetailCode': opportunityProductDetailCode,
      'opportunityProductID': opportunityProductID,
      'attribute': attribute,
      'price': price,
      'quantity': quantity,
      'amount': amount,
      'remarks': remarks,
      'supplierAccountID': supplierAccountID,
      'createdBy': createdBy,
      'createdOn': createdOn,
      'modifiedBy': modifiedBy,
      'modifiedOn': modifiedOn,
      'isActive': isActive,
      'uid': uid,
      'appUserID': appUserID,
      'appUserGroupID': appUserGroupID,
      'isArchived': isArchived,
      'isDeleted': isDeleted,
      'referenceIdentifier': referenceIdentifier,
      'opportunityProductCode': opportunityProductCode,
      'supplierAccountName': supplierAccountName,
      'appUserName': appUserName,
      'appUserGroupName': appUserGroupName,
    };
  }
}
