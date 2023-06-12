class AccountPhoneBase {
  String? _accountPhoneID;
  String? _accountPhoneCode;
  String? _phone;
  String? _phoneTypeName;
  String? _accountID;
  String? _accountAddressID;
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
  String? _leadQualificationID;
  String? _accountName;
  String? _address;
  String? _appUserName;
  String? _appUserGroupName;

  AccountPhoneBase();

  String? get accountPhoneID => _accountPhoneID;
  set accountPhoneID(String? value) {
    _accountPhoneID = value;
  }

  String? get accountPhoneCode => _accountPhoneCode;
  set accountPhoneCode(String? value) {
    _accountPhoneCode = value;
  }

  String? get phone => _phone;
  set phone(String? value) {
    _phone = value;
  }

  String? get phoneTypeName => _phoneTypeName;
  set phoneTypeName(String? value) {
    _phoneTypeName = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get accountAddressID => _accountAddressID;
  set accountAddressID(String? value) {
    _accountAddressID = value;
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

  String? get leadQualificationID => _leadQualificationID;
  set leadQualificationID(String? value) {
    _leadQualificationID = value;
  }

  String? get accountName => _accountName;
  set accountName(String? value) {
    _accountName = value;
  }

  String? get address => _address;
  set address(String? value) {
    _address = value;
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
    _accountPhoneID = map['AccountPhoneID'];
    _accountPhoneCode = map['AccountPhoneCode'];
    _phone = map['Phone'];
    _phoneTypeName = map['PhoneTypeName'];
    _accountID = map['AccountID'];
    _accountAddressID = map['AccountAddressID'];
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
    _leadQualificationID = map['LeadQualificationID'];
    _accountName = map['AccountName'];
    _address = map['Address'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountPhoneID': _accountPhoneID,
      'AccountPhoneCode': _accountPhoneCode,
      'Phone': _phone,
      'PhoneTypeName': _phoneTypeName,
      'AccountID': _accountID,
      'AccountAddressID': _accountAddressID,
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
      'LeadQualificationID': _leadQualificationID,
      'AccountName': _accountName,
      'Address': _address,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
