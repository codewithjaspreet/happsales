import 'package:happsales_crm/database/models/BaseEntity.dart';

class ChatMessageBase extends BaseEntity {
  String? _chatMessageID;
  String? _chatMessageCode;
  String? _chatMessageContent;
  String? _contentType;
  String? _chatUserAndGroupID;
  String? _toChatUserAndGroupID;
  String? _localMediaPath;
  String? _isUploaded;
  String? _mediaPath;
  String? _isRead;
  String? _readStatus;
  String? _objectName;
  String? _objectID;
  String? _objectCode;
  String? _objectAction;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _isArchived;
  String? _toAppUserID;
  String? _toChatUserAndGroupUid;

  String? _chatUserAndGroupName;
  String? _toChatUserAndGroupName;
  String? _appUserName;
  String? _appUserGroupName;


ChatMessageBase();
  // ChatMessageID
  String? get chatMessageID => _chatMessageID;
  set chatMessageID(String? value) {
    _chatMessageID = value;
  }

  // ChatMessageCode
  String? get chatMessageCode => _chatMessageCode;
  set chatMessageCode(String? value) {
    _chatMessageCode = value;
  }

  // ChatMessageContent
  String? get chatMessageContent => _chatMessageContent;
  set chatMessageContent(String? value) {
    _chatMessageContent = value;
  }

  // ContentType
  String? get contentType => _contentType;
  set contentType(String? value) {
    _contentType = value;
  }

  // ChatUserAndGroupID
  String? get chatUserAndGroupID => _chatUserAndGroupID;
  set chatUserAndGroupID(String? value) {
    _chatUserAndGroupID = value;
  }

  // ToChatUserAndGroupID
  String? get toChatUserAndGroupID => _toChatUserAndGroupID;
  set toChatUserAndGroupID(String? value) {
    _toChatUserAndGroupID = value;
  }

  // LocalMediaPath
  String? get localMediaPath => _localMediaPath;
  set localMediaPath(String? value) {
    _localMediaPath = value;
  }

  // IsUploaded
  String? get isUploaded => _isUploaded;
  set isUploaded(String? value) {
    _isUploaded = value;
  }

  // MediaPath
  String? get mediaPath => _mediaPath;
  set mediaPath(String? value) {
    _mediaPath = value;
  }

  // IsRead
  String? get isRead => _isRead;
  set isRead(String? value) {
    _isRead = value;
  }

  // ReadStatus
  String? get readStatus => _readStatus;
  set readStatus(String? value) {
    _readStatus = value;
  }

  // ObjectName
  String? get objectName => _objectName;
  set objectName(String? value) {
    _objectName = value;
  }

  // ObjectID
  String? get objectID => _objectID;
  set objectID(String? value) {
    _objectID = value;
  }

  // ObjectCode
  String? get objectCode => _objectCode;
  set objectCode(String? value) {
    _objectCode = value;
  }

  // ObjectAction
  String? get objectAction => _objectAction;
  set objectAction(String? value) {
    _objectAction = value;
  }

  // CreatedOn
  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  // CreatedBy
  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  // ModifiedOn
  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  // ModifiedBy
  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
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

  // IsArchived
  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  // ToAppUserID
  String? get toAppUserID => _toAppUserID;
  set toAppUserID(String? value) {
    _toAppUserID = value;
  }

  // ToChatUserAndGroupUid
  String? get toChatUserAndGroupUid => _toChatUserAndGroupUid;
  set toChatUserAndGroupUid(String? value) {
    _toChatUserAndGroupUid = value;
  }

  // ChatUserAndGroupName
  String? get chatUserAndGroupName => _chatUserAndGroupName;
  set chatUserAndGroupName(String? value) {
    _chatUserAndGroupName = value;
  }

  // ToChatUserAndGroupName
  String? get toChatUserAndGroupName => _toChatUserAndGroupName;
  set toChatUserAndGroupName(String? value) {
    _toChatUserAndGroupName = value;
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
      'ChatMessageID': chatMessageID,
      'ChatMessageCode': chatMessageCode,
      'ChatMessageContent': chatMessageContent,
      'ContentType': contentType,
      'ChatUserAndGroupID': chatUserAndGroupID,
      'ToChatUserAndGroupID': toChatUserAndGroupID,
      'LocalMediaPath': localMediaPath,
      'IsUploaded': isUploaded,
      'MediaPath': mediaPath,
      'IsRead': isRead,
      'ReadStatus': readStatus,
      'ObjectName': objectName,
      'ObjectID': objectID,
      'ObjectCode': objectCode,
      'ObjectAction': objectAction,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsDeleted': isDeleted,
      'IsArchived': isArchived,
      'ToAppUserID': toAppUserID,
      'ToChatUserAndGroupUid': toChatUserAndGroupUid,
      'ChatUserAndGroupName': chatUserAndGroupName,
      'ToChatUserAndGroupName': toChatUserAndGroupName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   ChatMessageBase.fromMap(Map<String, dynamic> map) {
    _chatMessageID = map['ChatMessageID'];
    _chatMessageCode = map['ChatMessageCode'];
    _chatMessageContent = map['ChatMessageContent'];
    _contentType = map['ContentType'];
    _chatUserAndGroupID = map['ChatUserAndGroupID'];
    _toChatUserAndGroupID = map['ToChatUserAndGroupID'];
    _localMediaPath = map['LocalMediaPath'];
    _isUploaded = map['IsUploaded'];
    _mediaPath = map['MediaPath'];
    _isRead = map['IsRead'];
    _readStatus = map['ReadStatus'];
    _objectName = map['ObjectName'];
    _objectID = map['ObjectID'];
    _objectCode = map['ObjectCode'];
    _objectAction = map['ObjectAction'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _isArchived = map['IsArchived'];
    _toAppUserID = map['ToAppUserID'];
    _toChatUserAndGroupUid = map['ToChatUserAndGroupUid'];
    _chatUserAndGroupName = map['ChatUserAndGroupName'];
    _toChatUserAndGroupName = map['ToChatUserAndGroupName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
