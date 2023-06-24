import 'package:happsales_crm/database/models/BaseEntity.dart';

class ProductCategoryBase extends BaseEntity {
  String? _productCategoryID;
  String? _productCategoryCode;
  String? _productCategoryName;
  String? _description;
  String? _parentProductCategoryID;
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

  String? _parentProductCategoryName;
  String? _appUserName;
  String? _appUserGroupName;


ProductCategoryBase();
  String? get productCategoryID => _productCategoryID;
  set productCategoryID(String? value) {
    _productCategoryID = value;
  }

  String? get productCategoryCode => _productCategoryCode;
  set productCategoryCode(String? value) {
    _productCategoryCode = value;
  }

  String? get productCategoryName => _productCategoryName;
  set productCategoryName(String? value) {
    _productCategoryName = value;
  }

  String? get description => _description;
  set description(String? value) {
    _description = value;
  }

  String? get parentProductCategoryID => _parentProductCategoryID;
  set parentProductCategoryID(String? value) {
    _parentProductCategoryID = value;
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

  String? get parentProductCategoryName => _parentProductCategoryName;
  set parentProductCategoryName(String? value) {
    _parentProductCategoryName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  // tomap

  ProductCategoryBase.fromMap(Map<String, dynamic> map) {
    _productCategoryID = map['ProductCategoryID'];
    _productCategoryCode = map['ProductCategoryCode'];
    _productCategoryName = map['ProductCategoryName'];
    _description = map['Description'];
    _parentProductCategoryID = map['ParentProductCategoryID'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['UID'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _parentProductCategoryName = map['ParentProductCategoryName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['ProductCategoryID'] = _productCategoryID;
    map['ProductCategoryCode'] = _productCategoryCode;
    map['ProductCategoryName'] = _productCategoryName;
    map['Description'] = _description;
    map['ParentProductCategoryID'] = _parentProductCategoryID;
    map['CreatedOn'] = _createdOn;
    map['CreatedBy'] = _createdBy;
    map['ModifiedOn'] = _modifiedOn;
    map['ModifiedBy'] = _modifiedBy;
    map['IsActive'] = _isActive;
    map['UID'] = _uid;
    map['AppUserID'] = _appUserID;
    map['AppUserGroupID'] = _appUserGroupID;
    map['IsArchived'] = _isArchived;
    map['IsDeleted'] = _isDeleted;
    map['ParentProductCategoryName'] = _parentProductCategoryName;
    map['AppUserName'] = _appUserName;
    map['AppUserGroupName'] = _appUserGroupName;
    return map;
  }
}
