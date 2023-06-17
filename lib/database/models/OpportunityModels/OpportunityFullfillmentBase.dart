import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityFulfillmentStatusBase extends BaseEntity {
  String? opportunityFulfillmentStatusID;
  String? opportunityFulfillmentStatusCode;
  String? opportunityFulfillmentStatusName;
  String? sequentialOrder;
  String? indicator;
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
  String? appUserName;
  String? appUserGroupName;

  OpportunityFulfillmentStatusBase();

  OpportunityFulfillmentStatusBase.fromMapObject(Map<String, dynamic> map) {
    opportunityFulfillmentStatusID = map['OpportunityFulfillmentStatusID'];
    opportunityFulfillmentStatusCode = map['OpportunityFulfillmentStatusCode'];
    opportunityFulfillmentStatusName = map['OpportunityFulfillmentStatusName'];
    sequentialOrder = map['SequentialOrder'];
    indicator = map['Indicator'];
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
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityFulfillmentStatusID =>
      opportunityFulfillmentStatusID;
  set setOpportunityFulfillmentStatusID(String? value) =>
      opportunityFulfillmentStatusID = value;

  String? get getOpportunityFulfillmentStatusCode =>
      opportunityFulfillmentStatusCode;
  set setOpportunityFulfillmentStatusCode(String? value) =>
      opportunityFulfillmentStatusCode = value;

  String? get getOpportunityFulfillmentStatusName =>
      opportunityFulfillmentStatusName;
  set setOpportunityFulfillmentStatusName(String? value) =>
      opportunityFulfillmentStatusName = value;

  String? get getSequentialOrder => sequentialOrder;
  set setSequentialOrder(String? value) => sequentialOrder = value;

  String? get getIndicator => indicator;
  set setIndicator(String? value) => indicator = value;

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

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityFulfillmentStatusID': opportunityFulfillmentStatusID,
      'OpportunityFulfillmentStatusCode': opportunityFulfillmentStatusCode,
      'OpportunityFulfillmentStatusName': opportunityFulfillmentStatusName,
      'SequentialOrder': sequentialOrder,
      'Indicator': indicator,
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
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
