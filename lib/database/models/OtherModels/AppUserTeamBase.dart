import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUserTeamBase extends BaseEntity {
  String? _appUserTeamID;
  String? _appUserTeamCode;
  String? _appUserTeamName;
  String? _appUserTeamDescription;
  String? _teamLeadAppUserID;
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
  String? _teamLeadAppUserName;
  String? _appUserGroupName;
  String? _appUserName;

  AppUserTeamBase();

  String? get appUserTeamID => _appUserTeamID;
  set appUserTeamID(String? value) {
    _appUserTeamID = value;
  }

  String? get appUserTeamCode => _appUserTeamCode;
  set appUserTeamCode(String? value) {
    _appUserTeamCode = value;
  }

  String? get appUserTeamName => _appUserTeamName;
  set appUserTeamName(String? value) {
    _appUserTeamName = value;
  }

  String? get appUserTeamDescription => _appUserTeamDescription;
  set appUserTeamDescription(String? value) {
    _appUserTeamDescription = value;
  }

  String? get teamLeadAppUserID => _teamLeadAppUserID;
  set teamLeadAppUserID(String? value) {
    _teamLeadAppUserID = value;
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

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get teamLeadAppUserName => _teamLeadAppUserName;
  set teamLeadAppUserName(String? value) {
    _teamLeadAppUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'appUserTeamID': _appUserTeamID,
      'appUserTeamCode': _appUserTeamCode,
      'appUserTeamName': _appUserTeamName,
      'appUserTeamDescription': _appUserTeamDescription,
      'teamLeadAppUserID': _teamLeadAppUserID,
      'createdBy': _createdBy,
      'createdOn': _createdOn,
      'modifiedBy': _modifiedBy,
      'modifiedOn': _modifiedOn,
      'isActive': _isActive,
      'uid': _uid,
      'appUserGroupID': _appUserGroupID,
      'appUserID': _appUserID,
      'isArchived': _isArchived,
      'isDeleted': _isDeleted,
      'teamLeadAppUserName': _teamLeadAppUserName,
      'appUserGroupName': _appUserGroupName,
      'appUserName': _appUserName,
    };
  }

   AppUserTeamBase.fromMap(Map<String, dynamic> map) {
    _appUserTeamID = map['appUserTeamID'];
    _appUserTeamCode = map['appUserTeamCode'];
    _appUserTeamName = map['appUserTeamName'];
    _appUserTeamDescription = map['appUserTeamDescription'];
    _teamLeadAppUserID = map['teamLeadAppUserID'];
    _createdBy = map['createdBy'];
    _createdOn = map['createdOn'];
    _modifiedBy = map['modifiedBy'];
    _modifiedOn = map['modifiedOn'];
    _isActive = map['isActive'];
    _uid = map['uid'];
    _appUserGroupID = map['appUserGroupID'];
    _appUserID = map['appUserID'];
    _isArchived = map['isArchived'];
    _isDeleted = map['isDeleted'];
    _teamLeadAppUserName = map['teamLeadAppUserName'];
    _appUserGroupName = map['appUserGroupName'];
    _appUserName = map['appUserName'];

  }
}
