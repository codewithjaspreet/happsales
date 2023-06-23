import 'package:happsales_crm/database/models/BaseEntity.dart';

class BusinessFeatureBase extends BaseEntity{
  String? _businessFeatureID;
  String? _businessFeatureCode;
  String? _businessFeatureName;
  String? _appIcon;
  String? _consoleIcon;
  String? _descriptionText;
  String? _descriptionHtml;
  String? _internalCode;
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

BusinessFeatureBase();
  // BusinessFeatureID
  String? get businessFeatureID => _businessFeatureID;
  set businessFeatureID(String? value) {
    _businessFeatureID = value;
  }

  // BusinessFeatureCode
  String? get businessFeatureCode => _businessFeatureCode;
  set businessFeatureCode(String? value) {
    _businessFeatureCode = value;
  }

  // BusinessFeatureName
  String? get businessFeatureName => _businessFeatureName;
  set businessFeatureName(String? value) {
    _businessFeatureName = value;
  }

  // AppIcon
  String? get appIcon => _appIcon;
  set appIcon(String? value) {
    _appIcon = value;
  }

  // ConsoleIcon
  String? get consoleIcon => _consoleIcon;
  set consoleIcon(String? value) {
    _consoleIcon = value;
  }

  // DescriptionText
  String? get descriptionText => _descriptionText;
  set descriptionText(String? value) {
    _descriptionText = value;
  }

  // DescriptionHtml
  String? get descriptionHtml => _descriptionHtml;
  set descriptionHtml(String? value) {
    _descriptionHtml = value;
  }

  // InternalCode
  String? get internalCode => _internalCode;
  set internalCode(String? value) {
    _internalCode = value;
  }

  // CreatedOn
  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  // CreatedBy
  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  // ModifiedOn
  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  // ModifiedBy
  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  // IsActive
  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  // Uid
  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  // AppUserID
  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  // AppUserGroupID
  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  // IsArchived
  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  // IsDeleted
  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  // AppUserName
  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  // AppUserGroupName
  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'BusinessFeatureID': businessFeatureID,
      'BusinessFeatureCode': businessFeatureCode,
      'BusinessFeatureName': businessFeatureName,
      'AppIcon': appIcon,
      'ConsoleIcon': consoleIcon,
      'DescriptionText': descriptionText,
      'DescriptionHtml': descriptionHtml,
      'InternalCode': internalCode,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   BusinessFeatureBase.fromMap(Map<String, dynamic> map) {
    _businessFeatureID = map['BusinessFeatureID'];
    _businessFeatureCode = map['BusinessFeatureCode'];
    _businessFeatureName = map['BusinessFeatureName'];
    _appIcon = map['AppIcon'];
    _consoleIcon = map['ConsoleIcon'];
    _descriptionText = map['DescriptionText'];
    _descriptionHtml = map['DescriptionHtml'];
    _internalCode = map['InternalCode'];
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
}
