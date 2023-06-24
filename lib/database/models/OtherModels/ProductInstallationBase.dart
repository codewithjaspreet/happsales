import 'package:happsales_crm/database/models/BaseEntity.dart';

class ProductInstallationBase extends BaseEntity {
  String? _productInstallationID;
  String? _productInstallationCode;
  String? _installationIdentifier;
  String? _accountID;
  String? _contactID;
  String? _productID;
  String? _serialNumber;
  String? _partNumber;
  String? _model;
  String? _dateOfManufacture;
  String? _locationUnit;
  String? _locationAddress;
  String? _dateOfCommissioning;
  String? _applicationOfProduct;
  String? _warrantyEndDate;
  String? _usageHoursPerWeek;
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
  String? _referenceIdentifier;

  String? _accountName;
  String? _contactName;
  String? _productName;
  String? _appUserName;
  String? _appUserGroupName;

  ProductInstallationBase();

  String? get productInstallationID => _productInstallationID;
  set productInstallationID(String? value) {
    _productInstallationID = value;
  }

  String? get productInstallationCode => _productInstallationCode;
  set productInstallationCode(String? value) {
    _productInstallationCode = value;
  }

  String? get installationIdentifier => _installationIdentifier;
  set installationIdentifier(String? value) {
    _installationIdentifier = value;
  }

  String? get accountID => _accountID;
  set accountID(String? value) {
    _accountID = value;
  }

  String? get contactID => _contactID;
  set contactID(String? value) {
    _contactID = value;
  }

  String? get productID => _productID;
  set productID(String? value) {
    _productID = value;
  }

  String? get serialNumber => _serialNumber;
  set serialNumber(String? value) {
    _serialNumber = value;
  }

  String? get partNumber => _partNumber;
  set partNumber(String? value) {
    _partNumber = value;
  }

  String? get model => _model;
  set model(String? value) {
    _model = value;
  }

  String? get dateOfManufacture => _dateOfManufacture;
  set dateOfManufacture(String? value) {
    _dateOfManufacture = value;
  }

  String? get locationUnit => _locationUnit;
  set locationUnit(String? value) {
    _locationUnit = value;
  }

  String? get locationAddress => _locationAddress;
  set locationAddress(String? value) {
    _locationAddress = value;
  }

  String? get dateOfCommissioning => _dateOfCommissioning;
  set dateOfCommissioning(String? value) {
    _dateOfCommissioning = value;
  }

  String? get applicationOfProduct => _applicationOfProduct;
  set applicationOfProduct(String? value) {
    _applicationOfProduct = value;
  }

  String? get warrantyEndDate => _warrantyEndDate;
  set warrantyEndDate(String? value) {
    _warrantyEndDate = value;
  }

  String? get usageHoursPerWeek => _usageHoursPerWeek;
  set usageHoursPerWeek(String? value) {
    _usageHoursPerWeek = value;
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

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) {
    _referenceIdentifier = value;
  }

  String? get accountName => _accountName;
  set accountName(String? value) {
    _accountName = value;
  }

  String? get contactName => _contactName;
  set contactName(String? value) {
    _contactName = value;
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

  //tomap

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['productInstallationID'] = _productInstallationID;
    map['productInstallationCode'] = _productInstallationCode;
    map['installationIdentifier'] = _installationIdentifier;
    map['accountID'] = _accountID;
    map['contactID'] = _contactID;
    map['productID'] = _productID;
    map['serialNumber'] = _serialNumber;
    map['partNumber'] = _partNumber;
    map['model'] = _model;
    map['dateOfManufacture'] = _dateOfManufacture;
    map['locationUnit'] = _locationUnit;
    map['locationAddress'] = _locationAddress;
    map['dateOfCommissioning'] = _dateOfCommissioning;
    map['applicationOfProduct'] = _applicationOfProduct;
    map['warrantyEndDate'] = _warrantyEndDate;
    map['usageHoursPerWeek'] = _usageHoursPerWeek;
    map['createdOn'] = _createdOn;
    map['createdBy'] = _createdBy;
    map['modifiedOn'] = _modifiedOn;
    map['modifiedBy'] = _modifiedBy;
    map['isActive'] = _isActive;
    map['uid'] = _uid;
    map['appUserID'] = _appUserID;
    map['appUserGroupID'] = _appUserGroupID;
    map['isArchived'] = _isArchived;
    map['isDeleted'] = _isDeleted;
    map['referenceIdentifier'] = _referenceIdentifier;
    map['accountName'] = _accountName;
    map['contactName'] = _contactName;
    map['productName'] = _productName;
    map['appUserName'] = _appUserName;
    map['appUserGroupName'] = _appUserGroupName;
    return map;
  }

  //fromapp

  ProductInstallationBase.fromMapObject(Map<String, dynamic> map) {
    this._productInstallationID = map['productInstallationID'];
    this._productInstallationCode = map['productInstallationCode'];
    this._installationIdentifier = map['installationIdentifier'];
    this._accountID = map['accountID'];
    this._contactID = map['contactID'];
    this._productID = map['productID'];
    this._serialNumber = map['serialNumber'];
    this._partNumber = map['partNumber'];
    this._model = map['model'];
    this._dateOfManufacture = map['dateOfManufacture'];
    this._locationUnit = map['locationUnit'];
    this._locationAddress = map['locationAddress'];
    this._dateOfCommissioning = map['dateOfCommissioning'];
    this._applicationOfProduct = map['applicationOfProduct'];
    this._warrantyEndDate = map['warrantyEndDate'];
    this._usageHoursPerWeek = map['usageHoursPerWeek'];
    this._createdOn = map['createdOn'];
    this._createdBy = map['createdBy'];
    this._modifiedOn = map['modifiedOn'];
    this._modifiedBy = map['modifiedBy'];
    this._isActive = map['isActive'];
    this._uid = map['uid'];
    this._appUserID = map['appUserID'];
    this._appUserGroupID = map['appUserGroupID'];
    this._isArchived = map['isArchived'];
    this._isDeleted = map['isDeleted'];
    this._referenceIdentifier = map['referenceIdentifier'];
    this._accountName = map['accountName'];
    this._contactName = map['contactName'];
    this._productName = map['productName'];
    this._appUserName = map['appUserName'];
    this._appUserGroupName = map['appUserGroupName'];
  }


}
