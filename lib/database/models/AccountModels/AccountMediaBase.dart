class AccountMediaBase {
  String? _accountMediaID;
  String? _accountMediaCode;
  String? _accountMediaName;
  String? _accountID;
  String? _contentTypeID;
  String? _mediaPath;
  String? _mediaContent;
  String? _description;
  String? _tags;
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
  String? _contentTypeName;
  String? _appUserName;
  String? _appUserGroupName;

  AccountMediaBase();

  String? get accountMediaID => _accountMediaID;
  set accountMediaID(String? value) {
    _accountMediaID = value;
  }

  String? get accountMediaCode => _accountMediaCode;
  set accountMediaCode(String? value) {
    _accountMediaCode = value;
  }

  String? get accountMediaName => _accountMediaName;
  set accountMediaName(String? value) {
    _accountMediaName = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get contentTypeID => _contentTypeID;
  set contentTypeID(String? value) {
    _contentTypeID = value;
  }

  String? get mediaPath => _mediaPath;
  set mediaPath(String? value) {
    _mediaPath = value;
  }

  String? get mediaContent => _mediaContent;
  set mediaContent(String? value) {
    _mediaContent = value;
  }

  String? get description => _description;
  set description(String? value) {
    _description = value;
  }

  String? get tags => _tags;
  set tags(String? value) {
    _tags = value;
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

  String? get contentTypeName => _contentTypeName;
  set contentTypeName(String? value) {
    _contentTypeName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  AccountMediaBase.fromMapObject(Map<String, dynamic> map) {
    _accountMediaID = map['AccountMediaID'];
    _accountMediaCode = map['AccountMediaCode'];
    _accountMediaName = map['AccountMediaName'];
    _accountID = map['AccountID'];
    _contentTypeID = map['ContentTypeID'];
    _mediaPath = map['MediaPath'];
    _mediaContent = map['MediaContent'];
    _description = map['Description'];
    _tags = map['Tags'];
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
    _contentTypeName = map['ContentTypeName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountMediaID': _accountMediaID,
      'AccountMediaCode': _accountMediaCode,
      'AccountMediaName': _accountMediaName,
      'AccountID': _accountID,
      'ContentTypeID': _contentTypeID,
      'MediaPath': _mediaPath,
      'MediaContent': _mediaContent,
      'Description': _description,
      'Tags': _tags,
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
      'ContentTypeName': _contentTypeName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
