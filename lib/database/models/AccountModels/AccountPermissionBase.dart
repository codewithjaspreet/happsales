class AccountPermissionBase {
  String? _accountID;
  String? _appUserID;
  String? _assignmentPermissionTypeID;
  String? _assignmentPermissionTypeCode;
  String? _accountPermissionID;
  String? _isDenied;
  String? _isArchived;
  String? _isDeleted;
  String? _createdBy;
  String? _createdOn;
  String? _appUserGroupID;
  String? _uid;
  String? _isActive;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _accountName;
  String? _appUserName;
  String? _assignmentPermissionTypeName;
  String? _appUserGroupName;

  AccountPermissionBase();

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get assignmentPermissionTypeID => _assignmentPermissionTypeID;
  set assignmentPermissionTypeID(String? value) {
    _assignmentPermissionTypeID = value;
  }

  String? get assignmentPermissionTypeCode => _assignmentPermissionTypeCode;
  set assignmentPermissionTypeCode(String? value) {
    _assignmentPermissionTypeCode = value;
  }

  String? get accountPermissionID => _accountPermissionID;
  set accountPermissionID(String? value) {
    _accountPermissionID = value;
  }

  String? get isDenied => _isDenied;
  set isDenied(String? value) {
    _isDenied = value;
  }

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get accountName => _accountName;
  set accountName(String? value) {
    _accountName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get assignmentPermissionTypeName => _assignmentPermissionTypeName;
  set assignmentPermissionTypeName(String? value) {
    _assignmentPermissionTypeName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  void fromMapObject(Map<String, dynamic> map) {
    _accountID = map['AccountID'];
    _appUserID = map['AppUserID'];
    _assignmentPermissionTypeID = map['AssignmentPermissionTypeID'];
    _assignmentPermissionTypeCode = map['AssignmentPermissionTypeCode'];
    _accountPermissionID = map['AccountPermissionID'];
    _isDenied = map['IsDenied'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _appUserGroupID = map['AppUserGroupID'];
    _uid = map['Uid'];
    _isActive = map['IsActive'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _accountName = map['AccountName'];
    _appUserName = map['AppUserName'];
    _assignmentPermissionTypeName = map['AssignmentPermissionTypeName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountID': _accountID,
      'AppUserID': _appUserID,
      'AssignmentPermissionTypeID': _assignmentPermissionTypeID,
      'AssignmentPermissionTypeCode': _assignmentPermissionTypeCode,
      'AccountPermissionID': _accountPermissionID,
      'IsDenied': _isDenied,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'AppUserGroupID': _appUserGroupID,
      'Uid': _uid,
      'IsActive': _isActive,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'AccountName': _accountName,
      'AppUserName': _appUserName,
      'AssignmentPermissionTypeName': _assignmentPermissionTypeName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
