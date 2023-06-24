import 'package:happsales_crm/database/Models/BaseEntity.dart';

class TimeZoneBase extends BaseEntity {
  String? _timeZoneID;
  String? _timeZoneCode;
  String? _timeZoneName;
  String? _gmtOffSet;
  String? _gmtOffSetInMinutes;
  String? _serverRelativeOffSet;
  String? _dstCorrection;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;


TimeZoneBase();
  String? get timeZoneID => _timeZoneID;
  set timeZoneID(String? timeZoneID) => _timeZoneID = timeZoneID;

  String? get timeZoneCode => _timeZoneCode;
  set timeZoneCode(String? timeZoneCode) => _timeZoneCode = timeZoneCode;

  String? get timeZoneName => _timeZoneName;
  set timeZoneName(String? timeZoneName) => _timeZoneName = timeZoneName;

  String? get gmtOffSet => _gmtOffSet;
  set gmtOffSet(String? gmtOffSet) => _gmtOffSet = gmtOffSet;

  String? get gmtOffSetInMinutes => _gmtOffSetInMinutes;
  set gmtOffSetInMinutes(String? gmtOffSetInMinutes) =>
      _gmtOffSetInMinutes = gmtOffSetInMinutes;

  String? get serverRelativeOffSet => _serverRelativeOffSet;
  set serverRelativeOffSet(String? serverRelativeOffSet) =>
      _serverRelativeOffSet = serverRelativeOffSet;

  String? get dstCorrection => _dstCorrection;
  set dstCorrection(String? dstCorrection) => _dstCorrection = dstCorrection;

  String? get createdOn => _createdOn;
  set createdOn(String? createdOn) => _createdOn = createdOn;

  String? get createdBy => _createdBy;
  set createdBy(String? createdBy) => _createdBy = createdBy;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? modifiedOn) => _modifiedOn = modifiedOn;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? modifiedBy) => _modifiedBy = modifiedBy;

  String? get isActive => _isActive;
  set isActive(String? isActive) => _isActive = isActive;

  String? get uid => _uid;
  set uid(String? uid) => _uid = uid;

  String? get appUserID => _appUserID;
  set appUserID(String? appUserID) => _appUserID = appUserID;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? appUserGroupID) =>
      _appUserGroupID = appUserGroupID;

  String? get isArchived => _isArchived;
  set isArchived(String? isArchived) => _isArchived = isArchived;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? isDeleted) => _isDeleted = isDeleted;

  String? get appUserName => _appUserName;
  set appUserName(String? appUserName) => _appUserName = appUserName;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? appUserGroupName) =>
      _appUserGroupName = appUserGroupName;

  Map<String, dynamic> toMap() {
    return {
      'TimeZoneID': _timeZoneID,
      'TimeZoneCode': _timeZoneCode,
      'TimeZoneName': _timeZoneName,
      'GMTOffSet': _gmtOffSet,
      'GMTOffSetInMinutes': _gmtOffSetInMinutes,
      'ServerRelativeOffSet': _serverRelativeOffSet,
      'DSTCorrection': _dstCorrection,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  // from map

  TimeZoneBase.fromMap(Map<String, dynamic> map) {
    _timeZoneID = map['TimeZoneID'];
    _timeZoneCode = map['TimeZoneCode'];
    _timeZoneName = map['TimeZoneName'];
    _gmtOffSet = map['GMTOffSet'];
    _gmtOffSetInMinutes = map['GMTOffSetInMinutes'];
    _serverRelativeOffSet = map['ServerRelativeOffSet'];
    _dstCorrection = map['DSTCorrection'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
