import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityMeasureBase extends BaseEntity {
  String? opportunityMeasureID;
  String? opportunityMeasureCode;
  String? opportunityMeasureName;
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

  OpportunityMeasureBase();

  OpportunityMeasureBase.fromMapObject(Map<String, dynamic> map) {
    opportunityMeasureID = map['OpportunityMeasureID'];
    opportunityMeasureCode = map['OpportunityMeasureCode'];
    opportunityMeasureName = map['OpportunityMeasureName'];
    internalCode = map['InternalCode'];
    isDefault = map['IsDefault'];
    sequentialOrder = map['SequentialOrder'];
    createdOn = map['CreatedOn'];
    createdBy = map['CreatedBy'];
    modifiedOn = map['ModifiedOn'];
    modifiedBy = map['ModifiedBy'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    isArchived = map['IsArchived'];
    isActive = map['IsActive'];
    isDeleted = map['IsDeleted'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityMeasureID => opportunityMeasureID;
  set setOpportunityMeasureID(String? value) =>
      opportunityMeasureID = value;

  String? get getOpportunityMeasureCode => opportunityMeasureCode;
  set setOpportunityMeasureCode(String? value) =>
      opportunityMeasureCode = value;

  String? get getOpportunityMeasureName => opportunityMeasureName;
  set setOpportunityMeasureName(String? value) =>
      opportunityMeasureName = value;

  String? get getInternalCode => internalCode;
  set setInternalCode(String? value) => internalCode = value;

  String? get getIsDefault => isDefault;
  set setIsDefault(String? value) => isDefault = value;

  String? get getSequentialOrder => sequentialOrder;
  set setSequentialOrder(String? value) => sequentialOrder = value;

  String? get getCreatedOn => createdOn;
  set setCreatedOn(String? value) => createdOn = value;

  String? get getCreatedBy => createdBy;
  set setCreatedBy(String? value) => createdBy = value;

  String? get getModifiedOn => modifiedOn;
  set setModifiedOn(String? value) => modifiedOn = value;

  String? get getModifiedBy => modifiedBy;
  set setModifiedBy(String? value) => modifiedBy = value;

  String? get getUid => uid;
  set setUid(String? value) => uid = value;

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) => appUserID = value;

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) => appUserGroupID = value;

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) => isArchived = value;

  String? get getIsActive => isActive;
  set setIsActive(String? value) => isActive = value;

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) => isDeleted = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityMeasureID': opportunityMeasureID,
      'OpportunityMeasureCode': opportunityMeasureCode,
      'OpportunityMeasureName': opportunityMeasureName,
      'InternalCode': internalCode,
      'IsDefault': isDefault,
      'SequentialOrder': sequentialOrder,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsActive': isActive,
      'IsDeleted': isDeleted,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
