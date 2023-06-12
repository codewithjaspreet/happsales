import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountCompetitionActivityBase extends BaseEntity {
  String? _accountCompetitionActivityID;
  String? _accountCompetitionActivityCode;
  String? _competitionActivity;
  String? _accountID;
  String? _opportunityID;
  String? _competitorName;
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
  String? _opportunityName;
  String? _appUserName;
  String? _appUserGroupName;

  AccountCompetitionActivityBase();

  String? get accountCompetitionActivityID => _accountCompetitionActivityID;
  set accountCompetitionActivityID(String? value) {
    _accountCompetitionActivityID = value;
  }

  String? get accountCompetitionActivityCode => _accountCompetitionActivityCode;
  set accountCompetitionActivityCode(String? value) {
    _accountCompetitionActivityCode = value;
  }

  String? get competitionActivity => _competitionActivity;
  set competitionActivity(String? value) {
    _competitionActivity = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get opportunityID => _opportunityID;
  set opportunityID(String? value) {
    _opportunityID = value;
  }

  String? get competitorName => _competitorName;
  set competitorName(String? value) {
    _competitorName = value;
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

  AccountCompetitionActivityBase.fromMapObject(Map<String, dynamic> map) {
    _accountCompetitionActivityID = map['AccountCompetitionActivityID'];
    _accountCompetitionActivityCode = map['AccountCompetitionActivityCode'];
    _competitionActivity = map['CompetitionActivity'];
    _accountID = map['AccountID'];
    _opportunityID = map['OpportunityID'];
    _competitorName = map['CompetitorName'];
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
    _opportunityName = map['OpportunityName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountCompetitionActivityID': _accountCompetitionActivityID,
      'AccountCompetitionActivityCode': _accountCompetitionActivityCode,
      'CompetitionActivity': _competitionActivity,
      'AccountID': _accountID,
      'OpportunityID': _opportunityID,
      'CompetitorName': _competitorName,
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
      'OpportunityName': _opportunityName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
