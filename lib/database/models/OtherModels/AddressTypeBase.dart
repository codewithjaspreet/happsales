import 'package:happsales_crm/database/models/BaseEntity.dart';

class AddressTypeBase extends BaseEntity {
  String? _addressTypeID;
  String? _addressTypeCode;
  String? _addressTypeName;
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
  String? _appUserName;
  String? _appUserGroupName;

  AddressTypeBase();

  String? get addressTypeID => _addressTypeID;
  set addressTypeID(String? value) => _addressTypeID = value;

  String? get addressTypeCode => _addressTypeCode;
  set addressTypeCode(String? value) => _addressTypeCode = value;

  String? get addressTypeName => _addressTypeName;
  set addressTypeName(String? value) => _addressTypeName = value;

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

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;



  Map<String, dynamic> toMap() {
    return {
      'addressTypeID': addressTypeID,
      'addressTypeCode': addressTypeCode,
      'addressTypeName': addressTypeName,
      'createdOn': createdOn,
      'createdBy': createdBy,
      'modifiedOn': modifiedOn,
      'modifiedBy': modifiedBy,
      'isActive': isActive,
      'uid': uid,
      'appUserID': appUserID,
      'appUserGroupID': appUserGroupID,
      'isArchived': isArchived,
      'isDeleted': isDeleted,
      'appUserName': appUserName,
      'appUserGroupName': appUserGroupName,
    };
  }

   AddressTypeBase.fromMap(Map<String, dynamic> map) {
    
      _addressTypeID = map['addressTypeID'];
      _addressTypeCode = map['addressTypeCode'];
      _addressTypeName = map['addressTypeName'];
      _createdOn = map['createdOn'];
      _createdBy = map['createdBy'];
      _modifiedOn = map['modifiedOn'];
      _modifiedBy = map['modifiedBy'];
      _isActive = map['isActive'];
      _uid = map['uid'];
      _appUserID = map['appUserID'];
      _appUserGroupID = map['appUserGroupID'];
      _isArchived = map['isArchived'];
      _isDeleted = map['isDeleted'];
      _appUserName = map['appUserName'];
      _appUserGroupName = map['appUserGroupName'];
  }
}
