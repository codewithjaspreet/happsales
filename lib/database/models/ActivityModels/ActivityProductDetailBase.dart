import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityProductDetailBase extends BaseEntity {
  String? _activityProductDetailID;
  String? _activityProductDetailCode;
  String? _activityProductID;
  String? _attribute;
  String? _price;
  String? _quantity;
  String? _amount;
  String? _remarks;
  String? _supplierAccountID;
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
  String? _referenceIdentifier;
  String? _activityProductCode;
  String? _supplierAccountName;
  String? _appUserName;
  String? _appUserGroupName;


ActivityProductDetailBase();
  String? get activityProductDetailID => _activityProductDetailID;
  set activityProductDetailID(String? value) =>
      _activityProductDetailID = value;

  String? get activityProductDetailCode => _activityProductDetailCode;
  set activityProductDetailCode(String? value) =>
      _activityProductDetailCode = value;

  String? get activityProductID => _activityProductID;
  set activityProductID(String? value) => _activityProductID = value;

  String? get attribute => _attribute;
  set attribute(String? value) => _attribute = value;

  String? get price => _price;
  set price(String? value) => _price = value;

  String? get quantity => _quantity;
  set quantity(String? value) => _quantity = value;

  String? get amount => _amount;
  set amount(String? value) => _amount = value;

  String? get remarks => _remarks;
  set remarks(String? value) => _remarks = value;

  String? get supplierAccountID => _supplierAccountID;
  set supplierAccountID(String? value) => _supplierAccountID = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

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

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) => _referenceIdentifier = value;

  String? get activityProductCode => _activityProductCode;
  set activityProductCode(String? value) => _activityProductCode = value;

  String? get supplierAccountName => _supplierAccountName;
  set supplierAccountName(String? value) => _supplierAccountName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;


  ActivityProductDetailBase.fromMapObject(Map<String, dynamic> map) {
    _activityProductDetailID = map['ActivityProductDetailID'];
    _activityProductDetailCode = map['ActivityProductDetailCode'];
    _activityProductID = map['ActivityProductID'];
    _attribute = map['Attribute'];
    _price = map['Price'];
    _quantity = map['Quantity'];
    _amount = map['Amount'];
    _remarks = map['Remarks'];
    _supplierAccountID = map['SupplierAccountID'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _activityProductCode = map['ActivityProductCode'];
    _supplierAccountName = map['SupplierAccountName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityProductDetailID': _activityProductDetailID,
      'ActivityProductDetailCode': _activityProductDetailCode,
      'ActivityProductID': _activityProductID,
      'Attribute': _attribute,
      'Price': _price,
      'Quantity': _quantity,
      'Amount': _amount,
      'Remarks': _remarks,
      'SupplierAccountID': _supplierAccountID,
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
      'ReferenceIdentifier': _referenceIdentifier,
      'ActivityProductCode': _activityProductCode,
      'SupplierAccountName': _supplierAccountName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
