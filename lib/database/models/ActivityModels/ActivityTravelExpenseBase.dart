import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityTravelExpenseBase extends BaseEntity {
  String? _activityTravelExpenseID;
  String? _activityTravelExpenseCode;
  String? _activityTravelExpenseTitle;
  String? _activityTravelID;
  String? _expenseTypeID;
  String? _distanceTravelled;
  String? _modeOfTravelID;
  String? _amount;
  String? _remarks;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _location;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;

     String? _ActivityTravelTitle;
     String? _ExpenseTypeName;
     String? _ModeOfTravelName;

     // getters and setters of these 3
      String? get ActivityTravelTitle => _ActivityTravelTitle;
      String? get ExpenseTypeName => _ExpenseTypeName;
      String? get ModeOfTravelName => _ModeOfTravelName;

      set ActivityTravelTitle(String? ActivityTravelTitle) => _ActivityTravelTitle = ActivityTravelTitle;
      set ExpenseTypeName(String? ExpenseTypeName) => _ExpenseTypeName = ExpenseTypeName;
      set ModeOfTravelName(String? ModeOfTravelName) => _ModeOfTravelName = ModeOfTravelName;

  ActivityTravelExpenseBase();

  String? get activityTravelExpenseID => _activityTravelExpenseID;
  set activityTravelExpenseID(String? value) => _activityTravelExpenseID = value;

  String? get activityTravelExpenseCode => _activityTravelExpenseCode;
  set activityTravelExpenseCode(String? value) => _activityTravelExpenseCode = value;

  String? get activityTravelExpenseTitle => _activityTravelExpenseTitle;
  set activityTravelExpenseTitle(String? value) => _activityTravelExpenseTitle = value;

  String? get activityTravelID => _activityTravelID;
  set activityTravelID(String? value) => _activityTravelID = value;

  String? get expenseTypeID => _expenseTypeID;
  set expenseTypeID(String? value) => _expenseTypeID = value;

  String? get distanceTravelled => _distanceTravelled;
  set distanceTravelled(String? value) => _distanceTravelled = value;

  String? get modeOfTravelID => _modeOfTravelID;
  set modeOfTravelID(String? value) => _modeOfTravelID = value;

  String? get amount => _amount;
  set amount(String? value) => _amount = value;

  String? get remarks => _remarks;
  set remarks(String? value) => _remarks = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get deviceIdentifier => _deviceIdentifier;
  set deviceIdentifier(String? value) => _deviceIdentifier = value;

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) => _referenceIdentifier = value;

  String? get location => _location;
  set location(String? value) => _location = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  Map<String?, dynamic> toMap() {
    return {
      'ActivityTravelExpenseID': _activityTravelExpenseID,
      'ActivityTravelExpenseCode': _activityTravelExpenseCode,
      'ActivityTravelExpenseTitle': _activityTravelExpenseTitle,
      'ActivityTravelID': _activityTravelID,
      'ExpenseTypeID': _expenseTypeID,
      'DistanceTravelled': _distanceTravelled,
      'ModeOfTravelID': _modeOfTravelID,
      'Amount': _amount,
      'Remarks': _remarks,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'DeviceIdentifier': _deviceIdentifier,
      'ReferenceIdentifier': _referenceIdentifier,
      'Location': _location,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,

      'ActivityTravelTitle': _ActivityTravelTitle,
      'ExpenseTypeName': _ExpenseTypeName,
      'ModeOfTravelName': _ModeOfTravelName,

    };
  }

  ActivityTravelExpenseBase.fromMapObject(Map<String,dynamic> map){

    _activityTravelExpenseID = map['ActivityTravelExpenseID'];
    _activityTravelExpenseCode = map['ActivityTravelExpenseCode'];
    _activityTravelExpenseTitle = map['ActivityTravelExpenseTitle'];
    _activityTravelID = map['ActivityTravelID'];
    _expenseTypeID = map['ExpenseTypeID'];
    _distanceTravelled = map['DistanceTravelled'];
    _modeOfTravelID = map['ModeOfTravelID'];
    _amount = map['Amount'];
    _remarks = map['Remarks'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _location = map['Location'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];

    _ActivityTravelTitle = map['ActivityTravelTitle'];
    _ExpenseTypeName = map['ExpenseTypeName'];
    _ModeOfTravelName = map['ModeOfTravelName'];
    
  }

}
