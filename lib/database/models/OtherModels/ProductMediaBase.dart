import 'package:happsales_crm/database/models/BaseEntity.dart';

class ProductMediaBase extends BaseEntity {
  String? _productMediaID;
  String? _productMediaCode;
  String? _productMediaName;
  String? _productID;
  String? _contentTypeID;
  String? _mediaPath;
  String? _mediaContent;
  String? _description;
  String? _tags;
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

  ProductMediaBase();

  String? get productMediaID => _productMediaID;
  set productMediaID(String? value) {
    _productMediaID = value;
  }

  String? get productMediaCode => _productMediaCode;
  set productMediaCode(String? value) {
    _productMediaCode = value;
  }

  String? get productMediaName => _productMediaName;
  set productMediaName(String? value) {
    _productMediaName = value;
  }

  String? get productID => _productID;
  set productID(String? value) {
    _productID = value;
  }

  String? get contentTypeID => _contentTypeID;
  set contentTypeID(String? value) {
    _contentTypeID = value;
  }

  String? get mediaPath => _mediaPath;
  set mediaPath(String? value) {
    _mediaPath = value;
  }

  String? get mediaContent => _mediaContent;
  set mediaContent(String? value) {
    _mediaContent = value;
  }

  String? get description => _description;
  set description(String? value) {
    _description = value;
  }

  String? get tags => _tags;
  set tags(String? value) {
    _tags = value;
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

  Map<String, dynamic> toMap() {
    return {
      'ProductMediaID': _productMediaID,
      'ProductMediaCode': _productMediaCode,
      'ProductMediaName': _productMediaName,
      'ProductID': _productID,
      'ContentTypeID': _contentTypeID,
      'MediaPath': _mediaPath,
      'MediaContent': _mediaContent,
      'Description': _description,
      'Tags': _tags,
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
    };
  }

  ProductMediaBase.fromMapObject(Map<String, dynamic> map) {
    _productMediaID = map['ProductMediaID'];
    _productMediaCode = map['ProductMediaCode'];
    _productMediaName = map['ProductMediaName'];
    _productID = map['ProductID'];
    _contentTypeID = map['ContentTypeID'];
    _mediaPath = map['MediaPath'];
    _mediaContent = map['MediaContent'];
    _description = map['Description'];
    _tags = map['Tags'];
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

  }
}
