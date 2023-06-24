import 'package:happsales_crm/database/models/BaseEntity.dart';

class LeadSourceBase extends BaseEntity {
  String? _leadSourceID;
  String? _leadSourceCode;
  String? _leadSourceName;
  String? _description;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;

  String? _appUserName;
  String? _appUserGroupName;


LeadSourceBase();
  String? get leadSourceID => _leadSourceID;
  set leadSourceID(String? value) {
    _leadSourceID = value;
  }

  String? get leadSourceCode => _leadSourceCode;
  set leadSourceCode(String? value) {
    _leadSourceCode = value;
  }

  String? get leadSourceName => _leadSourceName;
  set leadSourceName(String? value) {
    _leadSourceName = value;
  }

  String? get description => _description;
  set description(String? value) {
    _description = value;
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

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
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
      'LeadSourceID': _leadSourceID,
      'LeadSourceCode': _leadSourceCode,
      'LeadSourceName': _leadSourceName,
      'Description': _description,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  LeadSourceBase.fromMapObject(Map<String, dynamic> map) {
    _leadSourceID = map['LeadSourceID'];
    _leadSourceCode = map['LeadSourceCode'];
    _leadSourceName = map['LeadSourceName'];
    _description = map['Description'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
