import 'package:happsales_crm/database/models/BaseEntity.dart';

class TagBase extends BaseEntity {
  String? _tagID;
  String? _tagCode;
  String? _tagName;
  String? _description;
  String? _parentTagID;
  String? _tagGroupID;
  String? _sortOrder;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;

  String? _parentTagName;
  String? _tagGroupName;
  String? _appUserName;
  String? _appUserGroupName;


TagBase();  
  String? get tagID => _tagID;
  set tagID(String? value) => _tagID = value;

  String? get tagCode => _tagCode;
  set tagCode(String? value) => _tagCode = value;

  String? get tagName => _tagName;
  set tagName(String? value) => _tagName = value;

  String? get description => _description;
  set description(String? value) => _description = value;

  String? get parentTagID => _parentTagID;
  set parentTagID(String? value) => _parentTagID = value;

  String? get tagGroupID => _tagGroupID;
  set tagGroupID(String? value) => _tagGroupID = value;

  String? get sortOrder => _sortOrder;
  set sortOrder(String? value) => _sortOrder = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get deviceIdentifier => _deviceIdentifier;
  set deviceIdentifier(String? value) => _deviceIdentifier = value;

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) => _referenceIdentifier = value;

  String? get isActive => _isActive;
  set isActive(String? value) => _isActive = value;

  String? get uid => _uid;
  set uid(String? value) => _uid = value;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get parentTagName => _parentTagName;
  set parentTagName(String? value) => _parentTagName = value;

  String? get tagGroupName => _tagGroupName;
  set tagGroupName(String? value) => _tagGroupName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  //tomap function

  //no constructor

  TagBase.fromJson(Map<String, dynamic> json) {
    _tagID = json['TagID'];
    _tagCode = json['TagCode'];
    _tagName = json['TagName'];
    _description = json['Description'];
    _parentTagID = json['ParentTagID'];
    _tagGroupID = json['TagGroupID'];
    _sortOrder = json['SortOrder'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _modifiedBy = json['ModifiedBy'];
    _modifiedOn = json['ModifiedOn'];
    _deviceIdentifier = json['DeviceIdentifier'];
    _referenceIdentifier = json['ReferenceIdentifier'];
    _isActive = json['IsActive'];
    _uid = json['UID'];
    _appUserID = json['AppUserID'];
    _appUserGroupID = json['AppUserGroupID'];
    _isDeleted = json['IsDeleted'];
    _parentTagName = json['ParentTagName'];
    _tagGroupName = json['TagGroupName'];
    _appUserName = json['AppUserName'];
    _appUserGroupName = json['AppUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TagID'] = this._tagID;
    data['TagCode'] = this._tagCode;
    data['TagName'] = this._tagName;
    data['Description'] = this._description;
    data['ParentTagID'] = this._parentTagID;
    data['TagGroupID'] = this._tagGroupID;
    data['SortOrder'] = this._sortOrder;
    data['CreatedBy'] = this._createdBy;
    data['CreatedOn'] = this._createdOn;
    data['ModifiedBy'] = this._modifiedBy;
    data['ModifiedOn'] = this._modifiedOn;
    data['DeviceIdentifier'] = this._deviceIdentifier;
    data['ReferenceIdentifier'] = this._referenceIdentifier;
    data['IsActive'] = this._isActive;
    data['UID'] = this._uid;
    data['AppUserID'] = this._appUserID;
    data['AppUserGroupID'] = this._appUserGroupID;
    data['IsDeleted'] = this._isDeleted;
    data['ParentTagName'] = this._parentTagName;
    data['TagGroupName'] = this._tagGroupName;
    data['AppUserName'] = this._appUserName;
    data['AppUserGroupName'] = this._appUserGroupName;
    return data;
  }


  



}