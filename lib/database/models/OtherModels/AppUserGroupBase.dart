class AppUserGroupBase {
  String? _appUserGroupID;
  String? _appUserGroupCode;
  String? _appUserGroupName;
  String? _appUserGroupDetail;
  String? _adminName;
  String? _adminUserName;
  String? _adminEmail;
  String? _adminMobileNumber;
  String? _passCode;
  String? _address;
  String? _billingAddress;
  String? _appLogoPath;
  String? _appLogoContent;
  String? _consoleLogoPath;
  String? _consoleLogoContent;
  String? _caption;
  String? _parentAppUserGroupID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _deactivatedOn;
  String? _uid;
  String? _isArchived;
  String? _isDeleted;

  AppUserGroupBase();

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get appUserGroupCode => _appUserGroupCode;
  set appUserGroupCode(String? value) => _appUserGroupCode = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  String? get appUserGroupDetail => _appUserGroupDetail;
  set appUserGroupDetail(String? value) => _appUserGroupDetail = value;

  String? get adminName => _adminName;
  set adminName(String? value) => _adminName = value;

  String? get adminUserName => _adminUserName;
  set adminUserName(String? value) => _adminUserName = value;

  String? get adminEmail => _adminEmail;
  set adminEmail(String? value) => _adminEmail = value;

  String? get adminMobileNumber => _adminMobileNumber;
  set adminMobileNumber(String? value) => _adminMobileNumber = value;

  String? get passCode => _passCode;
  set passCode(String? value) => _passCode = value;

  String? get address => _address;
  set address(String? value) => _address = value;

  String? get billingAddress => _billingAddress;
  set billingAddress(String? value) => _billingAddress = value;

  String? get appLogoPath => _appLogoPath;
  set appLogoPath(String? value) => _appLogoPath = value;

  String? get appLogoContent => _appLogoContent;
  set appLogoContent(String? value) => _appLogoContent = value;

  String? get consoleLogoPath => _consoleLogoPath;
  set consoleLogoPath(String? value) => _consoleLogoPath = value;

  String? get consoleLogoContent => _consoleLogoContent;
  set consoleLogoContent(String? value) => _consoleLogoContent = value;

  String? get caption => _caption;
  set caption(String? value) => _caption = value;

  String? get parentAppUserGroupID => _parentAppUserGroupID;
  set parentAppUserGroupID(String? value) => _parentAppUserGroupID = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get deactivatedOn => _deactivatedOn;
  set deactivatedOn(String? value) => _deactivatedOn = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  Map<String, dynamic> toMap() {
    return {
      'appUserGroupID': _appUserGroupID,
      'appUserGroupCode': _appUserGroupCode,
      'appUserGroupName': _appUserGroupName,
      'appUserGroupDetail': _appUserGroupDetail,
      'adminName': _adminName,
      'adminUserName': _adminUserName,
      'adminEmail': _adminEmail,
      'adminMobileNumber': _adminMobileNumber,
      'passCode': _passCode,
      'address': _address,
      'billingAddress': _billingAddress,
      'appLogoPath': _appLogoPath,
      'appLogoContent': _appLogoContent,
      'consoleLogoPath': _consoleLogoPath,
      'consoleLogoContent': _consoleLogoContent,
      'caption': _caption,
      'parentAppUserGroupID': _parentAppUserGroupID,
      'createdBy': _createdBy,
      'createdOn': _createdOn,
      'modifiedBy': _modifiedBy,
      'modifiedOn': _modifiedOn,
      'isActive': _isActive,
      'deactivatedOn': _deactivatedOn,
      'uid': _uid,
      'isArchived': _isArchived,
      'isDeleted': _isDeleted,
    };
  }

   AppUserGroupBase.fromMap(Map<String, dynamic> map) {
    _appUserGroupID: map['appUserGroupID'];
    _appUserGroupCode: map['appUserGroupCode'];
    _appUserGroupName: map['appUserGroupName'];
    _appUserGroupDetail: map['appUserGroupDetail'];
    _adminName: map['adminName'];
    _adminUserName: map['adminUserName'];
    _adminEmail: map['adminEmail'];
    _adminMobileNumber: map['adminMobileNumber'];
    _passCode: map['passCode'];
    _address: map['address'];
    _billingAddress: map['billingAddress'];
    _appLogoPath: map['appLogoPath'];
    _appLogoContent: map['appLogoContent'];
    _consoleLogoPath: map['consoleLogoPath'];
    _consoleLogoContent: map['consoleLogoContent'];
    _caption: map['caption'];
    _parentAppUserGroupID: map['parentAppUserGroupID'];
    _createdBy: map['createdBy'];
    _createdOn: map['createdOn'];
    _modifiedBy: map['modifiedBy'];
    _modifiedOn: map['modifiedOn'];
    _isActive: map['isActive'];
    _deactivatedOn: map['deactivatedOn'];
    _uid: map['uid'];
    _isArchived: map['isArchived'];
    _isDeleted: map['isDeleted'];
  
}

}
