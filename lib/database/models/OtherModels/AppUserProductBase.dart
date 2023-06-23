import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUserProductBase extends BaseEntity{
  String? _appUserProductID;
  String? _appUserProductCode;
  String? _appUserID;
  String? _productID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _productName;
  String? _appUserGroupName;


AppUserProductBase();
  String? get appUserProductID => _appUserProductID;
  set appUserProductID(String? value) {
    _appUserProductID = value;
  }

  String? get appUserProductCode => _appUserProductCode;
  set appUserProductCode(String? value) {
    _appUserProductCode = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get productID => _productID;
  set productID(String? value) {
    _productID = value;
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

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get productName => _productName;
  set productName(String? value) {
    _productName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'AppUserProductID': _appUserProductID,
      'AppUserProductCode': _appUserProductCode,
      'AppUserID': _appUserID,
      'ProductID': _productID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'ProductName': _productName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

   AppUserProductBase.fromMap(Map<String, dynamic> map) {
      _appUserProductID = map['AppUserProductID']; 
      _appUserProductCode = map['AppUserProductCode']; 
      _appUserID = map['AppUserID']; 
      _productID = map['ProductID']; 
      _createdBy = map['CreatedBy']; 
      _createdOn = map['CreatedOn']; 
      _modifiedBy = map['ModifiedBy']; 
      _modifiedOn = map['ModifiedOn']; 
      _isActive = map['IsActive']; 
      _uid = map['Uid']; 
      _appUserGroupID = map['AppUserGroupID']; 
      _isArchived = map['IsArchived']; 
      _isDeleted = map['IsDeleted']; 
      _appUserName = map['AppUserName']; 
      _productName = map['ProductName']; 
      _appUserGroupName = map['AppUserGroupName']; ;
  }
}
