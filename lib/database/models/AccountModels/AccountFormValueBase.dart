import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountFormValueBase extends BaseEntity {
  String? _accountFormValueID;
  String? _accountFormValueCode;
  String? _accountFormID;
  String? _formCellElementID;
  String? _formCellElementValue;
  String? _rowIndex;
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

  String? _accountFormTitle;
  String? _formCellElementName;
  String? _appUserName;
  String? _appUserGroupName;

  AccountFormValueBase();

  String? get accountFormValueID => _accountFormValueID;
  set accountFormValueID(String? value) {
    _accountFormValueID = value;
  }

  String? get accountFormValueCode => _accountFormValueCode;
  set accountFormValueCode(String? value) {
    _accountFormValueCode = value;
  }

  String? get accountFormID => _accountFormID;
  set accountFormID(String? value) {
    _accountFormID = value;
  }

  String? get formCellElementID => _formCellElementID;
  set formCellElementID(String? value) {
    _formCellElementID = value;
  }

  String? get formCellElementValue => _formCellElementValue;
  set formCellElementValue(String? value) {
    _formCellElementValue = value;
  }

  String? get rowIndex => _rowIndex;
  set rowIndex(String? value) {
    _rowIndex = value;
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

  String? get accountFormTitle => _accountFormTitle;
  set accountFormTitle(String? value) {
    _accountFormTitle = value;
  }

  String? get formCellElementName => _formCellElementName;
  set formCellElementName(String? value) {
    _formCellElementName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  void fromMapObject(Map<String, dynamic> map) {
    _accountFormValueID = map['AccountFormValueID'];
    _accountFormValueCode = map['AccountFormValueCode'];
    _accountFormID = map['AccountFormID'];
    _formCellElementID = map['FormCellElementID'];
    _formCellElementValue = map['FormCellElementValue'];
    _rowIndex = map['RowIndex'];
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
    _accountFormTitle = map['AccountFormTitle'];
    _formCellElementName = map['FormCellElementName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'AccountFormValueID': _accountFormValueID,
      'AccountFormValueCode': _accountFormValueCode,
      'AccountFormID': _accountFormID,
      'FormCellElementID': _formCellElementID,
      'FormCellElementValue': _formCellElementValue,
      'RowIndex': _rowIndex,
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
      'AccountFormTitle': _accountFormTitle,
      'FormCellElementName': _formCellElementName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
