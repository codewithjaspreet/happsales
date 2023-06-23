import 'package:happsales_crm/database/models/BaseEntity.dart';

class CustomerMeetingBase extends BaseEntity {
  String? _customerMeetingID;
  String? _customerMeetingCode;
  String? _customerMeetingTitle;
  String? _activityID;
  String? _accountID;
  String? _contactID;
  String? _customerMeetingDate;
  String? _punchInTime;
  String? _punchOutTime;
  String? _punchInLocation;
  String? _punchOutLocation;
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

  String? _activityTitle;
  String? _accountName;
  String? _contactName;
  String? _appUserName;
  String? _appUserGroupName;

  CustomerMeetingBase();

  String? get customerMeetingID => _customerMeetingID;
  set customerMeetingID(String? value) {
    _customerMeetingID = value;
  }

  String? get customerMeetingCode => _customerMeetingCode;
  set customerMeetingCode(String? value) {
    _customerMeetingCode = value;
  }

  String? get customerMeetingTitle => _customerMeetingTitle;
  set customerMeetingTitle(String? value) {
    _customerMeetingTitle = value;
  }

  String? get activityID => _activityID;
  set activityID(String? value) {
    _activityID = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get contactID => _contactID;
  set contactID(String? value) {
    _contactID = value;
  }

  String? get customerMeetingDate => _customerMeetingDate;
  set customerMeetingDate(String? value) {
    _customerMeetingDate = value;
  }

  String? get punchInTime => _punchInTime;
  set punchInTime(String? value) {
    _punchInTime = value;
  }

  String? get punchOutTime => _punchOutTime;
  set punchOutTime(String? value) {
    _punchOutTime = value;
  }

  String? get punchInLocation => _punchInLocation;
  set punchInLocation(String? value) {
    _punchInLocation = value;
  }

  String? get punchOutLocation => _punchOutLocation;
  set punchOutLocation(String? value) {
    _punchOutLocation = value;
  }

  String? get remarks => _remarks;
  set remarks(String? value) {
    _remarks = value;
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

  String? get deviceIdentifier => _deviceIdentifier;
  set deviceIdentifier(String? value) {
    _deviceIdentifier = value;
  }

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) {
    _referenceIdentifier = value;
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

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) {
    _activityTitle = value;
  }

  String? get accountName => _accountName;
  set accountName(String? value) {
    _accountName = value;
  }

  String? get contactName => _contactName;
  set contactName(String? value) {
    _contactName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String?, dynamic> toMap() {
    return {
      'CustomerMeetingID': _customerMeetingID,
      'CustomerMeetingCode': _customerMeetingCode,
      'CustomerMeetingTitle': _customerMeetingTitle,
      'ActivityID': _activityID,
      'AccountID': _accountID,
      'ContactID': _contactID,
      'CustomerMeetingDate': _customerMeetingDate,
      'PunchInTime': _punchInTime,
      'PunchOutTime': _punchOutTime,
      'PunchInLocation': _punchInLocation,
      'PunchOutLocation': _punchOutLocation,
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
      'ActivityTitle': _activityTitle,
      'AccountName': _accountName,
      'ContactName': _contactName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

   CustomerMeetingBase.fromMapObject(Map<String?, dynamic> map) {

    _customerMeetingID = map['CustomerMeetingID'];
    _customerMeetingCode = map['CustomerMeetingCode'];
    _customerMeetingTitle = map['CustomerMeetingTitle'];
    _activityID = map['ActivityID'];
    _accountID = map['AccountID'];
    _contactID = map['ContactID'];
    _customerMeetingDate = map['CustomerMeetingDate'];
    _punchInTime = map['PunchInTime'];
    _punchOutTime = map['PunchOutTime'];
    _punchInLocation = map['PunchInLocation'];
    _punchOutLocation = map['PunchOutLocation'];
    _remarks = map['Remarks'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _activityTitle = map['ActivityTitle'];
    _accountName = map['AccountName'];
    _contactName = map['ContactName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
