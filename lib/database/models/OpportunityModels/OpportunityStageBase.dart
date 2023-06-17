import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityStageBase extends BaseEntity {
  String? opportunityStageID;
  String? opportunityStageCode;
  String? opportunityStageName;
  String? description;
  String? sequentialOrder;
  String? isPipeline;
  String? probability;
  String? indicator;
  String? stagnantAlertDays;
  String? workflowStageID;
  String? alertMessage;
  String? opportunityStageType;
  String? actionOnSelection;
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
  String? workflowStageName;
  String? appUserName;
  String? appUserGroupName;

  
  String? get getOpportunityStageID => opportunityStageID;
  set setOpportunityStageID(String? value) => opportunityStageID = value;

  String? get getOpportunityStageCode => opportunityStageCode;
  set setOpportunityStageCode(String? value) => opportunityStageCode = value;

  String? get getOpportunityStageName => opportunityStageName;
  set setOpportunityStageName(String? value) => opportunityStageName = value;

  String? get getDescription => description;
  set setDescription(String? value) => description = value;

  String? get getSequentialOrder => sequentialOrder;
  set setSequentialOrder(String? value) => sequentialOrder = value;

  String? get getIsPipeline => isPipeline;
  set setIsPipeline(String? value) => isPipeline = value;

  String? get getProbability => probability;
  set setProbability(String? value) => probability = value;

  String? get getIndicator => indicator;
  set setIndicator(String? value) => indicator = value;

  String? get getStagnantAlertDays => stagnantAlertDays;
  set setStagnantAlertDays(String? value) => stagnantAlertDays = value;

  String? get getWorkflowStageID => workflowStageID;
  set setWorkflowStageID(String? value) => workflowStageID = value;

  String? get getAlertMessage => alertMessage;
  set setAlertMessage(String? value) => alertMessage = value;

  String? get getOpportunityStageType => opportunityStageType;
  set setOpportunityStageType(String? value) => opportunityStageType = value;

  String? get getActionOnSelection => actionOnSelection;
  set setActionOnSelection(String? value) => actionOnSelection = value;

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

  String? get getWorkflowStageName => workflowStageName;
  set setWorkflowStageName(String? value) => workflowStageName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'opportunityStageID': opportunityStageID,
      'opportunityStageCode': opportunityStageCode,
      'opportunityStageName': opportunityStageName,
      'description': description,
      'sequentialOrder': sequentialOrder,
      'isPipeline': isPipeline,
      'probability': probability,
      'indicator': indicator,
      'stagnantAlertDays': stagnantAlertDays,
      'workflowStageID': workflowStageID,
      'alertMessage': alertMessage,
      'opportunityStageType': opportunityStageType,
      'actionOnSelection': actionOnSelection,
      'internalCode': internalCode,
      'createdOn': createdOn,
      'createdBy': createdBy,
      'modifiedOn': modifiedOn,
      'modifiedBy': modifiedBy,
      'isActive': isActive,
      'uid': uid,
      'appUserID': appUserID,
      'appUserGroupID': appUserGroupID,
      'isArchived': isArchived,
      'isDeleted': isDeleted,
      'workflowStageName': workflowStageName,
      'appUserName': appUserName,
      'appUserGroupName': appUserGroupName,
    };
  }
}
