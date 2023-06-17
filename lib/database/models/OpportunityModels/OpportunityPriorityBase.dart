import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityPriorityBase extends BaseEntity {
  String? opportunityPriorityID;
  String? opportunityPriorityCode;
  String? opportunityPriorityName;
  String? description;
  String? isDefault;
  String? priorityOrder;
  String? createdOn;
  String? createdBy;
  String? modifiedOn;
  String? modifiedBy;
  String? isActive;
  String? uid;
  String? appUserID;
  String? appUserGroupID;
  String? isDeleted;
  String? appUserName;
  String? appUserGroupName;

  OpportunityPriorityBase();

  OpportunityPriorityBase.fromMapObject(Map<String, dynamic> map) {
    opportunityPriorityID = map['OpportunityPriorityID'];
    opportunityPriorityCode = map['OpportunityPriorityCode'];
    opportunityPriorityName = map['OpportunityPriorityName'];
    description = map['Description'];
    isDefault = map['IsDefault'];
    priorityOrder = map['PriorityOrder'];
    createdOn = map['CreatedOn'];
    createdBy = map['CreatedBy'];
    modifiedOn = map['ModifiedOn'];
    modifiedBy = map['ModifiedBy'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    isDeleted = map['IsDeleted'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityPriorityID => opportunityPriorityID;
  set setOpportunityPriorityID(String? value) => opportunityPriorityID = value;

  String? get getOpportunityPriorityCode => opportunityPriorityCode;
  set setOpportunityPriorityCode(String? value) =>
      opportunityPriorityCode = value;

  String? get getOpportunityPriorityName => opportunityPriorityName;
  set setOpportunityPriorityName(String? value) =>
      opportunityPriorityName = value;

  String? get getDescription => description;
  set setDescription(String? value) => description = value;

  String? get getIsDefault => isDefault;
  set setIsDefault(String? value) => isDefault = value;

  String? get getPriorityOrder => priorityOrder;
  set setPriorityOrder(String? value) => priorityOrder = value;

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

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) => isDeleted = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityPriorityID': opportunityPriorityID,
      'OpportunityPriorityCode': opportunityPriorityCode,
      'OpportunityPriorityName': opportunityPriorityName,
      'Description': description,
      'IsDefault': isDefault,
      'PriorityOrder': priorityOrder,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsDeleted': isDeleted,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
