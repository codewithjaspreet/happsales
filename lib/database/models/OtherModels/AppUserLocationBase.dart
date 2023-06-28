import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUserLocationBase extends BaseEntity {
  String? _appUserLocationID;
  String? _appUserLocationCode;
  String? _appUserLocationTitle;
  String? _appUserLocationDate;
  String? _appUserLocationCoordinates;
  String? _appUserLocationAddress;
  String? _checkSum;
  String? _lastLocationCoordinates;
  String? _lastLocationAddress;
  String? _lastLocationTime;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _location;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  AppUserLocationBase();

  String? get appUserLocationID => _appUserLocationID;
  set appUserLocationID(String? value) => _appUserLocationID = value;

  String? get appUserLocationCode => _appUserLocationCode;
  set appUserLocationCode(String? value) => _appUserLocationCode = value;

  String? get appUserLocationTitle => _appUserLocationTitle;
  set appUserLocationTitle(String? value) => _appUserLocationTitle = value;

  String? get appUserLocationDate => _appUserLocationDate;
  set appUserLocationDate(String? value) => _appUserLocationDate = value;

  String? get appUserLocationCoordinates => _appUserLocationCoordinates;
  set appUserLocationCoordinates(String? value) =>
      _appUserLocationCoordinates = value;

  String? get appUserLocationAddress => _appUserLocationAddress;
  set appUserLocationAddress(String? value) => _appUserLocationAddress = value;

  String? get checkSum => _checkSum;
  set checkSum(String? value) => _checkSum = value;

  String? get lastLocationCoordinates => _lastLocationCoordinates;
  set lastLocationCoordinates(String? value) => _lastLocationCoordinates = value;

  String? get lastLocationAddress => _lastLocationAddress;
  set lastLocationAddress(String? value) => _lastLocationAddress = value;

  String? get lastLocationTime => _lastLocationTime;
  set lastLocationTime(String? value) => _lastLocationTime = value;

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

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) => _referenceIdentifier = value;

  String? get location => _location;
  set location(String? value) => _location = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

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

  AppUserLocationBase.fromMap(Map<String, dynamic> map) {
    _appUserLocationID = map['appUserLocationID'];
    _appUserLocationCode = map['appUserLocationCode'];
    _appUserLocationTitle = map['appUserLocationTitle'];
    _appUserLocationDate = map['appUserLocationDate'];
    _appUserLocationCoordinates = map['appUserLocationCoordinates'];
    _appUserLocationAddress = map['appUserLocationAddress'];
    _checkSum = map['checkSum'];
    _lastLocationCoordinates = map['lastLocationCoordinates'];
    _lastLocationAddress = map['lastLocationAddress'];
    _lastLocationTime = map['lastLocationTime'];
    _createdBy = map['createdBy'];
    _createdOn = map['createdOn'];
    _modifiedBy = map['modifiedBy'];
    _modifiedOn = map['modifiedOn'];
    _deviceIdentifier = map['deviceIdentifier'];
    _referenceIdentifier = map['referenceIdentifier'];
    _location = map['location'];
    _isActive = map['isActive'];
    _uid = map['uid'];
    _appUserID = map['appUserID'];
    _appUserGroupID = map['appUserGroupID'];
    _isArchived = map['isArchived'];
    _isDeleted = map['isDeleted'];
    _appUserName = map['appUserName'];
    _appUserGroupName = map['appUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'appUserLocationID': _appUserLocationID,
      'appUserLocationCode': _appUserLocationCode,
      'appUserLocationTitle': _appUserLocationTitle,
      'appUserLocationDate': _appUserLocationDate,
      'appUserLocationCoordinates': _appUserLocationCoordinates,
      'appUserLocationAddress': _appUserLocationAddress,
      'checkSum': _checkSum,
      'lastLocationCoordinates': _lastLocationCoordinates,
      'lastLocationAddress': _lastLocationAddress,
      'lastLocationTime': _lastLocationTime,
      'createdBy': _createdBy,
      'createdOn': _createdOn,
      'modifiedBy': _modifiedBy,
      'modifiedOn': _modifiedOn,
      'deviceIdentifier': _deviceIdentifier,
      'referenceIdentifier': _referenceIdentifier,
      'location': _location,
      'isActive': _isActive,
      'uid': _uid,
      'appUserID': _appUserID,
      'appUserGroupID': _appUserGroupID,
      'isArchived': _isArchived,
      'isDeleted': _isDeleted,
      'appUserName': _appUserName,
      'appUserGroupName': _appUserGroupName,
    };
  }
}
