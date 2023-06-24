
import 'package:happsales_crm/database/models/BaseEntity.dart';

class ResourceBase extends BaseEntity {
  String? _resourceID;
  String? _resourceCode;
  String? _resourceName;
  String? _productID;
  String? _contentTypeID;
  String? _resourcePath;
  String? _resourceContent;
  String? _description;
  String? _isSharable;
  String? _validUpTo;
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

  String? _productName;
  String? _contentTypeName;
  String? _appUserName;
  String? _appUserGroupName;

  ResourceBase();

  String? get resourceID => _resourceID;
  set resourceID(String? value) {
    _resourceID = value;
  }

  String? get resourceCode => _resourceCode;
  set resourceCode(String? value) {
    _resourceCode = value;
  }

  String? get resourceName => _resourceName;
  set resourceName(String? value) {
    _resourceName = value;
  }

  String? get productID => _productID;
  set productID(String? value) {
    _productID = value;
  }

  String? get contentTypeID => _contentTypeID;
  set contentTypeID(String? value) {
    _contentTypeID = value;
  }

  String? get resourcePath => _resourcePath;
  set resourcePath(String? value) {
    _resourcePath = value;
  }

  String? get resourceContent => _resourceContent;
  set resourceContent(String? value) {
    _resourceContent = value;
  }

  String? get description => _description;
  set description(String? value) {
    _description = value;
  }

  String? get isSharable => _isSharable;
  set isSharable(String? value) {
    _isSharable = value;
  }

  String? get validUpTo => _validUpTo;
  set validUpTo(String? value) {
    _validUpTo = value;
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

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get productName => _productName;
  set productName(String? value) {
    _productName = value;
  }

  String? get contentTypeName => _contentTypeName;
  set contentTypeName(String? value) {
    _contentTypeName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  // to map

  ResourceBase.fromMap(Map<String, dynamic> map) {
    _resourceID = map['ResourceID'];
    _resourceCode = map['ResourceCode'];
    _resourceName = map['ResourceName'];
    _productID = map['ProductID'];
    _contentTypeID = map['ContentTypeID'];
    _resourcePath = map['ResourcePath'];
    _resourceContent = map['ResourceContent'];
    _description = map['Description'];
    _isSharable = map['IsSharable'];
    _validUpTo = map['ValidUpTo'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['UID'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _productName = map['ProductName'];
    _contentTypeName = map['ContentTypeName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }

  //fromMap

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['ResourceID'] = _resourceID;
    map['ResourceCode'] = _resourceCode;
    map['ResourceName'] = _resourceName;
    map['ProductID'] = _productID;
    map['ContentTypeID'] = _contentTypeID;
    map['ResourcePath'] = _resourcePath;
    map['ResourceContent'] = _resourceContent;
    map['Description'] = _description;
    map['IsSharable'] = _isSharable;
    map['ValidUpTo'] = _validUpTo;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ModifiedBy'] = _modifiedBy;
    map['ModifiedOn'] = _modifiedOn;
    map['IsActive'] = _isActive;
    map['UID'] = _uid;
    map['AppUserID'] = _appUserID;
    map['AppUserGroupID'] = _appUserGroupID;
    map['IsArchived'] = _isArchived;
    map['IsDeleted'] = _isDeleted;
    map['ProductName'] = _productName;
    map['ContentTypeName'] = _contentTypeName;
    map['AppUserName'] = _appUserName;
    map['AppUserGroupName'] = _appUserGroupName;
    return map;
  }
}
