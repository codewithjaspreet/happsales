import 'package:happsales_crm/database/models/BaseEntity.dart';

class ProductInstallationDetailBase extends  BaseEntity{
  String? _productInstallationDetailID;
  String? _productInstallationDetailCode;
  String? _productInstallationID;
  String? _productID;
  String? _serialNumber;
  String? _partNumber;
  String? _model;
  String? _dateOfManufacture;
  String? _applicationOfProduct;
  String? _dateOfCommissioning;
  String? _lifeTimeInHours;
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

  ProductInstallationDetailBase();

  String? get productInstallationDetailID => _productInstallationDetailID;
  set productInstallationDetailID(String? value) {
    _productInstallationDetailID = value;
  }

  String? get productInstallationDetailCode => _productInstallationDetailCode;
  set productInstallationDetailCode(String? value) {
    _productInstallationDetailCode = value;
  }

  String? get productInstallationID => _productInstallationID;
  set productInstallationID(String? value) {
    _productInstallationID = value;
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

  String? get applicationOfProduct => _applicationOfProduct;
  set applicationOfProduct(String? value) {
    _applicationOfProduct = value;
  }

  String? get dateOfCommissioning => _dateOfCommissioning;
  set dateOfCommissioning(String? value) {
    _dateOfCommissioning = value;
  }

  String? get lifeTimeInHours => _lifeTimeInHours;
  set lifeTimeInHours(String? value) {
    _lifeTimeInHours = value;
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

  Map<String, dynamic> toMap() {
    return {
      'ProductInstallationDetailID': _productInstallationDetailID,
      'ProductInstallationDetailCode': _productInstallationDetailCode,
      'ProductInstallationID': _productInstallationID,
      'ProductID': _productID,
      'SerialNumber': _serialNumber,
      'PartNumber': _partNumber,
      'Model': _model,
      'DateOfManufacture': _dateOfManufacture,
      'ApplicationOfProduct': _applicationOfProduct,
      'DateOfCommissioning': _dateOfCommissioning,
      'LifeTimeInHours': _lifeTimeInHours,
      'UsageHoursPerWeek': _usageHoursPerWeek,
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
      'ReferenceIdentifier': _referenceIdentifier,
    };
  }

  ProductInstallationDetailBase.fromMapObject(Map<String, dynamic> map) {
    _productInstallationDetailID = map['ProductInstallationDetailID'];
    _productInstallationDetailCode = map['ProductInstallationDetailCode'];
    _productInstallationID = map['ProductInstallationID'];
    _productID = map['ProductID'];
    _serialNumber = map['SerialNumber'];
    _partNumber = map['PartNumber'];
    _model = map['Model'];
    _dateOfManufacture = map['DateOfManufacture'];
    _applicationOfProduct = map['ApplicationOfProduct'];
    _dateOfCommissioning = map['DateOfCommissioning'];
    _lifeTimeInHours = map['LifeTimeInHours'];
    _usageHoursPerWeek = map['UsageHoursPerWeek'];
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
    _referenceIdentifier = map['ReferenceIdentifier'];

  }
}
