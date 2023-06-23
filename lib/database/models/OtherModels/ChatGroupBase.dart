import 'package:happsales_crm/database/models/BaseEntity.dart';

class ChatGroupBase extends BaseEntity {
  String? _chatGroupID;
  String? _chatGroupCode;
  String? _chatGroupName;
  String? _chatGroupLogo;
  String? _chatGroupDescription;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;

  String? _appUserName;
  String? _appUserGroupName;

  ChatGroupBase();

  // ChatGroupID
  String? get chatGroupID => _chatGroupID;
  set chatGroupID(String? value) {
    _chatGroupID = value;
  }

  // ChatGroupCode
  String? get chatGroupCode => _chatGroupCode;
  set chatGroupCode(String? value) {
    _chatGroupCode = value;
  }

  // ChatGroupName
  String? get chatGroupName => _chatGroupName;
  set chatGroupName(String? value) {
    _chatGroupName = value;
  }

  // ChatGroupLogo
  String? get chatGroupLogo => _chatGroupLogo;
  set chatGroupLogo(String? value) {
    _chatGroupLogo = value;
  }

  // ChatGroupDescription
  String? get chatGroupDescription => _chatGroupDescription;
  set chatGroupDescription(String? value) {
    _chatGroupDescription = value;
  }

  // CreatedBy
  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  // CreatedOn
  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  // ModifiedBy
  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  // ModifiedOn
  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  // IsActive
  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  // Uid
  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  // AppUserID
  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  // AppUserGroupID
  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  // IsDeleted
  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  // AppUserName
  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  // AppUserGroupName
  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'ChatGroupID': chatGroupID,
      'ChatGroupCode': chatGroupCode,
      'ChatGroupName': chatGroupName,
      'ChatGroupLogo': chatGroupLogo,
      'ChatGroupDescription': chatGroupDescription,
      'CreatedBy': createdBy,
      'CreatedOn': createdOn,
      'ModifiedBy': modifiedBy,
      'ModifiedOn': modifiedOn,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsDeleted': isDeleted,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   ChatGroupBase.fromMap(Map<String, dynamic> map) {
    _chatGroupID = map['ChatGroupID'];
    _chatGroupCode = map['ChatGroupCode'];
    _chatGroupName = map['ChatGroupName'];
    _chatGroupLogo = map['ChatGroupLogo'];
    _chatGroupDescription = map['ChatGroupDescription'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
