import 'package:happsales_crm/database/models/BaseEntity.dart';

class AttributeBase extends BaseEntity {
  String? _attributeID;
  String? _attributeCode;
  String? _attributeName;
  String? _description;
  String? _applyToAllProducts;
  String? _parentAttributeID;
  String? _isSelfReferencing;
  String? _sequentialOrder;
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
  String? _parentAttributeName;
  String? _appUserName;
  String? _appUserGroupName;

  AttributeBase();

  // Getters
  String? get attributeID => _attributeID;
  String? get attributeCode => _attributeCode;
  String? get attributeName => _attributeName;
  String? get description => _description;
  String? get applyToAllProducts => _applyToAllProducts;
  String? get parentAttributeID => _parentAttributeID;
  String? get isSelfReferencing => _isSelfReferencing;
  String? get sequentialOrder => _sequentialOrder;
  String? get createdOn => _createdOn;
  String? get createdBy => _createdBy;
  String? get modifiedOn => _modifiedOn;
  String? get modifiedBy => _modifiedBy;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get appUserID => _appUserID;
  String? get appUserGroupID => _appUserGroupID;
  String? get isArchived => _isArchived;
  String? get isDeleted => _isDeleted;
  String? get parentAttributeName => _parentAttributeName;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;

  // Setters
  set attributeID(String? value) {
    _attributeID = value;
  }

  set attributeCode(String? value) {
    _attributeCode = value;
  }

  set attributeName(String? value) {
    _attributeName = value;
  }

  set description(String? value) {
    _description = value;
  }

  set applyToAllProducts(String? value) {
    _applyToAllProducts = value;
  }

  set parentAttributeID(String? value) {
    _parentAttributeID = value;
  }

  set isSelfReferencing(String? value) {
    _isSelfReferencing = value;
  }

  set sequentialOrder(String? value) {
    _sequentialOrder = value;
  }

  set createdOn(String? value) {
    _createdOn = value;
  }

  set createdBy(String? value) {
    _createdBy = value;
  }

  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  set isActive(String? value) {
    _isActive = value;
  }

  set uid(String? value) {
    _uid = value;
  }

  set appUserID(String? value) {
    _appUserID = value;
  }

  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  set isArchived(String? value) {
    _isArchived = value;
  }

  set isDeleted(String? value) {
    _isDeleted = value;
  }

  set parentAttributeName(String? value) {
    _parentAttributeName = value;
  }

  set appUserName(String? value) {
    _appUserName = value;
  }

  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'AttributeID': _attributeID,
      'AttributeCode': _attributeCode,
      'AttributeName': _attributeName,
      'Description': _description,
      'ApplyToAllProducts': _applyToAllProducts,
      'ParentAttributeID': _parentAttributeID,
      'IsSelfReferencing': _isSelfReferencing,
      'SequentialOrder': _sequentialOrder,
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
      'ParentAttributeName': _parentAttributeName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  AttributeBase.fromMap(Map<String, dynamic> map) {

    _attributeID = map['AttributeID'];
    _attributeCode = map['AttributeCode'];
    _attributeName = map['AttributeName'];
    _description = map['Description'];
    _applyToAllProducts = map['ApplyToAllProducts'];
    _parentAttributeID = map['ParentAttributeID'];
    _isSelfReferencing = map['IsSelfReferencing'];
    _sequentialOrder = map['SequentialOrder'];
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
    _parentAttributeName = map['ParentAttributeName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
