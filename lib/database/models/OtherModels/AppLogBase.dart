import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppLogBase extends BaseEntity {
  String? _appLogID;
  String? _appLogCode;
  String? _appLogDetail;
  String? _operatingSystem;
  String? _operatingSystemVersion;
  String? _createdBy;
  String? _createdOn;
  String? _deviceIdentifier;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  String? get appLogID => _appLogID;
  set appLogID(String? value) => _appLogID = value;

  String? get appLogCode => _appLogCode;
  set appLogCode(String? value) => _appLogCode = value;

  String? get appLogDetail => _appLogDetail;
  set appLogDetail(String? value) => _appLogDetail = value;

  String? get operatingSystem => _operatingSystem;
  set operatingSystem(String? value) => _operatingSystem = value;

  String? get operatingSystemVersion => _operatingSystemVersion;
  set operatingSystemVersion(String? value) =>
      _operatingSystemVersion = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get deviceIdentifier => _deviceIdentifier;
  set deviceIdentifier(String? value) => _deviceIdentifier = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  AppLogBase();

  AppLogBase.fromMap(Map<String, dynamic> map) {

    _appLogID = map['AppLogID'];
    _appLogCode = map['AppLogCode'];
    _appLogDetail = map['AppLogDetail'];
    _operatingSystem = map['OperatingSystem'];
    _operatingSystemVersion = map['OperatingSystemVersion'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['AppLogID'] = _appLogID;
    map['AppLogCode'] = _appLogCode;
    map['AppLogDetail'] = _appLogDetail;
    map['OperatingSystem'] = _operatingSystem;
    map['OperatingSystemVersion'] = _operatingSystemVersion;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['DeviceIdentifier'] = _deviceIdentifier;
    map['Uid'] = _uid;
    map['AppUserID'] = _appUserID;
    map['AppUserGroupID'] = _appUserGroupID;
    map['IsArchived'] = _isArchived;
    map['IsDeleted'] = _isDeleted;
    map['AppUserName'] = _appUserName;
    map['AppUserGroupName'] = _appUserGroupName;
    return map;
  }
}
