class AppReportBase {
  String? _appReportID;
  String? _appReportCode;
  String? _appReportName;
  String? _appReportPath;
  String? _appReportType;
  String? _sequentialOrder;
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

  AppReportBase();

  String? get appReportID => _appReportID;
  set appReportID(String? value) => _appReportID = value;

  String? get appReportCode => _appReportCode;
  set appReportCode(String? value) => _appReportCode = value;

  String? get appReportName => _appReportName;
  set appReportName(String? value) => _appReportName = value;

  String? get appReportPath => _appReportPath;
  set appReportPath(String? value) => _appReportPath = value;

  String? get appReportType => _appReportType;
  set appReportType(String? value) => _appReportType = value;

  String? get sequentialOrder => _sequentialOrder;
  set sequentialOrder(String? value) => _sequentialOrder = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;


  AppReportBase.fromMap(Map<String, dynamic> map) {
    _appReportID = map['AppReportID'];
    _appReportCode = map['AppReportCode'];
    _appReportName = map['AppReportName'];
    _appReportPath = map['AppReportPath'];
    _appReportType = map['AppReportType'];
    _sequentialOrder = map['SequentialOrder'];
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
    final map = <String, dynamic>{};
    map['AppReportID'] = _appReportID;
    map['AppReportCode'] = _appReportCode;
    map['AppReportName'] = _appReportName;
    map['AppReportPath'] = _appReportPath;
    map['AppReportType'] = _appReportType;
    map['SequentialOrder'] = _sequentialOrder;
    map['CreatedOn'] = _createdOn;
    map['CreatedBy'] = _createdBy;
    map['ModifiedOn'] = _modifiedOn;
    map['ModifiedBy'] = _modifiedBy;
    map['IsActive'] = _isActive;
    map['Uid'] = _uid;
    map['AppUserID'] = _appUserID;
    map['AppUserGroupID'] = _appUserGroupID;
    map['IsArchived'] = _isArchived;
    map['IsDeleted'] = _isDeleted;
    map['AppUserName'] = _appUserName;
    map['AppUserGroupName'] = _appUserGroupName;
    return map;
  }
}
