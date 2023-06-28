import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityTravelMappingBase extends BaseEntity {
  String? _activityTravelMappingID;
  String? _activityTravelMappingCode;
  String? _activityTravelID;
  String? _activityID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _activityTravelTitle;
  String? _activityTitle;
  String? _appUserName;
  String? _appUserGroupName;

  ActivityTravelMappingBase();

  String? get activityTravelMappingID => _activityTravelMappingID;
  set activityTravelMappingID(String? value) {
    _activityTravelMappingID = value;
  }

  String? get activityTravelMappingCode => _activityTravelMappingCode;
  set activityTravelMappingCode(String? value) {
    _activityTravelMappingCode = value;
  }

  String? get activityTravelID => _activityTravelID;
  set activityTravelID(String? value) {
    _activityTravelID = value;
  }

  String? get activityID => _activityID;
  set activityID(String? value) {
    _activityID = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
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

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get activityTravelTitle => _activityTravelTitle;
  set activityTravelTitle(String? value) {
    _activityTravelTitle = value;
  }

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) {
    _activityTitle = value;
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
      'ActivityTravelMappingID': _activityTravelMappingID,
      'ActivityTravelMappingCode': _activityTravelMappingCode,
      'ActivityTravelID': _activityTravelID,
      'ActivityID': _activityID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'ActivityTravelTitle': _activityTravelTitle,
      'ActivityTitle': _activityTitle,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  ActivityTravelMappingBase.fromMap(Map<String?, dynamic> map) {
    _activityTravelMappingID = map['ActivityTravelMappingID'];
    _activityTravelMappingCode = map['ActivityTravelMappingCode'];
    _activityTravelID = map['ActivityTravelID'];
    _activityID = map['ActivityID'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _activityTravelTitle = map['ActivityTravelTitle'];
    _activityTitle = map['ActivityTitle'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
