import 'package:happsales_crm/database/models/BaseEntity.dart';

class ReimbursementBase extends BaseEntity {
  String? _reimbursementID;
  String? _reimbursementCode;
  String? _reimbursementTitle;
  String? _reimbursementDate;
  String? _voucherNumber;
  String? _description;
  String? _amount;
  String? _isPaid;
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

  ReimbursementBase();

  String? get reimbursementID => _reimbursementID;
  set reimbursementID(String? value) {
    _reimbursementID = value;
  }

  String? get reimbursementCode => _reimbursementCode;
  set reimbursementCode(String? value) {
    _reimbursementCode = value;
  }

  String? get reimbursementTitle => _reimbursementTitle;
  set reimbursementTitle(String? value) {
    _reimbursementTitle = value;
  }

  String? get reimbursementDate => _reimbursementDate;
  set reimbursementDate(String? value) {
    _reimbursementDate = value;
  }

  String? get voucherNumber => _voucherNumber;
  set voucherNumber(String? value) {
    _voucherNumber = value;
  }

  String? get description => _description;
  set description(String? value) {
    _description = value;
  }

  String? get amount => _amount;
  set amount(String? value) {
    _amount = value;
  }

  String? get isPaid => _isPaid;
  set isPaid(String? value) {
    _isPaid = value;
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
      'ReimbursementID': _reimbursementID,
      'ReimbursementCode': _reimbursementCode,
      'ReimbursementTitle': _reimbursementTitle,
      'ReimbursementDate': _reimbursementDate,
      'VoucherNumber': _voucherNumber,
      'Description': _description,
      'Amount': _amount,
      'IsPaid': _isPaid,
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
    };
  }

  ReimbursementBase.fromMapObject(Map<String, dynamic> map) {
    _reimbursementID = map['ReimbursementID'];
    _reimbursementCode = map['ReimbursementCode'];
    _reimbursementTitle = map['ReimbursementTitle'];
    _reimbursementDate = map['ReimbursementDate'];
    _voucherNumber = map['VoucherNumber'];
    _description = map['Description'];
    _amount = map['Amount'];
    _isPaid = map['IsPaid'];
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

  }
}
