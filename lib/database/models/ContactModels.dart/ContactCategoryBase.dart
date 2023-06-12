class ContactCategoryBase {
  String? _contactCategoryID;
  String? _contactCategoryCode;
  String? _contactCategoryName;
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
  String? _appUserName;
  String? _appUserGroupName;

  ContactCategoryBase();

  String? get contactCategoryID => _contactCategoryID;
  set contactCategoryID(String? value) {
    _contactCategoryID = value;
  }

  String? get contactCategoryCode => _contactCategoryCode;
  set contactCategoryCode(String? value) {
    _contactCategoryCode = value;
  }

  String? get contactCategoryName => _contactCategoryName;
  set contactCategoryName(String? value) {
    _contactCategoryName = value;
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

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  void fromMapObject(Map<String, dynamic> map) {
    _contactCategoryID = map['ContactCategoryID'];
    _contactCategoryCode = map['ContactCategoryCode'];
    _contactCategoryName = map['ContactCategoryName'];
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
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ContactCategoryID': _contactCategoryID,
      'ContactCategoryCode': _contactCategoryCode,
      'ContactCategoryName': _contactCategoryName,
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
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
