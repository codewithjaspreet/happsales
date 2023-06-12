class AccountBusinessPlanBase {
  String? _accountBusinessPlanID;
  String? _accountBusinessPlanCode;
  String? _businessPlans;
  String? _accountID;
  String? _customerTargetDate;
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
  String? _appUserName;
  String? _appUserGroupName;

  

    AccountBusinessPlanBase();


  String? get accountBusinessPlanID => _accountBusinessPlanID;
  set accountBusinessPlanID(String? value) {
    _accountBusinessPlanID = value;
  }

  String? get accountBusinessPlanCode => _accountBusinessPlanCode;
  set accountBusinessPlanCode(String? value) {
    _accountBusinessPlanCode = value;
  }

  String? get businessPlans => _businessPlans;
  set businessPlans(String? value) {
    _businessPlans = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get customerTargetDate => _customerTargetDate;
  set customerTargetDate(String? value) {
    _customerTargetDate = value;
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
      'AccountBusinessPlanID': _accountBusinessPlanID,
      'AccountBusinessPlanCode': _accountBusinessPlanCode,
      'BusinessPlans': _businessPlans,
      'AccountID': _accountID,
      'CustomerTargetDate': _customerTargetDate,
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
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

   AccountBusinessPlanBase.fromMapObject(Map<String, dynamic> map) {
    _accountBusinessPlanID = map['AccountBusinessPlanID'];
    _accountBusinessPlanCode = map['AccountBusinessPlanCode'];
    _businessPlans = map['BusinessPlans'];
    _accountID = map['AccountID'];
    _customerTargetDate = map['CustomerTargetDate'];
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
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
