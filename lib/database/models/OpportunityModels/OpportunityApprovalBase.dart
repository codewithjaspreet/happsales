import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityApprovalBase extends BaseEntity{
  String? opportunityApprovalID;
  String? opportunityApprovalCode;
  String? opportunityApprovalTitle;
  String? opportunityApprovalTypeID;
  String? opportunityID;
  String? requestDate;
  String? requestDetail;
  String? isSubmitted;
  String? parentOpportunityApprovalID;
  String? approvalStatus;
  String? approvalByAppUserID;
  String? approvalTime;
  String? approverRemarks;
  String? isApprovalCompleted;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? deviceIdentifier;
  String? referenceIdentifier;
  String? location;
  String? isActive;
  String? uid;
  String? appUserID;
  String? appUserGroupID;
  String? isArchived;
  String? isDeleted;
  String? opportunityApprovalTypeName;
  String? opportunityName;
  String? parentOpportunityApprovalTitle;
  String? appUserName;
  String? appUserGroupName;

  OpportunityApprovalBase();

  OpportunityApprovalBase.fromMapObject(Map<String, dynamic> map) {
    opportunityApprovalID = map['OpportunityApprovalID'];
    opportunityApprovalCode = map['OpportunityApprovalCode'];
    opportunityApprovalTitle = map['OpportunityApprovalTitle'];
    opportunityApprovalTypeID = map['OpportunityApprovalTypeID'];
    opportunityID = map['OpportunityID'];
    requestDate = map['RequestDate'];
    requestDetail = map['RequestDetail'];
    isSubmitted = map['IsSubmitted'];
    parentOpportunityApprovalID = map['ParentOpportunityApprovalID'];
    approvalStatus = map['ApprovalStatus'];
    approvalByAppUserID = map['ApprovalByAppUserID'];
    approvalTime = map['ApprovalTime'];
    approverRemarks = map['ApproverRemarks'];
    isApprovalCompleted = map['IsApprovalCompleted'];
    createdBy = map['CreatedBy'];
    createdOn = map['CreatedOn'];
    modifiedBy = map['ModifiedBy'];
    modifiedOn = map['ModifiedOn'];
    deviceIdentifier = map['DeviceIdentifier'];
    referenceIdentifier = map['ReferenceIdentifier'];
    location = map['Location'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    isArchived = map['IsArchived'];
    isDeleted = map['IsDeleted'];
    opportunityApprovalTypeName = map['OpportunityApprovalTypeName'];
    opportunityName = map['OpportunityName'];
    parentOpportunityApprovalTitle = map['ParentOpportunityApprovalTitle'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

   Map<String, dynamic> toMap() {
    return {
      'OpportunityApprovalID': opportunityApprovalID,
      'OpportunityApprovalCode': opportunityApprovalCode,
      'OpportunityApprovalTitle': opportunityApprovalTitle,
      'OpportunityApprovalTypeID': opportunityApprovalTypeID,
      'OpportunityID': opportunityID,
      'RequestDate': requestDate,
      'RequestDetail': requestDetail,
      'IsSubmitted': isSubmitted,
      'ParentOpportunityApprovalID': parentOpportunityApprovalID,
      'ApprovalStatus': approvalStatus,
      'ApprovalByAppUserID': approvalByAppUserID,
      'ApprovalTime': approvalTime,
      'ApproverRemarks': approverRemarks,
      'IsApprovalCompleted': isApprovalCompleted,
      'CreatedBy': createdBy,
      'CreatedOn': createdOn,
      'ModifiedBy': modifiedBy,
      'ModifiedOn': modifiedOn,
      'DeviceIdentifier': deviceIdentifier,
      'ReferenceIdentifier': referenceIdentifier,
      'Location': location,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'OpportunityApprovalTypeName': opportunityApprovalTypeName,
      'OpportunityName': opportunityName,
      'ParentOpportunityApprovalTitle': parentOpportunityApprovalTitle,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }


  String? get getOpportunityApprovalID => opportunityApprovalID;
  set setOpportunityApprovalID(String? value) =>
      opportunityApprovalID = value;

  String? get getOpportunityApprovalCode => opportunityApprovalCode;
  set setOpportunityApprovalCode(String? value) =>
      opportunityApprovalCode = value;

  String? get getOpportunityApprovalTitle => opportunityApprovalTitle;
  set setOpportunityApprovalTitle(String? value) =>
      opportunityApprovalTitle = value;

  String? get getOpportunityApprovalTypeID => opportunityApprovalTypeID;
  set setOpportunityApprovalTypeID(String? value) =>
      opportunityApprovalTypeID = value;

  String? get getOpportunityID => opportunityID;
  set setOpportunityID(String? value) => opportunityID = value;

  String? get getRequestDate => requestDate;
  set setRequestDate(String? value) => requestDate = value;

  String? get getRequestDetail => requestDetail;
  set setRequestDetail(String? value) => requestDetail = value;

  String? get getIsSubmitted => isSubmitted;
  set setIsSubmitted(String? value) => isSubmitted = value;

  String? get getParentOpportunityApprovalID => parentOpportunityApprovalID;
  set setParentOpportunityApprovalID(String? value) =>
      parentOpportunityApprovalID = value;

  String? get getApprovalStatus => approvalStatus;
  set setApprovalStatus(String? value) => approvalStatus = value;

  String? get getApprovalByAppUserID => approvalByAppUserID;
  set setApprovalByAppUserID(String? value) => approvalByAppUserID = value;

  String? get getApprovalTime => approvalTime;
  set setApprovalTime(String? value) => approvalTime = value;

  String? get getApproverRemarks => approverRemarks;
  set setApproverRemarks(String? value) => approverRemarks = value;

  String? get getIsApprovalCompleted => isApprovalCompleted;
  set setIsApprovalCompleted(String? value) => isApprovalCompleted = value;

  String? get getCreatedBy => createdBy;
  set setCreatedBy(String? value) => createdBy = value;

  String? get getCreatedOn => createdOn;
  set setCreatedOn(String? value) => createdOn = value;

  String? get getModifiedBy => modifiedBy;
  set setModifiedBy(String? value) => modifiedBy = value;

  String? get getModifiedOn => modifiedOn;
  set setModifiedOn(String? value) => modifiedOn = value;

  String? get getDeviceIdentifier => deviceIdentifier;
  set setDeviceIdentifier(String? value) => deviceIdentifier = value;

  String? get getReferenceIdentifier => referenceIdentifier;
  set setReferenceIdentifier(String? value) => referenceIdentifier = value;

  String? get getLocation => location;
  set setLocation(String? value) => location = value;

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

  String? get getOpportunityApprovalTypeName => opportunityApprovalTypeName;
  set setOpportunityApprovalTypeName(String? value) =>
      opportunityApprovalTypeName = value;

  String? get getOpportunityName => opportunityName;
  set setOpportunityName(String? value) => opportunityName = value;

  String? get getParentOpportunityApprovalTitle => parentOpportunityApprovalTitle;
  set setParentOpportunityApprovalTitle(String? value) =>
      parentOpportunityApprovalTitle = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;
}
