import 'package:happsales_crm/database/models/BaseEntity.dart';

class ChatUserGroupMemberBase extends BaseEntity {
  String? _chatUserGroupMemberID;
  String? _chatUserGroupMemberCode;
  String? _chatUserAndGroupID;
  String? _targetAppUserID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isActive;
  String? _isDeleted;
  String? _chatUserAndGroupName;
  String? _targetAppUserName;
  String? _appUserName;
  String? _appUserGroupName;

  ChatUserGroupMemberBase();

  // Getters and Setters
  String? get chatUserGroupMemberID => _chatUserGroupMemberID;
  set chatUserGroupMemberID(String? value) {
    _chatUserGroupMemberID = value;
  }

  String? get chatUserGroupMemberCode => _chatUserGroupMemberCode;
  set chatUserGroupMemberCode(String? value) {
    _chatUserGroupMemberCode = value;
  }

  String? get chatUserAndGroupID => _chatUserAndGroupID;
  set chatUserAndGroupID(String? value) {
    _chatUserAndGroupID = value;
  }

  String? get targetAppUserID => _targetAppUserID;
  set targetAppUserID(String? value) {
    _targetAppUserID = value;
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

  String? get chatUserAndGroupName => _chatUserAndGroupName;
  set chatUserAndGroupName(String? value) {
    _chatUserAndGroupName = value;
  }

  String? get targetAppUserName => _targetAppUserName;
  set targetAppUserName(String? value) {
    _targetAppUserName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  // toMap function
  Map<String?, dynamic> toMap() {
    return {
      'ChatUserGroupMemberID': _chatUserGroupMemberID,
      'ChatUserGroupMemberCode': _chatUserGroupMemberCode,
      'ChatUserAndGroupID': _chatUserAndGroupID,
      'TargetAppUserID': _targetAppUserID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsActive': _isActive,
      'IsDeleted': _isDeleted,
      'ChatUserAndGroupName': _chatUserAndGroupName,
      'TargetAppUserName': _targetAppUserName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  // fromMapObject function
  ChatUserGroupMemberBase.fromMapObject(Map<String?, dynamic> map) {
    _chatUserGroupMemberID = map['ChatUserGroupMemberID'];
    _chatUserGroupMemberCode = map['ChatUserGroupMemberCode'];
    _chatUserAndGroupID = map['ChatUserAndGroupID'];
    _targetAppUserID = map['TargetAppUserID'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isActive = map['IsActive'];
    _isDeleted = map['IsDeleted'];
    _chatUserAndGroupName = map['ChatUserAndGroupName'];
    _targetAppUserName = map['TargetAppUserName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
