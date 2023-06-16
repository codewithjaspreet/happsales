import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityMeasureBase extends BaseEntity {
  String? _activityMeasureID;
  String? _activityMeasureCode;
  String? _activityMeasureName;
  String? _internalCode;
  String? _isDefault;
  String? _sequentialOrder;
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
  String? _appUserName;
  String? _appUserGroupName;

  ActivityMeasureBase();

  String? get activityMeasureID => _activityMeasureID;
  set activityMeasureID(String? value) => _activityMeasureID = value;

  String? get activityMeasureCode => _activityMeasureCode;
  set activityMeasureCode(String? value) => _activityMeasureCode = value;

  String? get activityMeasureName => _activityMeasureName;
  set activityMeasureName(String? value) => _activityMeasureName = value;

  String? get internalCode => _internalCode;
  set internalCode(String? value) => _internalCode = value;

  String? get isDefault => _isDefault;
  set isDefault(String? value) => _isDefault = value;

  String? get sequentialOrder => _sequentialOrder;
  set sequentialOrder(String? value) => _sequentialOrder = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  ActivityMeasureBase.fromMapObject(Map<String, dynamic> map) {
    _activityMeasureID = map['ActivityMeasureID'];
    _activityMeasureCode = map['ActivityMeasureCode'];
    _activityMeasureName = map['ActivityMeasureName'];
    _internalCode = map['InternalCode'];
    _isDefault = map['IsDefault'];
    _sequentialOrder = map['SequentialOrder'];
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
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityMeasureID': _activityMeasureID,
      'ActivityMeasureCode': _activityMeasureCode,
      'ActivityMeasureName': _activityMeasureName,
      'InternalCode': _internalCode,
      'IsDefault': _isDefault,
      'SequentialOrder': _sequentialOrder,
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
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
