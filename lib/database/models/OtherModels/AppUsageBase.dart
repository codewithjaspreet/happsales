import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUsageBase  extends BaseEntity{
  String? _appUsageID;
  String? _appUsageCode;
  String? _appUsageName;
  String? _usageCount;
  String? _operatingSystem;
  String? _operatingSystemVersion;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  String? get appUsageID => _appUsageID;
  set appUsageID(String? value) => _appUsageID = value;

  String? get appUsageCode => _appUsageCode;
  set appUsageCode(String? value) => _appUsageCode = value;

  String? get appUsageName => _appUsageName;
  set appUsageName(String? value) => _appUsageName = value;

  String? get usageCount => _usageCount;
  set usageCount(String? value) => _usageCount = value;

  String? get operatingSystem => _operatingSystem;
  set operatingSystem(String? value) => _operatingSystem = value;

  String? get operatingSystemVersion => _operatingSystemVersion;
  set operatingSystemVersion(String? value) => _operatingSystemVersion = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get deviceIdentifier => _deviceIdentifier;
  set deviceIdentifier(String? value) => _deviceIdentifier = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  AppUsageBase();

  AppUsageBase.fromMap(Map<String, dynamic> map) {
    _appUsageID = map['AppUsageID'];
    _appUsageCode = map['AppUsageCode'];
    _appUsageName = map['AppUsageName'];
    _usageCount = map['UsageCount'];
    _operatingSystem = map['OperatingSystem'];
    _operatingSystemVersion = map['OperatingSystemVersion'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['AppUsageID'] = _appUsageID;
    map['AppUsageCode'] = _appUsageCode;
    map['AppUsageName'] = _appUsageName;
    map['UsageCount'] = _usageCount;
    map['OperatingSystem'] = _operatingSystem;
    map['OperatingSystemVersion'] = _operatingSystemVersion;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ModifiedBy'] = _modifiedBy;
    map['ModifiedOn'] = _modifiedOn;
    map['DeviceIdentifier'] = _deviceIdentifier;
    map['Uid'] = _uid;
    map['AppUserID'] = _appUserID;
    map['AppUserGroupID'] = _appUserGroupID;
    map['IsDeleted'] = _isDeleted;
    map['AppUserName'] = _appUserName;
    map['AppUserGroupName'] = _appUserGroupName;
    return map;
  }
}
