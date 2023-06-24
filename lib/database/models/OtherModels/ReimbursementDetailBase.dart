import 'package:happsales_crm/database/models/BaseEntity.dart';

class ReimbursementDetailBase extends BaseEntity {
  String? _reimbursementDetailID;
  String? _reimbursementDetailCode;
  String? _reimbursementDetailTitle;
  String? _billNumber;
  String? _billDate;
  String? _amount;
  String? _reimbursementID;
  String? _reimbursementTypeID;
  String? _activityID;
  String? _activityTravelID;
  String? _description;
  String? _documentPath;
  String? _documentContent;
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

  String? _reimbursementTitle;
  String? _reimbursementTypeName;
  String? _activityTitle;
  String? _activityTravelTitle;
  String? _appUserName;
  String? _appUserGroupName;

  ReimbursementDetailBase();

  String? get reimbursementDetailID => _reimbursementDetailID;
  set reimbursementDetailID(String? value) {
    _reimbursementDetailID = value;
  }

  String? get reimbursementDetailCode => _reimbursementDetailCode;
  set reimbursementDetailCode(String? value) {
    _reimbursementDetailCode = value;
  }

  String? get reimbursementDetailTitle => _reimbursementDetailTitle;
  set reimbursementDetailTitle(String? value) {
    _reimbursementDetailTitle = value;
  }

  String? get billNumber => _billNumber;
  set billNumber(String? value) {
    _billNumber = value;
  }

  String? get billDate => _billDate;
  set billDate(String? value) {
    _billDate = value;
  }

  String? get amount => _amount;
  set amount(String? value) {
    _amount = value;
  }

  String? get reimbursementID => _reimbursementID;
  set reimbursementID(String? value) {
    _reimbursementID = value;
  }

  String? get reimbursementTypeID => _reimbursementTypeID;
  set reimbursementTypeID(String? value) {
    _reimbursementTypeID = value;
  }

  String? get activityID => _activityID;
  set activityID(String? value) {
    _activityID = value;
  }

  String? get activityTravelID => _activityTravelID;
  set activityTravelID(String? value) {
    _activityTravelID = value;
  }

  String? get description => _description;
  set description(String? value) {
    _description = value;
  }

  String? get documentPath => _documentPath;
  set documentPath(String? value) {
    _documentPath = value;
  }

  String? get documentContent => _documentContent;
  set documentContent(String? value) {
    _documentContent = value;
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

  String? get reimbursementTitle => _reimbursementTitle;
  set reimbursementTitle(String? value) {
    _reimbursementTitle = value;
  }

  String? get reimbursementTypeName => _reimbursementTypeName;
  set reimbursementTypeName(String? value) {
    _reimbursementTypeName = value;
  }

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) {
    _activityTitle = value;
  }

  String? get activityTravelTitle => _activityTravelTitle;
  set activityTravelTitle(String? value) {
    _activityTravelTitle = value;
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
      'ReimbursementDetailID': _reimbursementDetailID,
      'ReimbursementDetailCode': _reimbursementDetailCode,
      'ReimbursementDetailTitle': _reimbursementDetailTitle,
      'BillNumber': _billNumber,
      'BillDate': _billDate,
      'Amount': _amount,
      'ReimbursementID': _reimbursementID,
      'ReimbursementTypeID': _reimbursementTypeID,
      'ActivityID': _activityID,
      'ActivityTravelID': _activityTravelID,
      'Description': _description,
      'DocumentPath': _documentPath,
      'DocumentContent': _documentContent,
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

  ReimbursementDetailBase.fromMapObject(Map<String, dynamic> map) {
    _reimbursementDetailID = map['ReimbursementDetailID'];
    _reimbursementDetailCode = map['ReimbursementDetailCode'];
    _reimbursementDetailTitle = map['ReimbursementDetailTitle'];
    _billNumber = map['BillNumber'];
    _billDate = map['BillDate'];
    _amount = map['Amount'];
    _reimbursementID = map['ReimbursementID'];
    _reimbursementTypeID = map['ReimbursementTypeID'];
    _activityID = map['ActivityID'];
    _activityTravelID = map['ActivityTravelID'];
    _description = map['Description'];
    _documentPath = map['DocumentPath'];
    _documentContent = map['DocumentContent'];
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
