import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountFormBase extends BaseEntity {
  String? _accountFormID;
  String? _accountFormCode;
  String? _accountFormTitle;
  String? _formID;
  String? _accountID;
  String? _contactID;
  String? _activityID;
  String? _opportunityID;
  String? _fileName;
  String? _fileUrl;
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
  String? _formName;
  String? _accountName;
  String? _activityTitle;
  String? _opportunityName;
  String? _appUserName;
  String? _appUserGroupName;

  AccountFormBase();

  String? get accountFormID => _accountFormID;
  set accountFormID(String? value) {
    _accountFormID = value;
  }

  String? get accountFormCode => _accountFormCode;
  set accountFormCode(String? value) {
    _accountFormCode = value;
  }

  String? get accountFormTitle => _accountFormTitle;
  set accountFormTitle(String? value) {
    _accountFormTitle = value;
  }

  String? get formID => _formID;
  set formID(String? value) {
    _formID = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get contactID => _contactID;
  set contactID(String? value) {
    _contactID = value;
  }

  String? get activityID => _activityID;
  set activityID(String? value) {
    _activityID = value;
  }

  String? get opportunityID => _opportunityID;
  set opportunityID(String? value) {
    _opportunityID = value;
  }

  String? get fileName => _fileName;
  set fileName(String? value) {
    _fileName = value;
  }

  String? get fileUrl => _fileUrl;
  set fileUrl(String? value) {
    _fileUrl = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
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

  String? get formName => _formName;
  set formName(String? value) {
    _formName = value;
  }

  String? get accountName => _accountName;
  set accountName(String? value) {
    _accountName = value;
  }

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) {
    _activityTitle = value;
  }

  String? get opportunityName => _opportunityName;
  set opportunityName(String? value) {
    _opportunityName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  AccountFormBase.fromMapObject(Map<String, dynamic> map) {
    _accountFormID = map['AccountFormID'];
    _accountFormCode = map['AccountFormCode'];
    _accountFormTitle = map['AccountFormTitle'];
    _formID = map['FormID'];
    _accountID = map['AccountID'];
    _contactID = map['ContactID'];
    _activityID = map['ActivityID'];
    _opportunityID = map['OpportunityID'];
    _fileName = map['FileName'];
    _fileUrl = map['FileUrl'];
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
    _formName = map['FormName'];
    _accountName = map['AccountName'];
    _activityTitle = map['ActivityTitle'];
    _opportunityName = map['OpportunityName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountFormID': _accountFormID,
      'AccountFormCode': _accountFormCode,
      'AccountFormTitle': _accountFormTitle,
      'FormID': _formID,
      'AccountID': _accountID,
      'ContactID': _contactID,
      'ActivityID': _activityID,
      'OpportunityID': _opportunityID,
      'FileName': _fileName,
      'FileUrl': _fileUrl,
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
      'FormName': _formName,
      'AccountName': _accountName,
      'ActivityTitle': _activityTitle,
      'OpportunityName': _opportunityName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
