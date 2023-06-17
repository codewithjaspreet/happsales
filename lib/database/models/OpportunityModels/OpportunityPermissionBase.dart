import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityPermissionBase extends BaseEntity {
  String? opportunityPermissionID;
  String? opportunityPermissionCode;
  String? opportunityID;
  String? appUserID;
  String? permissionLevel;
  String? createdOn;
  String? createdBy;
  String? modifiedOn;
  String? modifiedBy;
  String? isActive;
  String? uid;
  String? appUserGroupID;
  String? isArchived;
  String? isDeleted;
  String? opportunityName;
  String? appUserName;
  String? appUserGroupName;
OpportunityPermissionBase();
  OpportunityPermissionBase.fromMapObject(Map<String, dynamic> map) {
    opportunityPermissionID = map['OpportunityPermissionID'];
    opportunityPermissionCode = map['OpportunityPermissionCode'];
    opportunityID = map['OpportunityID'];
    appUserID = map['AppUserID'];
    permissionLevel = map['PermissionLevel'];
    createdOn = map['CreatedOn'];
    createdBy = map['CreatedBy'];
    modifiedOn = map['ModifiedOn'];
    modifiedBy = map['ModifiedBy'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserGroupID = map['AppUserGroupID'];
    isArchived = map['IsArchived'];
    isDeleted = map['IsDeleted'];
    opportunityName = map['OpportunityName'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityPermissionID => opportunityPermissionID;
  set setOpportunityPermissionID(String? value) => opportunityPermissionID = value;

  String? get getOpportunityPermissionCode => opportunityPermissionCode;
  set setOpportunityPermissionCode(String? value) => opportunityPermissionCode = value;

  String? get getOpportunityID => opportunityID;
  set setOpportunityID(String? value) => opportunityID = value;

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) => appUserID = value;

  String? get getPermissionLevel => permissionLevel;
  set setPermissionLevel(String? value) => permissionLevel = value;

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

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) => appUserGroupID = value;

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) => isArchived = value;

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) => isDeleted = value;

  String? get getOpportunityName => opportunityName;
  set setOpportunityName(String? value) => opportunityName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityPermissionID': opportunityPermissionID,
      'OpportunityPermissionCode': opportunityPermissionCode,
      'OpportunityID': opportunityID,
      'AppUserID': appUserID,
      'PermissionLevel': permissionLevel,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'OpportunityName': opportunityName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
