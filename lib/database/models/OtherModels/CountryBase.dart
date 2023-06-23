import '../../Models/BaseEntity.dart';

class CountryBase extends BaseEntity {
String? _countryID;
String? _countryCode;
String? _countryName;
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
CountryBase();

String? get countryID => _countryID;
set countryID(String? value) {
_countryID = value;
}

String? get countryCode => _countryCode;
set countryCode(String? value) {
_countryCode = value;
}

String? get countryName => _countryName;
set countryName(String? value) {
_countryName = value;
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
'CountryID': countryID,
'CountryCode': countryCode,
'CountryName': countryName,
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
'AppUserName': appUserName,
'AppUserGroupName': appUserGroupName,
};
}

 CountryBase.fromMap(Map<String, dynamic> map) {
_countryID = map['CountryID'];
_countryCode = map['CountryCode'];
_countryName = map['CountryName'];
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
_appUserName = map['AppUserName'];
_appUserGroupName = map['AppUserGroupName'];

}
}

