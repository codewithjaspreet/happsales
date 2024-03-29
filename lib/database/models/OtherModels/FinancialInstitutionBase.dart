import '../../Models/BaseEntity.dart';

class FinancialInstitutionBase extends BaseEntity {
  String? _financialInstitutionID;
  String? _financialInstitutionCode;
  String? _financialInstitutionName;
  String? _description;
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

  String? get financialInstitutionID => _financialInstitutionID;
  String? get financialInstitutionCode => _financialInstitutionCode;
  String? get financialInstitutionName => _financialInstitutionName;
  String? get description => _description;
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
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;

  set financialInstitutionID(String? value) {
  _financialInstitutionID = value;
}

set financialInstitutionCode(String? value) {
  _financialInstitutionCode = value;
}

set financialInstitutionName(String? value) {
  _financialInstitutionName = value;
}

set description(String? value) {
  _description = value;
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

set appUserName(String? value) {
  _appUserName = value;
}

set appUserGroupName(String? value) {
  _appUserGroupName = value;
}


  FinancialInstitutionBase();

  FinancialInstitutionBase.fromMap(Map<String, dynamic> map)
      : _financialInstitutionID = map['FinancialInstitutionID'],
        _financialInstitutionCode = map['FinancialInstitutionCode'],
        _financialInstitutionName = map['FinancialInstitutionName'],
        _description = map['Description'],
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
        _appUserName = map['AppUserName'],
        _appUserGroupName = map['AppUserGroupName'];

  Map<String, dynamic> toMap() {
    return {
      'FinancialInstitutionID': _financialInstitutionID,
      'FinancialInstitutionCode': _financialInstitutionCode,
      'FinancialInstitutionName': _financialInstitutionName,
      'Description': _description,
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
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
