class AccountSegmentBase {
  String? _accountSegmentID;
  String? _accountSegmentCode;
  String? _accountSegmentName;
  String? _minimumTurnover;
  String? _currencyID;
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
  String? _currencyName;
  String? _appUserName;
  String? _appUserGroupName;

  AccountSegmentBase();

  String? get accountSegmentID => _accountSegmentID;
  set accountSegmentID(String? value) {
    _accountSegmentID = value;
  }

  String? get accountSegmentCode => _accountSegmentCode;
  set accountSegmentCode(String? value) {
    _accountSegmentCode = value;
  }

  String? get accountSegmentName => _accountSegmentName;
  set accountSegmentName(String? value) {
    _accountSegmentName = value;
  }

  String? get minimumTurnover => _minimumTurnover;
  set minimumTurnover(String? value) {
    _minimumTurnover = value;
  }

  String? get currencyID => _currencyID;
  set currencyID(String? value) {
    _currencyID = value;
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

  String? get currencyName => _currencyName;
  set currencyName(String? value) {
    _currencyName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  void fromMapObject(Map<String, dynamic> map) {
    _accountSegmentID = map['AccountSegmentID'];
    _accountSegmentCode = map['AccountSegmentCode'];
    _accountSegmentName = map['AccountSegmentName'];
    _minimumTurnover = map['MinimumTurnover'];
    _currencyID = map['CurrencyID'];
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
    _currencyName = map['CurrencyName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountSegmentID': _accountSegmentID,
      'AccountSegmentCode': _accountSegmentCode,
      'AccountSegmentName': _accountSegmentName,
      'MinimumTurnover': _minimumTurnover,
      'CurrencyID': _currencyID,
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
      'CurrencyName': _currencyName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
