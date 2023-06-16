import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityApprovalBase extends BaseEntity{
  String? _activityApprovalID;
  String? _activityApprovalCode;
  String? _activityApprovalTitle;
  String? _activityApprovalTypeID;
  String? _activityID;
  String? _requestDate;
  String? _requestDetail;
  String? _isSubmitted;
  String? _parentActivityApprovalID;
  String? _approvalStatus;
  String? _approvalByAppUserID;
  String? _approvalTime;
  String? _approverRemarks;
  String? _isApprovalCompleted;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _location;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _activityApprovalTypeName;
  String? _activityTitle;
  String? _parentActivityApprovalTitle;
  String? _appUserName;
  String? _appUserGroupName;


  ActivityApprovalBase();

  String? get activityApprovalID => _activityApprovalID;
  set activityApprovalID(String? value) => _activityApprovalID = value;

  String? get activityApprovalCode => _activityApprovalCode;
  set activityApprovalCode(String? value) => _activityApprovalCode = value;

  String? get activityApprovalTitle => _activityApprovalTitle;
  set activityApprovalTitle(String? value) => _activityApprovalTitle = value;

  String? get activityApprovalTypeID => _activityApprovalTypeID;
  set activityApprovalTypeID(String? value) => _activityApprovalTypeID = value;

  String? get activityID => _activityID;
  set activityID(String? value) => _activityID = value;

  String? get requestDate => _requestDate;
  set requestDate(String? value) => _requestDate = value;

  String? get requestDetail => _requestDetail;
  set requestDetail(String? value) => _requestDetail = value;

  String? get isSubmitted => _isSubmitted;
  set isSubmitted(String? value) => _isSubmitted = value;

  String? get parentActivityApprovalID => _parentActivityApprovalID;
  set parentActivityApprovalID(String? value) => _parentActivityApprovalID = value;

  String? get approvalStatus => _approvalStatus;
  set approvalStatus(String? value) => _approvalStatus = value;

  String? get approvalByAppUserID => _approvalByAppUserID;
  set approvalByAppUserID(String? value) => _approvalByAppUserID = value;

  String? get approvalTime => _approvalTime;
  set approvalTime(String? value) => _approvalTime = value;

  String? get approverRemarks => _approverRemarks;
  set approverRemarks(String? value) => _approverRemarks = value;

  String? get isApprovalCompleted => _isApprovalCompleted;
  set isApprovalCompleted(String? value) => _isApprovalCompleted = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get deviceIdentifier => _deviceIdentifier;
  set deviceIdentifier(String? value) => _deviceIdentifier = value;

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) => _referenceIdentifier = value;

  String? get location => _location;
  set location(String? value) => _location = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get activityApprovalTypeName => _activityApprovalTypeName;
  set activityApprovalTypeName(String? value) =>
      _activityApprovalTypeName = value;

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) => _activityTitle = value;

  String? get parentActivityApprovalTitle => _parentActivityApprovalTitle;
  set parentActivityApprovalTitle(String? value) =>
      _parentActivityApprovalTitle = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ActivityApprovalID'] = _activityApprovalID;
    data['ActivityApprovalCode'] = _activityApprovalCode;
    data['ActivityApprovalTitle'] = _activityApprovalTitle;
    data['ActivityApprovalTypeID'] = _activityApprovalTypeID;
    data['ActivityID'] = _activityID;
    data['RequestDate'] = _requestDate;
    data['RequestDetail'] = _requestDetail;
    data['IsSubmitted'] = _isSubmitted;
    data['ParentActivityApprovalID'] = _parentActivityApprovalID;
    data['ApprovalStatus'] = _approvalStatus;
    data['ApprovalByAppUserID'] = _approvalByAppUserID;
    data['ApprovalTime'] = _approvalTime;
    data['ApproverRemarks'] = _approverRemarks;
    data['IsApprovalCompleted'] = _isApprovalCompleted;
    data['CreatedBy'] = _createdBy;
    data['CreatedOn'] = _createdOn;
    data['ModifiedBy'] = _modifiedBy;
    data['ModifiedOn'] = _modifiedOn;
    data['DeviceIdentifier'] = _deviceIdentifier;
    data['ReferenceIdentifier'] = _referenceIdentifier;
    data['Location'] = _location;
    data['IsActive'] = _isActive;
    data['Uid'] = _uid;
    data['AppUserID'] = _appUserID;
    data['AppUserGroupID'] = _appUserGroupID;
    data['IsArchived'] = _isArchived;
    data['IsDeleted'] = _isDeleted;
    data['ActivityApprovalTypeName'] = _activityApprovalTypeName;
    data['ActivityTitle'] = _activityTitle;
    data['ParentActivityApprovalTitle'] = _parentActivityApprovalTitle;
    data['AppUserName'] = _appUserName;
    data['AppUserGroupName'] = _appUserGroupName;
    return data;
  }

   ActivityApprovalBase.fromMapObject(Map<String, dynamic> map) {
    _activityApprovalID = map['ActivityApprovalID'];
    _activityApprovalCode = map['ActivityApprovalCode'];
    _activityApprovalTitle = map['ActivityApprovalTitle'];
    _activityApprovalTypeID = map['ActivityApprovalTypeID'];
    _activityID = map['ActivityID'];
    _requestDate = map['RequestDate'];
    _requestDetail = map['RequestDetail'];
    _isSubmitted = map['IsSubmitted'];
    _parentActivityApprovalID = map['ParentActivityApprovalID'];
    _approvalStatus = map['ApprovalStatus'];
    _approvalByAppUserID = map['ApprovalByAppUserID'];
    _approvalTime = map['ApprovalTime'];
    _approverRemarks = map['ApproverRemarks'];
    _isApprovalCompleted = map['IsApprovalCompleted'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _location = map['Location'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _activityApprovalTypeName = map['ActivityApprovalTypeName'];
    _activityTitle = map['ActivityTitle'];
    _parentActivityApprovalTitle = map['ParentActivityApprovalTitle'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
