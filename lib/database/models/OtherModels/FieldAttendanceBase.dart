import '../../Models/BaseEntity.dart';

class FieldAttendanceBase extends BaseEntity {
  String? _fieldAttendanceID;
  String? _fieldAttendanceCode;
  String? _fieldAttendanceTitle;
  String? _fieldAttendanceDate;
  String? _punchInTime;
  String? _punchOutTime;
  String? _punchInLocation;
  String? _userSpecifiedPunchInLocation;
  String? _punchOutLocation;
  String? _userSpecifiedPunchOutLocation;
  String? _remarks;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  String? get fieldAttendanceID => _fieldAttendanceID;
  String? get fieldAttendanceCode => _fieldAttendanceCode;
  String? get fieldAttendanceTitle => _fieldAttendanceTitle;
  String? get fieldAttendanceDate => _fieldAttendanceDate;
  String? get punchInTime => _punchInTime;
  String? get punchOutTime => _punchOutTime;
  String? get punchInLocation => _punchInLocation;
  String? get userSpecifiedPunchInLocation => _userSpecifiedPunchInLocation;
  String? get punchOutLocation => _punchOutLocation;
  String? get userSpecifiedPunchOutLocation => _userSpecifiedPunchOutLocation;
  String? get remarks => _remarks;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get modifiedBy => _modifiedBy;
  String? get modifiedOn => _modifiedOn;
  String? get deviceIdentifier => _deviceIdentifier;
  String? get referenceIdentifier => _referenceIdentifier;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get appUserID => _appUserID;
  String? get appUserGroupID => _appUserGroupID;
  String? get isArchived => _isArchived;
  String? get isDeleted => _isDeleted;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;

  FieldAttendanceBase();
   

  FieldAttendanceBase.fromMap(Map<String, dynamic> map)
      : _fieldAttendanceID = map['FieldAttendanceID'],
        _fieldAttendanceCode = map['FieldAttendanceCode'],
        _fieldAttendanceTitle = map['FieldAttendanceTitle'],
        _fieldAttendanceDate = map['FieldAttendanceDate'],
        _punchInTime = map['PunchInTime'],
        _punchOutTime = map['PunchOutTime'],
        _punchInLocation = map['PunchInLocation'],
        _userSpecifiedPunchInLocation = map['UserSpecifiedPunchInLocation'],
        _punchOutLocation = map['PunchOutLocation'],
        _userSpecifiedPunchOutLocation = map['UserSpecifiedPunchOutLocation'],
        _remarks = map['Remarks'],
        _createdBy = map['CreatedBy'],
        _createdOn = map['CreatedOn'],
        _modifiedBy = map['ModifiedBy'],
        _modifiedOn = map['ModifiedOn'],
        _deviceIdentifier = map['DeviceIdentifier'],
        _referenceIdentifier = map['ReferenceIdentifier'],
        _isActive = map['IsActive'],
        _uid = map['Uid'],
        _appUserID = map['AppUserID'],
        _appUserGroupID = map['AppUserGroupID'],
        _isArchived = map['IsArchived'],
        _isDeleted = map['IsDeleted'],
        _appUserName = map['AppUserName'],
        _appUserGroupName = map['AppUserGroupName'];

  Map<String, dynamic> toMap() {
    return {
      'FieldAttendanceID': _fieldAttendanceID,
      'FieldAttendanceCode': _fieldAttendanceCode,
      'FieldAttendanceTitle': _fieldAttendanceTitle,
      'FieldAttendanceDate': _fieldAttendanceDate,
      'PunchInTime': _punchInTime,
      'PunchOutTime': _punchOutTime,
      'PunchInLocation': _punchInLocation,
      'UserSpecifiedPunchInLocation': _userSpecifiedPunchInLocation,
      'PunchOutLocation': _punchOutLocation,
      'UserSpecifiedPunchOutLocation': _userSpecifiedPunchOutLocation,
      'Remarks': _remarks,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'DeviceIdentifier': _deviceIdentifier,
      'ReferenceIdentifier': _referenceIdentifier,
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
}
