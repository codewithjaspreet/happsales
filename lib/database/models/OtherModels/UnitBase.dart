import 'package:happsales_crm/database/models/BaseEntity.dart';

class UnitBase extends BaseEntity {
  String? _unitID;
  String? _unitCode;
  String? _unitName;
  String? _shortForm;
  String? _numberSystemBase;
  String? _parentUnitID;
  String? _conversionFactor;
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
  String? _parentUnitName;
  String? _appUserName;
  String? _appUserGroupName;

  
  UnitBase();

  String? get unitID => _unitID;
  set unitID(String? unitID) => _unitID = unitID;

  String? get unitCode => _unitCode;
  set unitCode(String? unitCode) => _unitCode = unitCode;

  String? get unitName => _unitName;
  set unitName(String? unitName) => _unitName = unitName;

  String? get shortForm => _shortForm;
  set shortForm(String? shortForm) => _shortForm = shortForm;

  String? get numberSystemBase => _numberSystemBase;
  set numberSystemBase(String? numberSystemBase) =>
      _numberSystemBase = numberSystemBase;

  String? get parentUnitID => _parentUnitID;
  set parentUnitID(String? parentUnitID) => _parentUnitID = parentUnitID;

  String? get conversionFactor => _conversionFactor;
  set conversionFactor(String? conversionFactor) =>
      _conversionFactor = conversionFactor;

  String? get createdOn => _createdOn;
  set createdOn(String? createdOn) => _createdOn = createdOn;

  String? get createdBy => _createdBy;
  set createdBy(String? createdBy) => _createdBy = createdBy;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? modifiedOn) => _modifiedOn = modifiedOn;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? modifiedBy) => _modifiedBy = modifiedBy;

  String? get isActive => _isActive;
  set isActive(String? isActive) => _isActive = isActive;

  String? get uid => _uid;
  set uid(String? uid) => _uid = uid;

  String? get appUserID => _appUserID;
  set appUserID(String? appUserID) => _appUserID = appUserID;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? appUserGroupID) =>
      _appUserGroupID = appUserGroupID;

  String? get isArchived => _isArchived;
  set isArchived(String? isArchived) => _isArchived = isArchived;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? isDeleted) => _isDeleted = isDeleted;

  String? get parentUnitName => _parentUnitName;
  set parentUnitName(String? parentUnitName) =>
      _parentUnitName = parentUnitName;

  String? get appUserName => _appUserName;
  set appUserName(String? appUserName) => _appUserName = appUserName;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? appUserGroupName) =>
      _appUserGroupName = appUserGroupName;

  Map<String, dynamic> toMap() {
    return {
      'UnitID': _unitID,
      'UnitCode': _unitCode,
      'UnitName': _unitName,
      'ShortForm': _shortForm,
      'NumberSystemBase': _numberSystemBase,
      'ParentUnitID': _parentUnitID,
      'ConversionFactor': _conversionFactor,
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
      'ParentUnitName': _parentUnitName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
//FROMAP

  UnitBase.fromMap(Map<String, dynamic> map) {
    _unitID = map['UnitID'];
    _unitCode = map['UnitCode'];
    _unitName = map['UnitName'];
    _shortForm = map['ShortForm'];
    _numberSystemBase = map['NumberSystemBase'];
    _parentUnitID = map['ParentUnitID'];
    _conversionFactor = map['ConversionFactor'];
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
    _parentUnitName = map['ParentUnitName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
