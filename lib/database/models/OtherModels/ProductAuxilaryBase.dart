import 'package:happsales_crm/database/models/BaseEntity.dart';

class ProductAuxiliaryBase extends BaseEntity {
  String? _productAuxiliaryID;
  String? _productAuxiliaryCode;
  String? _productID;
  String? _auxiliaryProductID;
  String? _quantity;
  String? _price;
  String? _isPriceIncludesTax;
  String? _sequentialOrder;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;

  String? _productName;
  String? _auxiliaryProductName;
  String? _appUserName;
  String? _appUserGroupName;


ProductAuxiliaryBase();
  String? get productAuxiliaryID => _productAuxiliaryID;
  set productAuxiliaryID(String? value) {
    _productAuxiliaryID = value;
  }

  String? get productAuxiliaryCode => _productAuxiliaryCode;
  set productAuxiliaryCode(String? value) {
    _productAuxiliaryCode = value;
  }

  String? get productID => _productID;
  set productID(String? value) {
    _productID = value;
  }

  String? get auxiliaryProductID => _auxiliaryProductID;
  set auxiliaryProductID(String? value) {
    _auxiliaryProductID = value;
  }

  String? get quantity => _quantity;
  set quantity(String? value) {
    _quantity = value;
  }

  String? get price => _price;
  set price(String? value) {
    _price = value;
  }

  String? get isPriceIncludesTax => _isPriceIncludesTax;
  set isPriceIncludesTax(String? value) {
    _isPriceIncludesTax = value;
  }

  String? get sequentialOrder => _sequentialOrder;
  set sequentialOrder(String? value) {
    _sequentialOrder = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
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

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get productName => _productName;
  set productName(String? value) {
    _productName = value;
  }

  String? get auxiliaryProductName => _auxiliaryProductName;
  set auxiliaryProductName(String? value) {
    _auxiliaryProductName = value;
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
      'ProdutAuxiliaryID': _productAuxiliaryID,
      'ProdutAuxiliaryCode': _productAuxiliaryCode,
      'ProductID': _productID,
      'AuxiliaryProductID': _auxiliaryProductID,
      'Quantity': _quantity,
      'Price': _price,
      'IsPriceIncludesTax': _isPriceIncludesTax,
      'SequentialOrder': _sequentialOrder,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
    };
  }

  ProductAuxiliaryBase.fromMapObject(Map<String, dynamic> map) {
    _productAuxiliaryID = map['ProdutAuxiliaryID'];
    _productAuxiliaryCode = map['ProdutAuxiliaryCode'];
    _productID = map['ProductID'];
    _auxiliaryProductID = map['AuxiliaryProductID'];
    _quantity = map['Quantity'];
    _price = map['Price'];
    _isPriceIncludesTax = map['IsPriceIncludesTax'];
    _sequentialOrder = map['SequentialOrder'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];

  }
}
