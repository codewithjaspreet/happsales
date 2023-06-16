import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityTeamBase extends BaseEntity {
  String? _activityTeamID;
  String? _activityTeamCode;
  String? _activityID;
  String? _activityTeamAppUserID;
  String? _description;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserGroupID;
  String? _appUserID;
  String? _isArchived;
  String? _isDeleted;
  String? _activityTitle;
  String? _activityTeamAppUserName;
  String? _appUserGroupName;
  String? _appUserName;

  String? get activityTeamID => _activityTeamID;
  set activityTeamID(String? value) => _activityTeamID = value;

  String? get activityTeamCode => _activityTeamCode;
  set activityTeamCode(String? value) => _activityTeamCode = value;

  String? get activityID => _activityID;
  set activityID(String? value) => _activityID = value;

  String? get activityTeamAppUserID => _activityTeamAppUserID;
  set activityTeamAppUserID(String? value) => _activityTeamAppUserID = value;

  String? get description => _description;
  set description(String? value) => _description = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) => _activityTitle = value;

  String? get activityTeamAppUserName => _activityTeamAppUserName;
  set activityTeamAppUserName(String? value) => _activityTeamAppUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  ActivityTeamBase();

  ActivityTeamBase.fromMapObject(Map<String, dynamic> map) {
    _activityTeamID = map['ActivityTeamID'];
    _activityTeamCode = map['ActivityTeamCode'];
    _activityID = map['ActivityID'];
    _activityTeamAppUserID = map['ActivityTeamAppUserID'];
    _description = map['Description'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserGroupID = map['AppUserGroupID'];
    _appUserID = map['AppUserID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _activityTitle = map['ActivityTitle'];
    _activityTeamAppUserName = map['ActivityTeamAppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
    _appUserName = map['AppUserName'];
  }

  Map<String, dynamic> toMapObject() {
    return {
      'ActivityTeamID': _activityTeamID,
      'ActivityTeamCode': _activityTeamCode,
      'ActivityID': _activityID,
      'ActivityTeamAppUserID': _activityTeamAppUserID,
      'Description': _description,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserGroupID': _appUserGroupID,
      'AppUserID': _appUserID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'ActivityTitle': _activityTitle,
      'ActivityTeamAppUserName': _activityTeamAppUserName,
      'AppUserGroupName': _appUserGroupName,
      'AppUserName': _appUserName,
    };
  }
}
