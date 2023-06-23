import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUserTeamMemberBase extends BaseEntity {
  String? _appUserTeamMemberID;
  String? _appUserTeamMemberCode;
  String? _appUserTeamID;
  String? _appUserID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _uid;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isActive;
  String? _isDeleted;

  String? _appUserTeamName;
  String? _appUserName;
  String? _appUserGroupName;

  AppUserTeamMemberBase();

  // Getters
  String? get appUserTeamMemberID => _appUserTeamMemberID;
  String? get appUserTeamMemberCode => _appUserTeamMemberCode;
  String? get appUserTeamID => _appUserTeamID;
  String? get appUserID => _appUserID;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get modifiedBy => _modifiedBy;
  String? get modifiedOn => _modifiedOn;
  String? get uid => _uid;
  String? get appUserGroupID => _appUserGroupID;
  String? get isArchived => _isArchived;
  String? get isActive => _isActive;
  String? get isDeleted => _isDeleted;
  String? get appUserTeamName => _appUserTeamName;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;

  // Setters
  set appUserTeamMemberID(String? value) {
    _appUserTeamMemberID = value;
  }

  set appUserTeamMemberCode(String? value) {
    _appUserTeamMemberCode = value;
  }

  set appUserTeamID(String? value) {
    _appUserTeamID = value;
  }

  set appUserID(String? value) {
    _appUserID = value;
  }

  set createdBy(String? value) {
    _createdBy = value;
  }

  set createdOn(String? value) {
    _createdOn = value;
  }

  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  set uid(String? value) {
    _uid = value;
  }

  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  set isArchived(String? value) {
    _isArchived = value;
  }

  set isActive(String? value) {
    _isActive = value;
  }

  set isDeleted(String? value) {
    _isDeleted = value;
  }

  set appUserTeamName(String? value) {
    _appUserTeamName = value;
  }

  set appUserName(String? value) {
    _appUserName = value;
  }

  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String?, dynamic> toMap() {
    return {
      'AppUserTeamMemberID': _appUserTeamMemberID,
      'AppUserTeamMemberCode': _appUserTeamMemberCode,
      'AppUserTeamID': _appUserTeamID,
      'AppUserID': _appUserID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'Uid': _uid,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsActive': _isActive,
      'IsDeleted': _isDeleted,
      'AppUserTeamName': _appUserTeamName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

   

   //from map object function

    AppUserTeamMemberBase.fromMap(Map<String?, dynamic> map) {
      _appUserTeamMemberID = map['AppUserTeamMemberID'];
      _appUserTeamMemberCode = map['AppUserTeamMemberCode'];
      _appUserTeamID = map['AppUserTeamID'];
      _appUserID = map['AppUserID'];
      _createdBy = map['CreatedBy'];
      _createdOn = map['CreatedOn'];
      _modifiedBy = map['ModifiedBy'];
      _modifiedOn = map['ModifiedOn'];
      _uid = map['Uid'];
      _appUserGroupID = map['AppUserGroupID'];
      _isArchived = map['IsArchived'];
      _isActive = map['IsActive'];
      _isDeleted = map['IsDeleted'];
      _appUserTeamName = map['AppUserTeamName'];
      _appUserName = map['AppUserName'];
      _appUserGroupName = map['AppUserGroupName'];

    }
}
