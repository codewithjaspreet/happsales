import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppFeatureFieldBase extends BaseEntity{
  String? _appFeatureFieldID;
  String? _appFeatureFieldCode;
  String? _appFeatureFieldName;
  String? _appFeatureID;
  String? _descriptionText;
  String? _descriptionHtml;
  String? _appFeatureFieldOrder;
  String? _isHidden;
  String? _isRequired;
  String? _newLabel;
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
  String? _isHiddenInFab;

  AppFeatureFieldBase();

  String? get appFeatureFieldID => _appFeatureFieldID;
  set appFeatureFieldID(String? value) => _appFeatureFieldID = value;

  String? get appFeatureFieldCode => _appFeatureFieldCode;
  set appFeatureFieldCode(String? value) => _appFeatureFieldCode = value;

  String? get appFeatureFieldName => _appFeatureFieldName;
  set appFeatureFieldName(String? value) => _appFeatureFieldName = value;

  String? get appFeatureID => _appFeatureID;
  set appFeatureID(String? value) => _appFeatureID = value;

  String? get descriptionText => _descriptionText;
  set descriptionText(String? value) => _descriptionText = value;

  String? get descriptionHtml => _descriptionHtml;
  set descriptionHtml(String? value) => _descriptionHtml = value;

  String? get appFeatureFieldOrder => _appFeatureFieldOrder;
  set appFeatureFieldOrder(String? value) => _appFeatureFieldOrder = value;

  String? get isHidden => _isHidden;
  set isHidden(String? value) => _isHidden = value;

  String? get isRequired => _isRequired;
  set isRequired(String? value) => _isRequired = value;

  String? get newLabel => _newLabel;
  set newLabel(String? value) => _newLabel = value;

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

  String? get isHiddenInFab => _isHiddenInFab;
  set isHiddenInFab(String? value) => _isHiddenInFab = value;

   AppFeatureFieldBase.fromMap(Map<String, dynamic> map) {
      _appFeatureFieldID = map['appFeatureFieldID'];
      _appFeatureFieldCode = map['appFeatureFieldCode'];
      _appFeatureFieldName = map['appFeatureFieldName'];
      _appFeatureID = map['appFeatureID'];
      _descriptionText = map['descriptionText'];
      _descriptionHtml = map['descriptionHtml'];
      _appFeatureFieldOrder = map['appFeatureFieldOrder'];
      _isHidden = map['isHidden'];
      _isRequired = map['isRequired'];
      _newLabel = map['newLabel'];
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
      _appUserGroupName = map['appUserGroupName'];
      _isHiddenInFab = map['isHiddenInFab'];
  }

  Map<String, dynamic> toMap() {
    return {
      'appFeatureFieldID': _appFeatureFieldID,
      'appFeatureFieldCode': _appFeatureFieldCode,
      'appFeatureFieldName': _appFeatureFieldName,
      'appFeatureID': _appFeatureID,
      'descriptionText': _descriptionText,
      'descriptionHtml': _descriptionHtml,
      'appFeatureFieldOrder': _appFeatureFieldOrder,
      'isHidden': _isHidden,
      'isRequired': _isRequired,
      'newLabel': _newLabel,
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
      'isHiddenInFab': _isHiddenInFab,
    };
  }
}
