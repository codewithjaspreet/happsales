import 'package:happsales_crm/database/models/BaseEntity.dart';

class TagGroupBase extends BaseEntity {
  String? _tagGroupID;
  String? _tagGroupCode;
  String? _tagGroupName;
  String? _businessFeatureID;
  String? _linkTo;
  String? _sortOrder;
  String? _displayInApp;
  String? _positionIndex;
  String? _allowNewValues;
  String? _useInBusinessTarget;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;

  String? _businessFeatureName;
  String? _appUserName;
  String? _appUserGroupName;


TagGroupBase();
  String? get tagGroupID => _tagGroupID;
  set tagGroupID(String? value) => _tagGroupID = value;

  String? get tagGroupCode => _tagGroupCode;
  set tagGroupCode(String? value) => _tagGroupCode = value;

  String? get tagGroupName => _tagGroupName;
  set tagGroupName(String? value) => _tagGroupName = value;

  String? get businessFeatureID => _businessFeatureID;
  set businessFeatureID(String? value) => _businessFeatureID = value;

  String? get linkTo => _linkTo;
  set linkTo(String? value) => _linkTo = value;

  String? get sortOrder => _sortOrder;
  set sortOrder(String? value) => _sortOrder = value;

  String? get displayInApp => _displayInApp;
  set displayInApp(String? value) => _displayInApp = value;

  String? get positionIndex => _positionIndex;
  set positionIndex(String? value) => _positionIndex = value;

  String? get allowNewValues => _allowNewValues;
  set allowNewValues(String? value) => _allowNewValues = value;

  String? get useInBusinessTarget => _useInBusinessTarget;
  set useInBusinessTarget(String? value) => _useInBusinessTarget = value;

  String? get createdOn => _createdOn;
  set createdOn(String? value) => _createdOn = value;

  String? get createdBy => _createdBy;
  set createdBy(String? value) => _createdBy = value;

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) => _modifiedOn = value;

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) => _modifiedBy = value;

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

  String? get businessFeatureName => _businessFeatureName;
  set businessFeatureName(String? value) => _businessFeatureName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  TagGroupBase.fromJson(Map<String, dynamic> json) {
    tagGroupID = json['tagGroupID'];
    tagGroupCode = json['tagGroupCode'];
    tagGroupName = json['tagGroupName'];
    businessFeatureID = json['businessFeatureID'];
    linkTo = json['linkTo'];
    sortOrder = json['sortOrder'];
    displayInApp = json['displayInApp'];
    positionIndex = json['positionIndex'];
    allowNewValues = json['allowNewValues'];
    useInBusinessTarget = json['useInBusinessTarget'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    modifiedOn = json['modifiedOn'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
    uid = json['uid'];
    appUserID = json['appUserID'];
    appUserGroupID = json['appUserGroupID'];
    isDeleted = json['isDeleted'];
    businessFeatureName = json['businessFeatureName'];
    appUserName = json['appUserName'];
    appUserGroupName = json['appUserGroupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagGroupID'] = this.tagGroupID;
    data['tagGroupCode'] = this.tagGroupCode;
    data['tagGroupName'] = this.tagGroupName;
    data['businessFeatureID'] = this.businessFeatureID;
    data['linkTo'] = this.linkTo;
    data['sortOrder'] = this.sortOrder;
    data['displayInApp'] = this.displayInApp;
    data['positionIndex'] = this.positionIndex;
    data['allowNewValues'] = this.allowNewValues;
    data['useInBusinessTarget'] = this.useInBusinessTarget;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['modifiedOn'] = this.modifiedOn;
    data['modifiedBy'] = this.modifiedBy;
    data['isActive'] = this.isActive;
    data['uid'] = this.uid;
    data['appUserID'] = this.appUserID;
    data['appUserGroupID'] = this.appUserGroupID;
    data['isDeleted'] = this.isDeleted;
    data['businessFeatureName'] = this.businessFeatureName;
    data['appUserName'] = this.appUserName;
    data['appUserGroupName'] = this.appUserGroupName;
    return data;
  }
}