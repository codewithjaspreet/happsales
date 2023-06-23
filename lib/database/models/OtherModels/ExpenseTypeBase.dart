import 'package:happsales_crm/database/models/BaseEntity.dart';

class ExpenseTypeBase extends BaseEntity {
  String? _expenseTypeID;
  String? _expenseTypeCode;
  String? _expenseTypeName;
  String? _isTravelRequired;
  String? _calculateDistanceTravelled;
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

ExpenseTypeBase();
  String? get expenseTypeID => _expenseTypeID;
  String? get expenseTypeCode => _expenseTypeCode;
  String? get expenseTypeName => _expenseTypeName;
  String? get isTravelRequired => _isTravelRequired;
  String? get calculateDistanceTravelled => _calculateDistanceTravelled;
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

  ExpenseTypeBase.fromMap(Map<String, dynamic> map)
      : _expenseTypeID = map['ExpenseTypeID'],
        _expenseTypeCode = map['ExpenseTypeCode'],
        _expenseTypeName = map['ExpenseTypeName'],
        _isTravelRequired = map['IsTravelRequired'],
        _calculateDistanceTravelled = map['CalculateDistanceTravelled'],
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
      'ExpenseTypeID': _expenseTypeID,
      'ExpenseTypeCode': _expenseTypeCode,
      'ExpenseTypeName': _expenseTypeName,
      'IsTravelRequired': _isTravelRequired,
      'CalculateDistanceTravelled': _calculateDistanceTravelled,
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
