import 'package:happsales_crm/database/models/BaseEntity.dart';

class ServiceInvoiceDetailBase extends BaseEntity {
  String? _serviceInvoiceDetailID;
  String? _serviceInvoiceDetailCode;
  String? _productPartBarCode;
  String? _serviceInvoiceID;
  String? _productID;
  String? _quantity;
  String? _rate;
  String? _price;
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

  String? _serviceInvoiceTitle;
  String? _productName;
  String? _appUserName;
  String? _appUserGroupName;
  ServiceInvoiceDetailBase();
 
  String? get serviceInvoiceDetailID => _serviceInvoiceDetailID;
  set serviceInvoiceDetailID(String? value) {
    _serviceInvoiceDetailID = value;
  }

  String? get serviceInvoiceDetailCode => _serviceInvoiceDetailCode;
  set serviceInvoiceDetailCode(String? value) {
    _serviceInvoiceDetailCode = value;
  }

  String? get productPartBarCode => _productPartBarCode;
  set productPartBarCode(String? value) {
    _productPartBarCode = value;
  }

  String? get serviceInvoiceID => _serviceInvoiceID;
  set serviceInvoiceID(String? value) {
    _serviceInvoiceID = value;
  }

  String? get productID => _productID;
  set productID(String? value) {
    _productID = value;
  }

  String? get quantity => _quantity;
  set quantity(String? value) {
    _quantity = value;
  }

  String? get rate => _rate;
  set rate(String? value) {
    _rate = value;
  }

  String? get price => _price;
  set price(String? value) {
    _price = value;
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

  String? get serviceInvoiceTitle => _serviceInvoiceTitle;
  set serviceInvoiceTitle(String? value) {
    _serviceInvoiceTitle = value;
  }

  String? get productName => _productName;
  set productName(String? value) {
    _productName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }
  
  Map<String, dynamic> toJson() {
    return {
      'ServiceInvoiceDetailID': serviceInvoiceDetailID,
      'ServiceInvoiceDetailCode': serviceInvoiceDetailCode,
      'ProductPartBarCode': productPartBarCode,
      'ServiceInvoiceID': serviceInvoiceID,
      'ProductID': productID,
      'Quantity': quantity,
      'Rate': rate,
      'Price': price,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'ServiceInvoiceTitle': serviceInvoiceTitle,
      'ProductName': productName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
