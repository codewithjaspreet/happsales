import 'package:happsales_crm/database/models/BaseEntity.dart';

class PerformanceSummaryBase extends BaseEntity {
  String? _performanceSummaryID;
  String? _performanceSummaryCode;
  String? _performanceSummaryName;
  String? _businessFeatureID;
  String? _performanceType;
  String? _activityTypeID;
  String? _financialYearID;
  String? _periodName;
  String? _startDate;
  String? _endDate;
  String? _target;
  String? _achievement;
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
  String? _activityTypeName;
  String? _financialYearName;
  String? _appUserName;
  String? _appUserGroupName;

  PerformanceSummaryBase();

  String? get performanceSummaryID => _performanceSummaryID;
  set performanceSummaryID(String? value) {
    _performanceSummaryID = value;
  }

  String? get performanceSummaryCode => _performanceSummaryCode;
  set performanceSummaryCode(String? value) {
    _performanceSummaryCode = value;
  }

  String? get performanceSummaryName => _performanceSummaryName;
  set performanceSummaryName(String? value) {
    _performanceSummaryName = value;
  }

  String? get businessFeatureID => _businessFeatureID;
  set businessFeatureID(String? value) {
    _businessFeatureID = value;
  }

  String? get performanceType => _performanceType;
  set performanceType(String? value) {
    _performanceType = value;
  }

  String? get activityTypeID => _activityTypeID;
  set activityTypeID(String? value) {
    _activityTypeID = value;
  }

  String? get financialYearID => _financialYearID;
  set financialYearID(String? value) {
    _financialYearID = value;
  }

  String? get periodName => _periodName;
  set periodName(String? value) {
    _periodName = value;
  }

  String? get startDate => _startDate;
  set startDate(String? value) {
    _startDate = value;
  }

  String? get endDate => _endDate;
  set endDate(String? value) {
    _endDate = value;
  }

  String? get target => _target;
  set target(String? value) {
    _target = value;
  }

  String? get achievement => _achievement;
  set achievement(String? value) {
    _achievement = value;
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

  String? get activityTypeName => _activityTypeName;
  set activityTypeName(String? value) {
    _activityTypeName = value;
  }

  String? get financialYearName => _financialYearName;
  set financialYearName(String? value) {
    _financialYearName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'PerformanceSummaryID': _performanceSummaryID,
      'PerformanceSummaryCode': _performanceSummaryCode,
      'PerformanceSummaryName': _performanceSummaryName,
      'BusinessFeatureID': _businessFeatureID,
      'PerformanceType': _performanceType,
      'ActivityTypeID': _activityTypeID,
      'FinancialYearID': _financialYearID,
      'PeriodName': _periodName,
      'StartDate': _startDate,
      'EndDate': _endDate,
      'Target': _target,
      'Achievement': _achievement,
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
      'ActivityTypeName': _activityTypeName,
      'FinancialYearName': _financialYearName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  PerformanceSummaryBase.fromMapObject(Map<String, dynamic> map) {
    _performanceSummaryID = map['PerformanceSummaryID'];
    _performanceSummaryCode = map['PerformanceSummaryCode'];
    _performanceSummaryName = map['PerformanceSummaryName'];
    _businessFeatureID = map['BusinessFeatureID'];
    _performanceType = map['PerformanceType'];
    _activityTypeID = map['ActivityTypeID'];
    _financialYearID = map['FinancialYearID'];
    _periodName = map['PeriodName'];
    _startDate = map['StartDate'];
    _endDate = map['EndDate'];
    _target = map['Target'];
    _achievement = map['Achievement'];
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
    _activityTypeName = map['ActivityTypeName'];
    _financialYearName = map['FinancialYearName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
