class AppFeatureGroupBase {
  String? _appFeatureGroupID;
  String? _appFeatureGroupCode;
  String? _appFeatureGroupName;
  String? _businessFeatureID;
  String? _appFeatureGroupOrder;
  String? _parentAppFeatureGroupID;
  String? _appIcon;
  String? _consoleIcon;
  String? _descriptionText;
  String? _descriptionHtml;
  String? _menuPosition;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _businessFeatureName;
  String? _parentAppFeatureGroupName;
  String? _appUserName;
  String? _appUserGroupName;
  AppFeatureGroupBase();

  String? get appFeatureGroupID => _appFeatureGroupID;
  set appFeatureGroupID(String? value) => _appFeatureGroupID = value;

  String? get appFeatureGroupCode => _appFeatureGroupCode;
  set appFeatureGroupCode(String? value) => _appFeatureGroupCode = value;

  String? get appFeatureGroupName => _appFeatureGroupName;
  set appFeatureGroupName(String? value) => _appFeatureGroupName = value;

  String? get businessFeatureID => _businessFeatureID;
  set businessFeatureID(String? value) => _businessFeatureID = value;

  String? get appFeatureGroupOrder => _appFeatureGroupOrder;
  set appFeatureGroupOrder(String? value) => _appFeatureGroupOrder = value;

  String? get parentAppFeatureGroupID => _parentAppFeatureGroupID;
  set parentAppFeatureGroupID(String? value) =>
      _parentAppFeatureGroupID = value;

  String? get appIcon => _appIcon;
  set appIcon(String? value) => _appIcon = value;

  String? get consoleIcon => _consoleIcon;
  set consoleIcon(String? value) => _consoleIcon = value;

  String? get descriptionText => _descriptionText;
  set descriptionText(String? value) => _descriptionText = value;

  String? get descriptionHtml => _descriptionHtml;
  set descriptionHtml(String? value) => _descriptionHtml = value;

  String? get menuPosition => _menuPosition;
  set menuPosition(String? value) => _menuPosition = value;

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

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get businessFeatureName => _businessFeatureName;
  set businessFeatureName(String? value) => _businessFeatureName = value;

  String? get parentAppFeatureGroupName => _parentAppFeatureGroupName;
  set parentAppFeatureGroupName(String? value) =>
      _parentAppFeatureGroupName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  AppFeatureGroupBase.fromMap(Map<String, dynamic> map) {
    _appFeatureGroupID = map['appFeatureGroupID'];
    _appFeatureGroupCode = map['appFeatureGroupCode'];
    _appFeatureGroupName = map['appFeatureGroupName'];
    _businessFeatureID = map['businessFeatureID'];
    _appFeatureGroupOrder = map['appFeatureGroupOrder'];
    _parentAppFeatureGroupID = map['parentAppFeatureGroupID'];
    _appIcon = map['appIcon'];
    _consoleIcon = map['consoleIcon'];
    _descriptionText = map['descriptionText'];
    _descriptionHtml = map['descriptionHtml'];
    _menuPosition = map['menuPosition'];
    _createdBy = map['createdBy'];
    _createdOn = map['createdOn'];
    _modifiedBy = map['modifiedBy'];
    _modifiedOn = map['modifiedOn'];
    _isActive = map['isActive'];
    _uid = map['uid'];
    _appUserID = map['appUserID'];
    _appUserGroupID = map['appUserGroupID'];
    _isDeleted = map['isDeleted'];
    _businessFeatureName = map['businessFeatureName'];
    _parentAppFeatureGroupName = map['parentAppFeatureGroupName'];
    _appUserName = map['appUserName'];
    _appUserGroupName = map['appUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'appFeatureGroupID': _appFeatureGroupID,
      'appFeatureGroupCode': _appFeatureGroupCode,
      'appFeatureGroupName': _appFeatureGroupName,
      'businessFeatureID': _businessFeatureID,
      'appFeatureGroupOrder': _appFeatureGroupOrder,
      'parentAppFeatureGroupID': _parentAppFeatureGroupID,
      'appIcon': _appIcon,
      'consoleIcon': _consoleIcon,
      'descriptionText': _descriptionText,
      'descriptionHtml': _descriptionHtml,
      'menuPosition': _menuPosition,
      'createdBy': _createdBy,
      'createdOn': _createdOn,
      'modifiedBy': _modifiedBy,
      'modifiedOn': _modifiedOn,
      'isActive': _isActive,
      'uid': _uid,
      'appUserID': _appUserID,
      'appUserGroupID': _appUserGroupID,
      'isDeleted': _isDeleted,
      'businessFeatureName': _businessFeatureName,
      'parentAppFeatureGroupName': _parentAppFeatureGroupName,
      'appUserName': _appUserName,
      'appUserGroupName': _appUserGroupName,
    };
  }
}
