import 'package:happsales_crm/database/models/BaseEntity.dart';

class FormSectionBase extends BaseEntity {
  String? _formSectionID;
  String? _formSectionCode;
  String? _formSectionName;
  String? _formID;
  String? _numberOfRows;
  String? _numberOfColumns;
  String? _columnWidths;
  String? _sectionStyle;
  String? _sectionType;
  String? _sectionOrder;
  String? _backgroundColor;
  String? _displayInApp;
  String? _displayInReport;
  String? _isRepeatable;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _referenceIdentifier;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;

  String? _formName;
  String? _appUserName;
  String? _appUserGroupName;

  FormSectionBase();

  String? get formSectionID => _formSectionID;
  set formSectionID(String? value) {
    _formSectionID = value;
  }

  String? get formSectionCode => _formSectionCode;
  set formSectionCode(String? value) {
    _formSectionCode = value;
  }

  String? get formSectionName => _formSectionName;
  set formSectionName(String? value) {
    _formSectionName = value;
  }

  String? get formID => _formID;
  set formID(String? value) {
    _formID = value;
  }

  String? get numberOfRows => _numberOfRows;
  set numberOfRows(String? value) {
    _numberOfRows = value;
  }

  String? get numberOfColumns => _numberOfColumns;
  set numberOfColumns(String? value) {
    _numberOfColumns = value;
  }

  String? get columnWidths => _columnWidths;
  set columnWidths(String? value) {
    _columnWidths = value;
  }

  String? get sectionStyle => _sectionStyle;
  set sectionStyle(String? value) {
    _sectionStyle = value;
  }

  String? get sectionType => _sectionType;
  set sectionType(String? value) {
    _sectionType = value;
  }

  String? get sectionOrder => _sectionOrder;
  set sectionOrder(String? value) {
    _sectionOrder = value;
  }

  String? get backgroundColor => _backgroundColor;
  set backgroundColor(String? value) {
    _backgroundColor = value;
  }

  String? get displayInApp => _displayInApp;
  set displayInApp(String? value) {
    _displayInApp = value;
  }

  String? get displayInReport => _displayInReport;
  set displayInReport(String? value) {
    _displayInReport = value;
  }

  String? get isRepeatable => _isRepeatable;
  set isRepeatable(String? value) {
    _isRepeatable = value;
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

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) {
    _referenceIdentifier = value;
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

  String? get formName => _formName;
  set formName(String? value) {
    _formName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'FormSectionID': _formSectionID,
      'FormSectionCode': _formSectionCode,
      'FormSectionName': _formSectionName,
      'FormID': _formID,
      'NumberOfRows': _numberOfRows,
      'NumberOfColumns': _numberOfColumns,
      'ColumnWidths': _columnWidths,
      'SectionStyle': _sectionStyle,
      'SectionType': _sectionType,
      'SectionOrder': _sectionOrder,
      'BackgroundColor': _backgroundColor,
      'DisplayInApp': _displayInApp,
      'DisplayInReport': _displayInReport,
      'IsRepeatable': _isRepeatable,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'ReferenceIdentifier': _referenceIdentifier,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'FormName': _formName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  FormSectionBase.fromMapObject(Map<String, dynamic> map) {
    _formSectionID = map['FormSectionID'];
    _formSectionCode = map['FormSectionCode'];
    _formSectionName = map['FormSectionName'];
    _formID = map['FormID'];
    _numberOfRows = map['NumberOfRows'];
    _numberOfColumns = map['NumberOfColumns'];
    _columnWidths = map['ColumnWidths'];
    _sectionStyle = map['SectionStyle'];
    _sectionType = map['SectionType'];
    _sectionOrder = map['SectionOrder'];
    _backgroundColor = map['BackgroundColor'];
    _displayInApp = map['DisplayInApp'];
    _displayInReport = map['DisplayInReport'];
    _isRepeatable = map['IsRepeatable'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _formName = map['FormName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
