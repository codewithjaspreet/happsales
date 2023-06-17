import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityStatusBase extends BaseEntity {
  String? opportunityStatusID;
  String? opportunityStatusCode;
  String? opportunityStatusName;
  String? sequentialOrder;
  String? probability;
  String? indicator;
  String? internalCode;
  String? workflowStageID;
  String? alertMessage;
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
  String? workflowStageName;
  String? appUserName;
  String? appUserGroupName;

  OpportunityStatusBase();

  String? get getOpportunityStatusID => opportunityStatusID;
  set setOpportunityStatusID(String? value) {
    opportunityStatusID = value;
  }

  String? get getOpportunityStatusCode => opportunityStatusCode;
  set setOpportunityStatusCode(String? value) {
    opportunityStatusCode = value;
  }

  String? get getOpportunityStatusName => opportunityStatusName;
  set setOpportunityStatusName(String? value) {
    opportunityStatusName = value;
  }

  String? get getSequentialOrder => sequentialOrder;
  set setSequentialOrder(String? value) {
    sequentialOrder = value;
  }

  String? get getProbability => probability;
  set setProbability(String? value) {
    probability = value;
  }

  String? get getIndicator => indicator;
  set setIndicator(String? value) {
    indicator = value;
  }

  String? get getInternalCode => internalCode;
  set setInternalCode(String? value) {
    internalCode = value;
  }

  String? get getWorkflowStageID => workflowStageID;
  set setWorkflowStageID(String? value) {
    workflowStageID = value;
  }

  String? get getAlertMessage => alertMessage;
  set setAlertMessage(String? value) {
    alertMessage = value;
  }

  String? get getCreatedOn => createdOn;
  set setCreatedOn(String? value) {
    createdOn = value;
  }

  String? get getCreatedBy => createdBy;
  set setCreatedBy(String? value) {
    createdBy = value;
  }

  String? get getModifiedOn => modifiedOn;
  set setModifiedOn(String? value) {
    modifiedOn = value;
  }

  String? get getModifiedBy => modifiedBy;
  set setModifiedBy(String? value) {
    modifiedBy = value;
  }

  String? get getIsActive => isActive;
  set setIsActive(String? value) {
    isActive = value;
  }

  String? get getUid => uid;
  set setUid(String? value) {
    uid = value;
  }

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) {
    appUserID = value;
  }

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) {
    appUserGroupID = value;
  }

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) {
    isArchived = value;
  }

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) {
    isDeleted = value;
  }

  String? get getWorkflowStageName => workflowStageName;
  set setWorkflowStageName(String? value) {
    workflowStageName = value;
  }

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) {
    appUserName = value;
  }

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) {
    appUserGroupName = value;
  }
}
