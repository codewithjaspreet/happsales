import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUserMessageBase  extends BaseEntity{
  String? _appUserMessageID;
  String? _appUserMessageCode;
  String? _appUserMessageText;
  String? _objectType;
  String? _objectID;
  String? _isAttachment;
  String? _parentAppUserMessageID;
  String? _appUserMessageTo;
  String? _appUserMessageReadBy;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _referenceIdentifier;
  String? _parentAppUserMessageCode;
  String? _appUserName;
  String? _appUserGroupName;

  String? get appUserMessageID => _appUserMessageID;
  set appUserMessageID(String? value) => _appUserMessageID = value;

  String? get appUserMessageCode => _appUserMessageCode;
  set appUserMessageCode(String? value) => _appUserMessageCode = value;

  String? get appUserMessageText => _appUserMessageText;
  set appUserMessageText(String? value) => _appUserMessageText = value;

  String? get objectType => _objectType;
  set objectType(String? value) => _objectType = value;

  String? get objectID => _objectID;
  set objectID(String? value) => _objectID = value;

  String? get isAttachment => _isAttachment;
  set isAttachment(String? value) => _isAttachment = value;

  String? get parentAppUserMessageID => _parentAppUserMessageID;
  set parentAppUserMessageID(String? value) =>
      _parentAppUserMessageID = value;

  String? get appUserMessageTo => _appUserMessageTo;
  set appUserMessageTo(String? value) => _appUserMessageTo = value;

  String? get appUserMessageReadBy => _appUserMessageReadBy;
  set appUserMessageReadBy(String? value) => _appUserMessageReadBy = value;

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

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) => _referenceIdentifier = value;

  String? get parentAppUserMessageCode => _parentAppUserMessageCode;
  set parentAppUserMessageCode(String? value) =>
      _parentAppUserMessageCode = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  AppUserMessageBase();

  AppUserMessageBase.fromMap(Map<String, dynamic> map) {
    _appUserMessageID = map['appUserMessageID'];
    _appUserMessageCode = map['appUserMessageCode'];
    _appUserMessageText = map['appUserMessageText'];
    _objectType = map['objectType'];
    _objectID = map['objectID'];
    _isAttachment = map['isAttachment'];
    _parentAppUserMessageID = map['parentAppUserMessageID'];
    _appUserMessageTo = map['appUserMessageTo'];
    _appUserMessageReadBy = map['appUserMessageReadBy'];
    _createdBy = map['createdBy'];
    _createdOn = map['createdOn'];
    _modifiedBy = map['modifiedBy'];
    _modifiedOn = map['modifiedOn'];
    _isActive = map['isActive'];
    _uid = map['uid'];
    _appUserID = map['appUserID'];
    _appUserGroupID = map['appUserGroupID'];
    _isDeleted = map['isDeleted'];
    _referenceIdentifier = map['referenceIdentifier'];
    _parentAppUserMessageCode = map['parentAppUserMessageCode'];
    _appUserName = map['appUserName'];
    _appUserGroupName = map['appUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'appUserMessageID': _appUserMessageID,
      'appUserMessageCode': _appUserMessageCode,
      'appUserMessageText': _appUserMessageText,
      'objectType': _objectType,
      'objectID': _objectID,
      'isAttachment': _isAttachment,
      'parentAppUserMessageID': _parentAppUserMessageID,
      'appUserMessageTo': _appUserMessageTo,
      'appUserMessageReadBy': _appUserMessageReadBy,
      'createdBy': _createdBy,
      'createdOn': _createdOn,
      'modifiedBy': _modifiedBy,
      'modifiedOn': _modifiedOn,
      'isActive': _isActive,
      'uid': _uid,
      'appUserID': _appUserID,
      'appUserGroupID': _appUserGroupID,
      'isDeleted': _isDeleted,
      'referenceIdentifier': _referenceIdentifier,
      'parentAppUserMessageCode': _parentAppUserMessageCode,
      'appUserName': _appUserName,
      'appUserGroupName': _appUserGroupName,
    };
  }
}
