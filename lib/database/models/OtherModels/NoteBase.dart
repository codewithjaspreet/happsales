import 'package:happsales_crm/database/models/BaseEntity.dart';

class NoteBase extends BaseEntity {
  String? _noteID;
  String? _noteCode;
  String? _accountID;
  String? _contactID;
  String? _opportunityID;
  String? _activityID;
  String? _opportunityStageID;
  String? _isPersonal;
  String? _noteTitle;
  String? _noteDate;
  String? _noteContent;
  String? _tags;
  String? _freeTextField1;
  String? _freeTextField2;
  String? _freeTextField3;
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
  String? _accountName;
  String? _contactName;
  String? _opportunityName;
  String? _activityTitle;
  String? _opportunityStageName;
  String? _appUserName;
  String? _appUserGroupName;


NoteBase();
  String? get noteID => _noteID;
  set noteID(String? value) {
    _noteID = value;
  }

  String? get noteCode => _noteCode;
  set noteCode(String? value) {
    _noteCode = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get contactID => _contactID;
  set contactID(String? value) {
    _contactID = value;
  }

  String? get opportunityID => _opportunityID;
  set opportunityID(String? value) {
    _opportunityID = value;
  }

  String? get activityID => _activityID;
  set activityID(String? value) {
    _activityID = value;
  }

  String? get opportunityStageID => _opportunityStageID;
  set opportunityStageID(String? value) {
    _opportunityStageID = value;
  }

  String? get isPersonal => _isPersonal;
  set isPersonal(String? value) {
    _isPersonal = value;
  }

  String? get noteTitle => _noteTitle;
  set noteTitle(String? value) {
    _noteTitle = value;
  }

  String? get noteDate => _noteDate;
  set noteDate(String? value) {
    _noteDate = value;
  }

  String? get noteContent => _noteContent;
  set noteContent(String? value) {
    _noteContent = value;
  }

  String? get tags => _tags;
  set tags(String? value) {
    _tags = value;
  }

  String? get freeTextField1 => _freeTextField1;
  set freeTextField1(String? value) {
    _freeTextField1 = value;
  }

  String? get freeTextField2 => _freeTextField2;
  set freeTextField2(String? value) {
    _freeTextField2 = value;
  }

  String? get freeTextField3 => _freeTextField3;
  set freeTextField3(String? value) {
    _freeTextField3 = value;
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

  String? get accountName => _accountName;
  set accountName(String? value) {
    _accountName = value;
  }

  String? get contactName => _contactName;
  set contactName(String? value) {
    _contactName = value;
  }

  String? get opportunityName => _opportunityName;
  set opportunityName(String? value) {
    _opportunityName = value;
  }

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) {
    _activityTitle = value;
  }

  String? get opportunityStageName => _opportunityStageName;
  set opportunityStageName(String? value) {
    _opportunityStageName = value;
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
      'NoteID': _noteID,
      'NoteCode': _noteCode,
      'AccountID': _accountID,
      'ContactID': _contactID,
      'OpportunityID': _opportunityID,
      'ActivityID': _activityID,
      'OpportunityStageID': _opportunityStageID,
      'IsPersonal': _isPersonal,
      'NoteTitle': _noteTitle,
      'NoteDate': _noteDate,
      'NoteContent': _noteContent,
      'Tags': _tags,
      'FreeTextField1': _freeTextField1,
      'FreeTextField2': _freeTextField2,
      'FreeTextField3': _freeTextField3,
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
      'AccountName': _accountName,
      'ContactName': _contactName,
      'OpportunityName': _opportunityName,
      'ActivityTitle': _activityTitle,
      'OpportunityStageName': _opportunityStageName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  NoteBase.fromMapObject(Map<String, dynamic> map) {
    _noteID = map['NoteID'];
    _noteCode = map['NoteCode'];
    _accountID = map['AccountID'];
    _contactID = map['ContactID'];
    _opportunityID = map['OpportunityID'];
    _activityID = map['ActivityID'];
    _opportunityStageID = map['OpportunityStageID'];
    _isPersonal = map['IsPersonal'];
    _noteTitle = map['NoteTitle'];
    _noteDate = map['NoteDate'];
    _noteContent = map['NoteContent'];
    _tags = map['Tags'];
    _freeTextField1 = map['FreeTextField1'];
    _freeTextField2 = map['FreeTextField2'];
    _freeTextField3 = map['FreeTextField3'];
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
    _accountName = map['AccountName'];
    _contactName = map['ContactName'];
    _opportunityName = map['OpportunityName'];
    _activityTitle = map['ActivityTitle'];
    _opportunityStageName = map['OpportunityStageName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
