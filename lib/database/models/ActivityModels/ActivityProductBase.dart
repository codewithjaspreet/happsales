import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityProductBase extends BaseEntity {
  String? _activityProductID;
  String? _activityProductCode;
  String? _activityID;
  String? _productID;
  String? _price;
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
  String? _activityTitle;
  String? _productName;
  String? _appUserName;
  String? _appUserGroupName;

  String? get activityProductID => _activityProductID;
  set activityProductID(String? value) => _activityProductID = value;

  String? get activityProductCode => _activityProductCode;
  set activityProductCode(String? value) => _activityProductCode = value;

  String? get activityID => _activityID;
  set activityID(String? value) => _activityID = value;

  String? get productID => _productID;
  set productID(String? value) => _productID = value;

  String? get price => _price;
  set price(String? value) => _price = value;

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

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) => _activityTitle = value;

  String? get productName => _productName;
  set productName(String? value) => _productName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  ActivityProductBase();

  ActivityProductBase.fromMapObject(Map<String, dynamic> map) {
    _activityProductID = map['ActivityProductID'];
    _activityProductCode = map['ActivityProductCode'];
    _activityID = map['ActivityID'];
    _productID = map['ProductID'];
    _price = map['Price'];
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
    _activityTitle = map['ActivityTitle'];
    _productName = map['ProductName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityProductID': _activityProductID,
      'ActivityProductCode': _activityProductCode,
      'ActivityID': _activityID,
      'ProductID': _productID,
      'Price': _price,
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
      'ActivityTitle': _activityTitle,
      'ProductName': _productName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
