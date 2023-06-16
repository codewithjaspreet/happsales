import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityTypeBase extends BaseEntity {
  String? _activityTypeID;
  String? _activityTypeCode;
  String? _activityTypeName;
  String? _businessFeatureID;
  String? _internalCode;
  String? _sequentialOrder;
  String? _isEndDateRequired;
  String? _isDurationRequired;
  String? _isOpportunityRequired;
  String? _isAccountMandatory;
  String? _isApprovalRequiredOnCompletion;
  String? _alertOnScheduleSlippage;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isActive;
  String? _isDeleted;
  String? _businessFeatureName;
  String? _appUserName;
  String? _appUserGroupName;

  ActivityTypeBase();

  String? get activityTypeID => _activityTypeID;
  set activityTypeID(String? value) {
    _activityTypeID = value;
  }

  String? get activityTypeCode => _activityTypeCode;
  set activityTypeCode(String? value) {
    _activityTypeCode = value;
  }

  String? get activityTypeName => _activityTypeName;
  set activityTypeName(String? value) {
    _activityTypeName = value;
  }

  String? get businessFeatureID => _businessFeatureID;
  set businessFeatureID(String? value) {
    _businessFeatureID = value;
  }

  String? get internalCode => _internalCode;
  set internalCode(String? value) {
    _internalCode = value;
  }

  String? get sequentialOrder => _sequentialOrder;
  set sequentialOrder(String? value) {
    _sequentialOrder = value;
  }

  String? get isEndDateRequired => _isEndDateRequired;
  set isEndDateRequired(String? value) {
    _isEndDateRequired = value;
  }

  String? get isDurationRequired => _isDurationRequired;
  set isDurationRequired(String? value) {
    _isDurationRequired = value;
  }

  String? get isOpportunityRequired => _isOpportunityRequired;
  set isOpportunityRequired(String? value) {
    _isOpportunityRequired = value;
  }

  String? get isAccountMandatory => _isAccountMandatory;
  set isAccountMandatory(String? value) {
    _isAccountMandatory = value;
  }

  String? get isApprovalRequiredOnCompletion => _isApprovalRequiredOnCompletion;
  set isApprovalRequiredOnCompletion(String? value) {
    _isApprovalRequiredOnCompletion = value;
  }

  String? get alertOnScheduleSlippage => _alertOnScheduleSlippage;
  set alertOnScheduleSlippage(String? value) {
    _alertOnScheduleSlippage = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get businessFeatureName => _businessFeatureName;
  set businessFeatureName(String? value) {
    _businessFeatureName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String?, dynamic> toMap() {
    return {
      'ActivityTypeID': _activityTypeID,
      'ActivityTypeCode': _activityTypeCode,
      'ActivityTypeName': _activityTypeName,
      'BusinessFeatureID': _businessFeatureID,
      'InternalCode': _internalCode,
      'SequentialOrder': _sequentialOrder,
      'IsEndDateRequired': _isEndDateRequired,
      'IsDurationRequired': _isDurationRequired,
      'IsOpportunityRequired': _isOpportunityRequired,
      'IsAccountMandatory': _isAccountMandatory,
      'IsApprovalRequiredOnCompletion': _isApprovalRequiredOnCompletion,
      'AlertOnScheduleSlippage': _alertOnScheduleSlippage,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsActive': _isActive,
      'IsDeleted': _isDeleted,
      'BusinessFeatureName': _businessFeatureName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  ActivityTypeBase.fromMap(Map<String?, dynamic> map) {
    _activityTypeID = map['ActivityTypeID'];
    _activityTypeCode = map['ActivityTypeCode'];
    _activityTypeName = map['ActivityTypeName'];
    _businessFeatureID = map['BusinessFeatureID'];
    _internalCode = map['InternalCode'];
    _sequentialOrder = map['SequentialOrder'];
    _isEndDateRequired = map['IsEndDateRequired'];
    _isDurationRequired = map['IsDurationRequired'];
    _isOpportunityRequired = map['IsOpportunityRequired'];
    _isAccountMandatory = map['IsAccountMandatory'];
    _isApprovalRequiredOnCompletion = map['IsApprovalRequiredOnCompletion'];
    _alertOnScheduleSlippage = map['AlertOnScheduleSlippage'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isActive = map['IsActive'];
    _isDeleted = map['IsDeleted'];
    _businessFeatureName = map['BusinessFeatureName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
