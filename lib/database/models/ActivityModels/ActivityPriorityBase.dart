import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityPriorityBase extends BaseEntity {
  String? _activityPriorityID;
  String? _activityPriorityCode;
  String? _activityPriorityName;
  String? _description;
  String? _isDefault;
  String? _priorityOrder;
  String? _alertOnScheduleSlippage;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  String? get activityPriorityID => _activityPriorityID;
  set activityPriorityID(String? value) => _activityPriorityID = value;

  String? get activityPriorityCode => _activityPriorityCode;
  set activityPriorityCode(String? value) => _activityPriorityCode = value;

  String? get activityPriorityName => _activityPriorityName;
  set activityPriorityName(String? value) => _activityPriorityName = value;

  String? get description => _description;
  set description(String? value) => _description = value;

  String? get isDefault => _isDefault;
  set isDefault(String? value) => _isDefault = value;

  String? get priorityOrder => _priorityOrder;
  set priorityOrder(String? value) => _priorityOrder = value;

  String? get alertOnScheduleSlippage => _alertOnScheduleSlippage;
  set alertOnScheduleSlippage(String? value) =>
      _alertOnScheduleSlippage = value;

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

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  ActivityPriorityBase();

  ActivityPriorityBase.fromMapObject(Map<String, dynamic> map) {
    _activityPriorityID = map['ActivityPriorityID'];
    _activityPriorityCode = map['ActivityPriorityCode'];
    _activityPriorityName = map['ActivityPriorityName'];
    _description = map['Description'];
    _isDefault = map['IsDefault'];
    _priorityOrder = map['PriorityOrder'];
    _alertOnScheduleSlippage = map['AlertOnScheduleSlippage'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityPriorityID': _activityPriorityID,
      'ActivityPriorityCode': _activityPriorityCode,
      'ActivityPriorityName': _activityPriorityName,
      'Description': _description,
      'IsDefault': _isDefault,
      'PriorityOrder': _priorityOrder,
      'AlertOnScheduleSlippage': _alertOnScheduleSlippage,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
