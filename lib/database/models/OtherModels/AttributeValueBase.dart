class AttributeValueBase {
  String? _attributeValueID;
  String? _attributeValueCode;
  String? _attributeValueName;
  String? _attributeID;
  String? _description;
  String? _multiplier;
  String? _parentAttributeValueID;
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

  String? _attributeName;
  String? _parentAttributeValueName;
  String? _appUserName;
  String? _appUserGroupName;


AttributeValueBase();
  // AttributeValueID
  String? get attributeValueID => _attributeValueID;
  set attributeValueID(String? value) {
    _attributeValueID = value;
  }

  // AttributeValueCode
  String? get attributeValueCode => _attributeValueCode;
  set attributeValueCode(String? value) {
    _attributeValueCode = value;
  }

  // AttributeValueName
  String? get attributeValueName => _attributeValueName;
  set attributeValueName(String? value) {
    _attributeValueName = value;
  }

  // AttributeID
  String? get attributeID => _attributeID;
  set attributeID(String? value) {
    _attributeID = value;
  }

  // Description
  String? get description => _description;
  set description(String? value) {
    _description = value;
  }

  // Multiplier
  String? get multiplier => _multiplier;
  set multiplier(String? value) {
    _multiplier = value;
  }

  // ParentAttributeValueID
  String? get parentAttributeValueID => _parentAttributeValueID;
  set parentAttributeValueID(String? value) {
    _parentAttributeValueID = value;
  }

  // CreatedOn
  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  // CreatedBy
  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  // ModifiedOn
  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  // ModifiedBy
  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  // IsActive
  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  // Uid
  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  // AppUserID
  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  // AppUserGroupID
  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  // IsArchived
  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  // IsDeleted
  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  // AttributeName
  String? get attributeName => _attributeName;
  set attributeName(String? value) {
    _attributeName = value;
  }

  // ParentAttributeValueName
  String? get parentAttributeValueName => _parentAttributeValueName;
  set parentAttributeValueName(String? value) {
    _parentAttributeValueName = value;
  }

  // AppUserName
  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  // AppUserGroupName
  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'AttributeValueID': attributeValueID,
      'AttributeValueCode': attributeValueCode,
      'AttributeValueName': attributeValueName,
      'AttributeID': attributeID,
      'Description': description,
      'Multiplier': multiplier,
      'ParentAttributeValueID': parentAttributeValueID,
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
      'AttributeName': attributeName,
      'ParentAttributeValueName': parentAttributeValueName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   AttributeValueBase.fromMapObject(Map<String, dynamic> map) {
    _attributeValueID = map['AttributeValueID'];
    _attributeValueCode = map['AttributeValueCode'];
    _attributeValueName = map['AttributeValueName'];
    _attributeID = map['AttributeID'];
    _description = map['Description'];
    _multiplier = map['Multiplier'];
    _parentAttributeValueID = map['ParentAttributeValueID'];
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
    _attributeName = map['AttributeName'];
    _parentAttributeValueName = map['ParentAttributeValueName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
