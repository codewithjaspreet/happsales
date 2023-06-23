import '../../Models/BaseEntity.dart';

class FormBase extends BaseEntity {
  String? _formID;
  String? _formCode;
  String? _formName;
  String? _businessFeatureID;
  String? _formType;
  String? _linkTo;
  String? _forStatus;
  String? _sortOrder;
  String? _isMandatory;
  String? _displayInApp;
  String? _pdfSize;
  String? _dataScriptWeb;
  String? _dataScriptApp;
  String? _parentFormID;
  String? _emailManualTemplateID;
  String? _emailAutomatedTemplateID;
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
  String? _businessFeatureName;
  String? _parentFormName;
  String? _emailManualTemplateName;
  String? _emailAutomatedTemplateTitle;
  String? _appUserName;
  String? _appUserGroupName;

  String? get formID => _formID;
  String? get formCode => _formCode;
  String? get formName => _formName;
  String? get businessFeatureID => _businessFeatureID;
  String? get formType => _formType;
  String? get linkTo => _linkTo;
  String? get forStatus => _forStatus;
  String? get sortOrder => _sortOrder;
  String? get isMandatory => _isMandatory;
  String? get displayInApp => _displayInApp;
  String? get pdfSize => _pdfSize;
  String? get dataScriptWeb => _dataScriptWeb;
  String? get dataScriptApp => _dataScriptApp;
  String? get parentFormID => _parentFormID;
  String? get emailManualTemplateID => _emailManualTemplateID;
  String? get emailAutomatedTemplateID => _emailAutomatedTemplateID;
  String? get createdOn => _createdOn;
  String? get createdBy => _createdBy;
  String? get modifiedOn => _modifiedOn;
  String? get modifiedBy => _modifiedBy;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get appUserID => _appUserID;
  String? get appUserGroupID => _appUserGroupID;
  String? get isArchived => _isArchived;
  String? get isDeleted => _isDeleted;
  String? get businessFeatureName => _businessFeatureName;
  String? get parentFormName => _parentFormName;
  String? get emailManualTemplateName => _emailManualTemplateName;
  String? get emailAutomatedTemplateTitle => _emailAutomatedTemplateTitle;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;

  FormBase();

  FormBase.fromMap(Map<String, dynamic> map)
      : _formID = map['FormID'],
        _formCode = map['FormCode'],
        _formName = map['FormName'],
        _businessFeatureID = map['BusinessFeatureID'],
        _formType = map['FormType'],
        _linkTo = map['LinkTo'],
        _forStatus = map['ForStatus'],
        _sortOrder = map['SortOrder'],
        _isMandatory = map['IsMandatory'],
        _displayInApp = map['DisplayInApp'],
        _pdfSize = map['PDFSize'],
        _dataScriptWeb = map['DataScriptWeb'],
        _dataScriptApp = map['DataScriptApp'],
        _parentFormID = map['ParentFormID'],
        _emailManualTemplateID = map['EmailManualTemplateID'],
        _emailAutomatedTemplateID = map['EmailAutomatedTemplateID'],
        _createdOn = map['CreatedOn'],
        _createdBy = map['CreatedBy'],
        _modifiedOn = map['ModifiedOn'],
        _modifiedBy = map['ModifiedBy'],
        _isActive = map['IsActive'],
        _uid = map['Uid'],
        _appUserID = map['AppUserID'],
        _appUserGroupID = map['AppUserGroupID'],
        _isArchived = map['IsArchived'],
        _isDeleted = map['IsDeleted'],
        _businessFeatureName = map['BusinessFeatureName'],
        _parentFormName = map['ParentFormName'],
        _emailManualTemplateName = map['EmailManualTemplateName'],
        _emailAutomatedTemplateTitle = map['EmailAutomatedTemplateTitle'],
        _appUserName = map['AppUserName'],
        _appUserGroupName = map['AppUserGroupName'];

  Map<String, dynamic> toMap() {
    return {
      'FormID': _formID,
      'FormCode': _formCode,
      'FormName': _formName,
      'BusinessFeatureID': _businessFeatureID,
      'FormType': _formType,
      'LinkTo': _linkTo,
      'ForStatus': _forStatus,
      'SortOrder': _sortOrder,
      'IsMandatory': _isMandatory,
      'DisplayInApp': _displayInApp,
      'PDFSize': _pdfSize,
      'DataScriptWeb': _dataScriptWeb,
      'DataScriptApp': _dataScriptApp,
      'ParentFormID': _parentFormID,
      'EmailManualTemplateID': _emailManualTemplateID,
      'EmailAutomatedTemplateID': _emailAutomatedTemplateID,
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
      'BusinessFeatureName': _businessFeatureName,
      'ParentFormName': _parentFormName,
      'EmailManualTemplateName': _emailManualTemplateName,
      'EmailAutomatedTemplateTitle': _emailAutomatedTemplateTitle,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
