import 'package:happsales_crm/database/models/BaseEntity.dart';

class ReminderBase extends BaseEntity {
  String? _reminderID;
  String? _reminderCode;
  String? _reminderTitle;
  String? _reminderDescription;
  String? _reminderDate;
  String? _reminderTime;
  String? _reminderRepeat;
  String? _repeatNumber;
  String? _repeatType;
  String? _active;
  String? _activityID;
  String? _opportunityID;
  String? _accountID;
  String? _isSetBySystem;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _activityTitle;
  String? _opportunityName;
  String? _accountName;
  String? _appUserName;
  String? _appUserGroupName;

  String? get reminderID => _reminderID;
  set reminderID(String? value) {
    _reminderID = value;
  }

  String? get reminderCode => _reminderCode;
  set reminderCode(String? value) {
    _reminderCode = value;
  }

  String? get reminderTitle => _reminderTitle;
  set reminderTitle(String? value) {
    _reminderTitle = value;
  }

  String? get reminderDescription => _reminderDescription;
  set reminderDescription(String? value) {
    _reminderDescription = value;
  }

  String? get reminderDate => _reminderDate;
  set reminderDate(String? value) {
    _reminderDate = value;
  }

  String? get reminderTime => _reminderTime;
  set reminderTime(String? value) {
    _reminderTime = value;
  }

  String? get reminderRepeat => _reminderRepeat;
  set reminderRepeat(String? value) {
    _reminderRepeat = value;
  }

  String? get repeatNumber => _repeatNumber;
  set repeatNumber(String? value) {
    _repeatNumber = value;
  }

  String? get repeatType => _repeatType;
  set repeatType(String? value) {
    _repeatType = value;
  }

  String? get active => _active;
  set active(String? value) {
    _active = value;
  }

  String? get activityID => _activityID;
  set activityID(String? value) {
    _activityID = value;
  }

  String? get opportunityID => _opportunityID;
  set opportunityID(String? value) {
    _opportunityID = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get isSetBySystem => _isSetBySystem;
  set isSetBySystem(String? value) {
    _isSetBySystem = value;
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

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) {
    _activityTitle = value;
  }

  String? get opportunityName => _opportunityName;
  set opportunityName(String? value) {
    _opportunityName = value;
  }

  String? get accountName => _accountName;
  set accountName(String? value) {
    _accountName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  ReminderBase();

  Map<String, dynamic> toMap() {
    return {
      'ReminderID': _reminderID,
      'ReminderCode': _reminderCode,
      'ReminderTitle': _reminderTitle,
      'ReminderDescription': _reminderDescription,
      'ReminderDate': _reminderDate,
      'ReminderTime': _reminderTime,
      'ReminderRepeat': _reminderRepeat,
      'RepeatNumber': _repeatNumber,
      'RepeatType': _repeatType,
      'Active': _active,
      'ActivityID': _activityID,
      'OpportunityID': _opportunityID,
      'AccountID': _accountID,
      'IsSetBySystem': _isSetBySystem,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
      'ActivityTitle': _activityTitle,
      'OpportunityName': _opportunityName,
      'AccountName': _accountName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  ReminderBase.fromMap(Map<String, dynamic> map) {
    _reminderID = map['ReminderID'];
    _reminderCode = map['ReminderCode'];
    _reminderTitle = map['ReminderTitle'];
    _reminderDescription = map['ReminderDescription'];
    _reminderDate = map['ReminderDate'];
    _reminderTime = map['ReminderTime'];
    _reminderRepeat = map['ReminderRepeat'];
    _repeatNumber = map['RepeatNumber'];
    _repeatType = map['RepeatType'];
    _active = map['Active'];
    _activityID = map['ActivityID'];
    _opportunityID = map['OpportunityID'];
    _accountID = map['AccountID'];
    _isSetBySystem = map['IsSetBySystem'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _activityTitle = map['ActivityTitle'];
    _opportunityName = map['OpportunityName'];
    _accountName = map['AccountName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
