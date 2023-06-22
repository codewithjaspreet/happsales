class AppFieldBase {
  String? _appFieldID;
  String? _appFieldCode;
  String? _appFieldName;
  String? _appFeatureID;
  String? _fieldControlName;
  String? _description;
  String? _newFieldLabel;
  String? _showInApp;
  String? _showInConsole;
  String? _isMandatoryField;
  String? _defaultValue;
  String? _appFieldOrder;
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
  String? _appFeatureName;
  String? _appUserName;
  String? _appUserGroupName;

  AppFieldBase();

  String? get appFieldID => _appFieldID;
  set appFieldID(String? value) => _appFieldID = value;

  String? get appFieldCode => _appFieldCode;
  set appFieldCode(String? value) => _appFieldCode = value;

  String? get appFieldName => _appFieldName;
  set appFieldName(String? value) => _appFieldName = value;

  String? get appFeatureID => _appFeatureID;
  set appFeatureID(String? value) => _appFeatureID = value;

  String? get fieldControlName => _fieldControlName;
  set fieldControlName(String? value) => _fieldControlName = value;

  String? get description => _description;
  set description(String? value) => _description = value;

  String? get newFieldLabel => _newFieldLabel;
  set newFieldLabel(String? value) => _newFieldLabel = value;

  String? get showInApp => _showInApp;
  set showInApp(String? value) => _showInApp = value;

  String? get showInConsole => _showInConsole;
  set showInConsole(String? value) => _showInConsole = value;

  String? get isMandatoryField => _isMandatoryField;
  set isMandatoryField(String? value) => _isMandatoryField = value;

  String? get defaultValue => _defaultValue;
  set defaultValue(String? value) => _defaultValue = value;

  String? get appFieldOrder => _appFieldOrder;
  set appFieldOrder(String? value) => _appFieldOrder = value;

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

  String? get appFeatureName => _appFeatureName;
  set appFeatureName(String? value) => _appFeatureName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

   AppFieldBase.fromMap(Map<String, dynamic> map) {
      _appFieldID = map['appFieldID'];
      _appFieldCode = map['appFieldCode'];
      _appFieldName = map['appFieldName'];
      _appFeatureID = map['appFeatureID'];
      _fieldControlName = map['fieldControlName'];
      _description = map['description'];
      _newFieldLabel = map['newFieldLabel'];
      _showInApp = map['showInApp'];
      _showInConsole = map['showInConsole'];
      _isMandatoryField = map['isMandatoryField'];
      _defaultValue = map['defaultValue'];
      _appFieldOrder = map['appFieldOrder'];
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
      _appFeatureName = map['appFeatureName'];
      _appUserName = map['appUserName'];
      _appUserGroupName = map['appUserGroupName'];;
  }

  Map<String, dynamic> toMap() {
    return {
      'appFieldID': _appFieldID,
      'appFieldCode': _appFieldCode,
      'appFieldName': _appFieldName,
      'appFeatureID': _appFeatureID,
      'fieldControlName': _fieldControlName,
      'description': _description,
      'newFieldLabel': _newFieldLabel,
      'showInApp': _showInApp,
      'showInConsole': _showInConsole,
      'isMandatoryField': _isMandatoryField,
      'defaultValue': _defaultValue,
      'appFieldOrder': _appFieldOrder,
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
      'appFeatureName': _appFeatureName,
      'appUserName': _appUserName,
      'appUserGroupName': _appUserGroupName,
    };
  }
}
