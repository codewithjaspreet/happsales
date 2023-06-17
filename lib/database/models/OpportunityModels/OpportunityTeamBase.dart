import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityTeamBase extends BaseEntity {
  String? opportunityTeamID;
  String? opportunityTeamCode;
  String? opportunityID;
  String? opportunityTeamAppUserID;
  String? description;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? isActive;
  String? uid;
  String? appUserGroupID;
  String? appUserID;
  String? isArchived;
  String? isDeleted;
  String? opportunityName;
  String? opportunityTeamAppUserName;
  String? appUserGroupName;
  String? appUserName;

  OpportunityTeamBase();

  String? get getOpportunityTeamID => opportunityTeamID;
  set setOpportunityTeamID(String? value) {
    opportunityTeamID = value;
  }

  String? get getOpportunityTeamCode => opportunityTeamCode;
  set setOpportunityTeamCode(String? value) {
    opportunityTeamCode = value;
  }

  String? get getOpportunityID => opportunityID;
  set setOpportunityID(String? value) {
    opportunityID = value;
  }

  String? get getOpportunityTeamAppUserID => opportunityTeamAppUserID;
  set setOpportunityTeamAppUserID(String? value) {
    opportunityTeamAppUserID = value;
  }

  String? get getDescription => description;
  set setDescription(String? value) {
    description = value;
  }

  String? get getCreatedBy => createdBy;
  set setCreatedBy(String? value) {
    createdBy = value;
  }

  String? get getCreatedOn => createdOn;
  set setCreatedOn(String? value) {
    createdOn = value;
  }

  String? get getModifiedBy => modifiedBy;
  set setModifiedBy(String? value) {
    modifiedBy = value;
  }

  String? get getModifiedOn => modifiedOn;
  set setModifiedOn(String? value) {
    modifiedOn = value;
  }

  String? get getIsActive => isActive;
  set setIsActive(String? value) {
    isActive = value;
  }

  String? get getUid => uid;
  set setUid(String? value) {
    uid = value;
  }

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) {
    appUserGroupID = value;
  }

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) {
    appUserID = value;
  }

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) {
    isArchived = value;
  }

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) {
    isDeleted = value;
  }

  String? get getOpportunityName => opportunityName;
  set setOpportunityName(String? value) {
    opportunityName = value;
  }

  String? get getOpportunityTeamAppUserName => opportunityTeamAppUserName;
  set setOpportunityTeamAppUserName(String? value) {
    opportunityTeamAppUserName = value;
  }

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) {
    appUserGroupName = value;
  }

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) {
    appUserName = value;
  }
}
