import 'package:happsales_crm/database/models/BaseEntity.dart';

class ServiceInvoiceBase extends BaseEntity
 {
  String? _serviceInvoiceID;
  String? _serviceInvoiceCode;
  String? _serviceInvoiceTitle;
  String? _serviceInvoiceDate;
  String? _accountID;
  String? _activityID;
  String? _productID;
  String? _barCode;
  String? _isInWarranty;
  String? _productPartsPrice;
  String? _serviceCharge;
  String? _tax;
  String? _totalAmount;
  String? _amountPaid;
  String? _currencyID;
  String? _paymentDate;
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

  String? _accountName;
  String? _activityTitle;
  String? _productName;
  String? _currencyName;
  String? _appUserName;
  String? _appUserGroupName;


ServiceInvoiceBase();
  String? get serviceInvoiceID => _serviceInvoiceID;
  set serviceInvoiceID(String? value) => _serviceInvoiceID = value;

  String? get serviceInvoiceCode => _serviceInvoiceCode;
  set serviceInvoiceCode(String? value) => _serviceInvoiceCode = value;

  String? get serviceInvoiceTitle => _serviceInvoiceTitle;
  set serviceInvoiceTitle(String? value) => _serviceInvoiceTitle = value;

  String? get serviceInvoiceDate => _serviceInvoiceDate;
  set serviceInvoiceDate(String? value) => _serviceInvoiceDate = value;

  String? get accountID => _accountID;
  set accountID(String? value) => _accountID = value;

  String? get activityID => _activityID;
  set activityID(String? value) => _activityID = value;

  String? get productID => _productID;
  set productID(String? value) => _productID = value;

  String? get barCode => _barCode;
  set barCode(String? value) => _barCode = value;

  String? get isInWarranty => _isInWarranty;
  set isInWarranty(String? value) => _isInWarranty = value;

  String? get productPartsPrice => _productPartsPrice;
  set productPartsPrice(String? value) => _productPartsPrice = value;

  String? get serviceCharge => _serviceCharge;
  set serviceCharge(String? value) => _serviceCharge = value;

  String? get tax => _tax;
  set tax(String? value) => _tax = value;

  String? get totalAmount => _totalAmount;
  set totalAmount(String? value) => _totalAmount = value;

  String? get amountPaid => _amountPaid;
  set amountPaid(String? value) => _amountPaid = value;

  String? get currencyID => _currencyID;
  set currencyID(String? value) => _currencyID = value;

  String? get paymentDate => _paymentDate;
  set paymentDate(String? value) => _paymentDate = value;

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

  String? get accountName => _accountName;
  set accountName(String? value) => _accountName = value;

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) => _activityTitle = value;

  String? get productName => _productName;
  set productName(String? value) => _productName = value;

  String? get currencyName => _currencyName;
  set currencyName(String? value) => _currencyName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

    

    // tomap

    Map<String, dynamic> toMap() {
      var map = Map<String, dynamic>();
      map["ServiceInvoiceID"] = _serviceInvoiceID;
      map["ServiceInvoiceCode"] = _serviceInvoiceCode;
      map["ServiceInvoiceTitle"] = _serviceInvoiceTitle;
      map["ServiceInvoiceDate"] = _serviceInvoiceDate;
      map["AccountID"] = _accountID;
      map["ActivityID"] = _activityID;
      map["ProductID"] = _productID;
      map["BarCode"] = _barCode;
      map["IsInWarranty"] = _isInWarranty;
      map["ProductPartsPrice"] = _productPartsPrice;
      map["ServiceCharge"] = _serviceCharge;
      map["Tax"] = _tax;
      map["TotalAmount"] = _totalAmount;
      map["AmountPaid"] = _amountPaid;
      map["CurrencyID"] = _currencyID;
      map["PaymentDate"] = _paymentDate;
      map["CreatedBy"] = _createdBy;
      map["CreatedOn"] = _createdOn;
      map["ModifiedBy"] = _modifiedBy;
      map["ModifiedOn"] = _modifiedOn;
      map["IsActive"] = _isActive;
      map["UID"] = _uid;
      map["AppUserID"] = _appUserID;
      map["AppUserGroupID"] = _appUserGroupID;
      map["IsArchived"] = _isArchived;
      map["IsDeleted"] = _isDeleted;
      map["AccountName"] = _accountName;
      map["ActivityTitle"] = _activityTitle;
      map["ProductName"] = _productName;
      map["CurrencyName"] = _currencyName;
      map["AppUserName"] = _appUserName;
      map["AppUserGroupName"] = _appUserGroupName;
      return map;
    }


    //frommap

    ServiceInvoiceBase.fromMap(Map<String, dynamic> map) {
      _serviceInvoiceID = map["ServiceInvoiceID"];
      _serviceInvoiceCode = map["ServiceInvoiceCode"];
      _serviceInvoiceTitle = map["ServiceInvoiceTitle"];
      _serviceInvoiceDate = map["ServiceInvoiceDate"];
      _accountID = map["AccountID"];
      _activityID = map["ActivityID"];
      _productID = map["ProductID"];
      _barCode = map["BarCode"];
      _isInWarranty = map["IsInWarranty"];
      _productPartsPrice = map["ProductPartsPrice"];
      _serviceCharge = map["ServiceCharge"];
      _tax = map["Tax"];
      _totalAmount = map["TotalAmount"];
      _amountPaid = map["AmountPaid"];
      _currencyID = map["CurrencyID"];
      _paymentDate = map["PaymentDate"];
      _createdBy = map["CreatedBy"];
      _createdOn = map["CreatedOn"];
      _modifiedBy = map["ModifiedBy"];
      _modifiedOn = map["ModifiedOn"];
      _isActive = map["IsActive"];
      _uid = map["UID"];
      _appUserID = map["AppUserID"];
      _appUserGroupID = map["AppUserGroupID"];
      _isArchived = map["IsArchived"];
      _isDeleted = map["IsDeleted"];
      _accountName = map["AccountName"];
      _activityTitle = map["ActivityTitle"];
      _productName = map["ProductName"];
      _currencyName = map["CurrencyName"];
      _appUserName = map["AppUserName"];
      _appUserGroupName = map["AppUserGroupName"];

    }
  }
  