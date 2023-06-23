import 'package:happsales_crm/database/models/BaseEntity.dart';

class ChatUserAndGroupBase extends BaseEntity {
  String? _chatUserAndGroupID;
  String? _chatUserAndGroupCode;
  String? _chatUserAndGroupName;
  String? _chatUserAndGroupLogo;
  String? _chatUserAndGroupDescription;
  String? _phoneNumber;
  String? _email;
  String? _targetAppUserID;
  String? _isGroup;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _isArchived;
  String? _targetAppUserName;
  String? _appUserName;
  String? _appUserGroupName;


ChatUserAndGroupBase();
  String? get chatUserAndGroupID => _chatUserAndGroupID;
  set chatUserAndGroupID(String? value) {
    _chatUserAndGroupID = value;
  }

  String? get chatUserAndGroupCode => _chatUserAndGroupCode;
  set chatUserAndGroupCode(String? value) {
    _chatUserAndGroupCode = value;
  }

  String? get chatUserAndGroupName => _chatUserAndGroupName;
  set chatUserAndGroupName(String? value) {
    _chatUserAndGroupName = value;
  }

  String? get chatUserAndGroupLogo => _chatUserAndGroupLogo;
  set chatUserAndGroupLogo(String? value) {
    _chatUserAndGroupLogo = value;
  }

  String? get chatUserAndGroupDescription => _chatUserAndGroupDescription;
  set chatUserAndGroupDescription(String? value) {
    _chatUserAndGroupDescription = value;
  }

  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  String? get email => _email;
  set email(String? value) {
    _email = value;
  }

  String? get targetAppUserID => _targetAppUserID;
  set targetAppUserID(String? value) {
    _targetAppUserID = value;
  }

  String? get isGroup => _isGroup;
  set isGroup(String? value) {
    _isGroup = value;
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

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
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

  Map<String, dynamic> toMap() {
    return {
      'ChatUserAndGroupID': chatUserAndGroupID,
      'ChatUserAndGroupCode': chatUserAndGroupCode,
      'ChatUserAndGroupName': chatUserAndGroupName,
      'ChatUserAndGroupLogo': chatUserAndGroupLogo,
      'ChatUserAndGroupDescription': chatUserAndGroupDescription,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'TargetAppUserID': targetAppUserID,
      'IsGroup': isGroup,
      'CreatedBy': createdBy,
      'CreatedOn': createdOn,
      'ModifiedBy': modifiedBy,
      'ModifiedOn': modifiedOn,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsDeleted': isDeleted,
      'IsArchived': isArchived,
      'TargetAppUserName': targetAppUserName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   ChatUserAndGroupBase.fromMap(Map<String, dynamic> map) {
    _chatUserAndGroupID = map['ChatUserAndGroupID'];
    _chatUserAndGroupCode = map['ChatUserAndGroupCode'];
    _chatUserAndGroupName = map['ChatUserAndGroupName'];
    _chatUserAndGroupLogo = map['ChatUserAndGroupLogo'];
    _chatUserAndGroupDescription = map['ChatUserAndGroupDescription'];
    _phoneNumber = map['PhoneNumber'];
    _email = map['Email'];
    _targetAppUserID = map['TargetAppUserID'];
    _isGroup = map['IsGroup'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _isArchived = map['IsArchived'];
    _targetAppUserName = map['TargetAppUserName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
