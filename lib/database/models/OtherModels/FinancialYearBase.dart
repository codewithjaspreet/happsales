import '../../Models/BaseEntity.dart';

class FinancialYearBase extends BaseEntity {
  String? _financialYearID;
  String? _financialYearCode;
  String? _financialYearName;
  String? _actualFinancialYear;
  String? _financialYearStartDate;
  String? _financialYearEndDate;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  String? get financialYearID => _financialYearID;
  String? get financialYearCode => _financialYearCode;
  String? get financialYearName => _financialYearName;
  String? get actualFinancialYear => _actualFinancialYear;
  String? get financialYearStartDate => _financialYearStartDate;
  String? get financialYearEndDate => _financialYearEndDate;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get modifiedBy => _modifiedBy;
  String? get modifiedOn => _modifiedOn;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get appUserID => _appUserID;
  String? get appUserGroupID => _appUserGroupID;
  String? get isArchived => _isArchived;
  String? get isDeleted => _isDeleted;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;


set financialYearID(String? value) {
  _financialYearID = value;
}

set financialYearCode(String? value) {
  _financialYearCode = value;
}

set financialYearName(String? value) {
  _financialYearName = value;
}

set actualFinancialYear(String? value) {
  _actualFinancialYear = value;
}

set financialYearStartDate(String? value) {
  _financialYearStartDate = value;
}

set financialYearEndDate(String? value) {
  _financialYearEndDate = value;
}

set createdBy(String? value) {
  _createdBy = value;
}

set createdOn(String? value) {
  _createdOn = value;
}

set modifiedBy(String? value) {
  _modifiedBy = value;
}

set modifiedOn(String? value) {
  _modifiedOn = value;
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

  FinancialYearBase();

  FinancialYearBase.fromMap(Map<String, dynamic> map)
      : _financialYearID = map['FinancialYearID'],
        _financialYearCode = map['FinancialYearCode'],
        _financialYearName = map['FinancialYearName'],
        _actualFinancialYear = map['ActualFinancialYear'],
        _financialYearStartDate = map['FinancialYearStartDate'],
        _financialYearEndDate = map['FinancialYearEndDate'],
        _createdBy = map['CreatedBy'],
        _createdOn = map['CreatedOn'],
        _modifiedBy = map['ModifiedBy'],
        _modifiedOn = map['ModifiedOn'],
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
      'FinancialYearID': _financialYearID,
      'FinancialYearCode': _financialYearCode,
      'FinancialYearName': _financialYearName,
      'ActualFinancialYear': _actualFinancialYear,
      'FinancialYearStartDate': _financialYearStartDate,
      'FinancialYearEndDate': _financialYearEndDate,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
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
