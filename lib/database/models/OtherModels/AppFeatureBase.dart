class AppFeatureBase {
  String? _appFeatureID;
  String? _appFeatureCode;
  String? _appFeatureName;
  String? _businessFeatureID;
  String? _appFeatureGroupID;
  String? _description;
  String? _formName;
  String? _appFeatureOrder;
  String? _appIcon;
  String? _consoleIcon;
  String? _descriptionText;
  String? _descriptionHtml;
  String? _isConsoleFeature;
  String? _isAppFeature;
  String? _internalCode;
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
  String? _businessFeatureName;
  String? _appFeatureGroupName;
  String? _appUserName;
  String? _appUserGroupName;

  AppFeatureBase();

  String? get appFeatureID => _appFeatureID;
  set appFeatureID(String? value) => _appFeatureID = value;

  String? get appFeatureCode => _appFeatureCode;
  set appFeatureCode(String? value) => _appFeatureCode = value;

  String? get appFeatureName => _appFeatureName;
  set appFeatureName(String? value) => _appFeatureName = value;

  String? get businessFeatureID => _businessFeatureID;
  set businessFeatureID(String? value) => _businessFeatureID = value;

  String? get appFeatureGroupID => _appFeatureGroupID;
  set appFeatureGroupID(String? value) => _appFeatureGroupID = value;

  String? get description => _description;
  set description(String? value) => _description = value;

  String? get formName => _formName;
  set formName(String? value) => _formName = value;

  String? get appFeatureOrder => _appFeatureOrder;
  set appFeatureOrder(String? value) => _appFeatureOrder = value;

  String? get appIcon => _appIcon;
  set appIcon(String? value) => _appIcon = value;

  String? get consoleIcon => _consoleIcon;
  set consoleIcon(String? value) => _consoleIcon = value;

  String? get descriptionText => _descriptionText;
  set descriptionText(String? value) => _descriptionText = value;

  String? get descriptionHtml => _descriptionHtml;
  set descriptionHtml(String? value) => _descriptionHtml = value;

  String? get isConsoleFeature => _isConsoleFeature;
  set isConsoleFeature(String? value) => _isConsoleFeature = value;

  String? get isAppFeature => _isAppFeature;
  set isAppFeature(String? value) => _isAppFeature = value;

  String? get internalCode => _internalCode;
  set internalCode(String? value) => _internalCode = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get deviceIdentifier => _deviceIdentifier;
  set deviceIdentifier(String? value) => _deviceIdentifier = value;

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) => _referenceIdentifier = value;

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

  String? get businessFeatureName => _businessFeatureName;
  set businessFeatureName(String? value) => _businessFeatureName = value;

  String? get appFeatureGroupName => _appFeatureGroupName;
  set appFeatureGroupName(String? value) => _appFeatureGroupName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

   AppFeatureBase.fromMap(Map<String, dynamic> map) {
      _appFeatureID = map['appFeatureID'];
      _appFeatureCode = map['appFeatureCode'];
      _appFeatureName = map['appFeatureName'];
      _businessFeatureID = map['businessFeatureID'];
      _appFeatureGroupID = map['appFeatureGroupID'];
      _description = map['description'];
      _formName = map['formName'];
      _appFeatureOrder = map['appFeatureOrder'];
      _appIcon = map['appIcon'];
      _consoleIcon = map['consoleIcon'];
      _descriptionText = map['descriptionText'];
      _descriptionHtml = map['descriptionHtml'];
      _isConsoleFeature = map['isConsoleFeature'];
      _isAppFeature = map['isAppFeature'];
      _internalCode = map['internalCode'];
      _createdBy = map['createdBy'];
      _createdOn = map['createdOn'];
      _modifiedBy = map['modifiedBy'];
      _modifiedOn = map['modifiedOn'];
      _deviceIdentifier = map['deviceIdentifier'];
      _referenceIdentifier = map['referenceIdentifier'];
      _isActive = map['isActive'];
      _uid = map['uid'];
      _appUserID = map['appUserID'];
      _appUserGroupID = map['appUserGroupID'];
      _isArchived = map['isArchived'];
      _isDeleted = map['isDeleted'];
      _businessFeatureName = map['businessFeatureName'];
      _appFeatureGroupName = map['appFeatureGroupName'];
      _appUserName = map['appUserName'];
      _appUserGroupName = map['appUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'appFeatureID': _appFeatureID,
      'appFeatureCode': _appFeatureCode,
      'appFeatureName': _appFeatureName,
      'businessFeatureID': _businessFeatureID,
      'appFeatureGroupID': _appFeatureGroupID,
      'description': _description,
      'formName': _formName,
      'appFeatureOrder': _appFeatureOrder,
      'appIcon': _appIcon,
      'consoleIcon': _consoleIcon,
      'descriptionText': _descriptionText,
      'descriptionHtml': _descriptionHtml,
      'isConsoleFeature': _isConsoleFeature,
      'isAppFeature': _isAppFeature,
      'internalCode': _internalCode,
      'createdBy': _createdBy,
      'createdOn': _createdOn,
      'modifiedBy': _modifiedBy,
      'modifiedOn': _modifiedOn,
      'deviceIdentifier': _deviceIdentifier,
      'referenceIdentifier': _referenceIdentifier,
      'isActive': _isActive,
      'uid': _uid,
      'appUserID': _appUserID,
      'appUserGroupID': _appUserGroupID,
      'isArchived': _isArchived,
      'isDeleted': _isDeleted,
      'businessFeatureName': _businessFeatureName,
      'appFeatureGroupName': _appFeatureGroupName,
      'appUserName': _appUserName,
      'appUserGroupName': _appUserGroupName,
    };
  }
}
