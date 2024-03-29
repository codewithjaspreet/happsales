import '../../Models/BaseEntity.dart';

class FormCellBase extends BaseEntity {
  String? _formCellID;
  String? _formCellCode;
  String? _formCellName;
  String? _formSectionID;
  String? _rowIndex;
  String? _columnIndex;
  String? _rowSpan;
  String? _columnSpan;
  String? _alignment;
  String? _verticalAlignment;
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
  String? _formSectionName;
  String? _appUserName;
  String? _appUserGroupName;

  String? get formCellID => _formCellID;
  String? get formCellCode => _formCellCode;
  String? get formCellName => _formCellName;
  String? get formSectionID => _formSectionID;
  String? get rowIndex => _rowIndex;
  String? get columnIndex => _columnIndex;
  String? get rowSpan => _rowSpan;
  String? get columnSpan => _columnSpan;
  String? get alignment => _alignment;
  String? get verticalAlignment => _verticalAlignment;
  String? get createdOn => _createdOn;
  String? get createdBy => _createdBy;
  String? get modifiedOn => _modifiedOn;
  String? get modifiedBy => _modifiedBy;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get referenceIdentifier => _referenceIdentifier;
  String? get appUserID => _appUserID;
  String? get appUserGroupID => _appUserGroupID;
  String? get isArchived => _isArchived;
  String? get isDeleted => _isDeleted;
  String? get formSectionName => _formSectionName;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;

  set formCellID(String? value) {
  _formCellID = value;
}

set formCellCode(String? value) {
  _formCellCode = value;
}

set formCellName(String? value) {
  _formCellName = value;
}

set formSectionID(String? value) {
  _formSectionID = value;
}

set rowIndex(String? value) {
  _rowIndex = value;
}

set columnIndex(String? value) {
  _columnIndex = value;
}

set rowSpan(String? value) {
  _rowSpan = value;
}

set columnSpan(String? value) {
  _columnSpan = value;
}

set alignment(String? value) {
  _alignment = value;
}

set verticalAlignment(String? value) {
  _verticalAlignment = value;
}

set createdOn(String? value) {
  _createdOn = value;
}

set createdBy(String? value) {
  _createdBy = value;
}

set modifiedOn(String? value) {
  _modifiedOn = value;
}

set modifiedBy(String? value) {
  _modifiedBy = value;
}

set isActive(String? value) {
  _isActive = value;
}

set uid(String? value) {
  _uid = value;
}

set referenceIdentifier(String? value) {
  _referenceIdentifier = value;
}

set appUserID(String? value) {
  _appUserID = value;
}

set appUserGroupID(String? value) {
  _appUserGroupID = value;
}

set isArchived(String? value) {
  _isArchived = value;
}

set isDeleted(String? value) {
  _isDeleted = value;
}

set formSectionName(String? value) {
  _formSectionName = value;
}

set appUserName(String? value) {
  _appUserName = value;
}

set appUserGroupName(String? value) {
  _appUserGroupName = value;
}


  FormCellBase();

  FormCellBase.fromMap(Map<String, dynamic> map)
      : _formCellID = map['FormCellID'],
        _formCellCode = map['FormCellCode'],
        _formCellName = map['FormCellName'],
        _formSectionID = map['FormSectionID'],
        _rowIndex = map['RowIndex'],
        _columnIndex = map['ColumnIndex'],
        _rowSpan = map['RowSpan'],
        _columnSpan = map['ColumnSpan'],
        _alignment = map['Alignment'],
        _verticalAlignment = map['VerticalAlignment'],
        _createdOn = map['CreatedOn'],
        _createdBy = map['CreatedBy'],
        _modifiedOn = map['ModifiedOn'],
        _modifiedBy = map['ModifiedBy'],
        _isActive = map['IsActive'],
        _uid = map['Uid'],
        _referenceIdentifier = map['ReferenceIdentifier'],
        _appUserID = map['AppUserID'],
        _appUserGroupID = map['AppUserGroupID'],
        _isArchived = map['IsArchived'],
        _isDeleted = map['IsDeleted'],
        _formSectionName = map['FormSectionName'],
        _appUserName = map['AppUserName'],
        _appUserGroupName = map['AppUserGroupName'];

  Map<String, dynamic> toMap() {
    return {
      'FormCellID': _formCellID,
      'FormCellCode': _formCellCode,
      'FormCellName': _formCellName,
      'FormSectionID': _formSectionID,
      'RowIndex': _rowIndex,
      'ColumnIndex': _columnIndex,
      'RowSpan': _rowSpan,
      'ColumnSpan': _columnSpan,
      'Alignment': _alignment,
      'VerticalAlignment': _verticalAlignment,
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
      'FormSectionName': _formSectionName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
