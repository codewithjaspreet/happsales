import 'package:happsales_crm/database/models/BaseEntity.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/BusinessUnits/business_unit.dart';

class BusinessUnitBase extends BaseEntity {
  String? _businessUnitID;
  String? _businessUnitCode;
  String? _businessUnitName;
  String? _description;
  String? _headOfBusinessUnitAppUserID;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _isDeleted;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _referenceIdentifier;

  String? _headOfBusinessUnitAppUserName;
  String? _appUserName;
  String? _appUserGroupName;


BusinessUnitBase();
  // BusinessUnitID
  String? get businessUnitID => _businessUnitID;
  set businessUnitID(String? value) {
    _businessUnitID = value;
  }

  // BusinessUnitCode
  String? get businessUnitCode => _businessUnitCode;
  set businessUnitCode(String? value) {
    _businessUnitCode = value;
  }

  // BusinessUnitName
  String? get businessUnitName => _businessUnitName;
  set businessUnitName(String? value) {
    _businessUnitName = value;
  }

  // Description
  String? get description => _description;
  set description(String? value) {
    _description = value;
  }

  // HeadOfBusinessUnitAppUserID
  String? get headOfBusinessUnitAppUserID => _headOfBusinessUnitAppUserID;
  set headOfBusinessUnitAppUserID(String? value) {
    _headOfBusinessUnitAppUserID = value;
  }

  // CreatedOn
  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  // CreatedBy
  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  // ModifiedOn
  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  // ModifiedBy
  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  // IsActive
  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  // IsDeleted
  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  // Uid
  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  // AppUserID
  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  // AppUserGroupID
  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  // ReferenceIdentifier
  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) {
    _referenceIdentifier = value;
  }

  // HeadOfBusinessUnitAppUserName
  String? get headOfBusinessUnitAppUserName => _headOfBusinessUnitAppUserName;
  set headOfBusinessUnitAppUserName(String? value) {
    _headOfBusinessUnitAppUserName = value;
  }

  // AppUserName
  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  // AppUserGroupName
  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'BusinessUnitID': businessUnitID,
      'BusinessUnitCode': businessUnitCode,
      'BusinessUnitName': businessUnitName,
      'Description': description,
      'HeadOfBusinessUnitAppUserID': headOfBusinessUnitAppUserID,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'IsDeleted': isDeleted,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'ReferenceIdentifier': referenceIdentifier,
      'HeadOfBusinessUnitAppUserName': headOfBusinessUnitAppUserName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   BusinessUnitBase.fromMap(Map<String, dynamic> map) {
    _businessUnitID = map['BusinessUnitID'];
    _businessUnitCode = map['BusinessUnitCode'];
    _businessUnitName = map['BusinessUnitName'];
    _description = map['Description'];
    _headOfBusinessUnitAppUserID = map['HeadOfBusinessUnitAppUserID'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _isDeleted = map['IsDeleted'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _headOfBusinessUnitAppUserName = map['HeadOfBusinessUnitAppUserName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
