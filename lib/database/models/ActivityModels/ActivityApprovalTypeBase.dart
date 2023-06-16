import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityApprovalTypeBase extends BaseEntity {
  String? _activityApprovalTypeID;
  String? _activityApprovalTypeCode;
  String? _activityApprovalTypeName;
  String? _description;
  String? _activityTypeID;
  String? _internalCode;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _activityTypeName;
  String? _appUserName;
  String? _appUserGroupName;

  ActivityApprovalTypeBase();

  String? get activityApprovalTypeID => _activityApprovalTypeID;
  set activityApprovalTypeID(String? value) => _activityApprovalTypeID = value;

  String? get activityApprovalTypeCode => _activityApprovalTypeCode;
  set activityApprovalTypeCode(String? value) => _activityApprovalTypeCode = value;

  String? get activityApprovalTypeName => _activityApprovalTypeName;
  set activityApprovalTypeName(String? value) => _activityApprovalTypeName = value;

  String? get description => _description;
  set description(String? value) => _description = value;

  String? get activityTypeID => _activityTypeID;
  set activityTypeID(String? value) => _activityTypeID = value;

  String? get internalCode => _internalCode;
  set internalCode(String? value) => _internalCode = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

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

  String? get activityTypeName => _activityTypeName;
  set activityTypeName(String? value) => _activityTypeName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ActivityApprovalTypeID'] = _activityApprovalTypeID;
    data['ActivityApprovalTypeCode'] = _activityApprovalTypeCode;
    data['ActivityApprovalTypeName'] = _activityApprovalTypeName;
    data['Description'] = _description;
    data['ActivityTypeID'] = _activityTypeID;
    data['InternalCode'] = _internalCode;
    data['CreatedOn'] = _createdOn;
    data['CreatedBy'] = _createdBy;
    data['ModifiedOn'] = _modifiedOn;
    data['ModifiedBy'] = _modifiedBy;
    data['IsActive'] = _isActive;
    data['Uid'] = _uid;
    data['AppUserID'] = _appUserID;
    data['AppUserGroupID'] = _appUserGroupID;
    data['IsArchived'] = _isArchived;
    data['IsDeleted'] = _isDeleted;
    data['ActivityTypeName'] = _activityTypeName;
    data['AppUserName'] = _appUserName;
    data['AppUserGroupName'] = _appUserGroupName;
    return data;
  }

  ActivityApprovalTypeBase.fromMapObject(Map<String, dynamic> map) {
    _activityApprovalTypeID = map['ActivityApprovalTypeID'];
    _activityApprovalTypeCode = map['ActivityApprovalTypeCode'];
    _activityApprovalTypeName = map['ActivityApprovalTypeName'];
    _description = map['Description'];
    _activityTypeID = map['ActivityTypeID'];
    _internalCode = map['InternalCode'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _activityTypeName = map['ActivityTypeName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
