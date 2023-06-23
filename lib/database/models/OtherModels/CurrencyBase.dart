import '../../Models/BaseEntity.dart';

class CurrencyBase extends BaseEntity {
String? _currencyID;
String? _currencyCode;
String? _currencyName;
String? _countryID;
String? _standardCurrencyCode;
String? _currencySymbol;
String? _exchangeRate;
String? _isDefaultCurrency;
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
String? _countryName;
String? _appUserName;
String? _appUserGroupName;
CurrencyBase();
String? get currencyID => _currencyID;
set currencyID(String? value) {
_currencyID = value;
}

String? get currencyCode => _currencyCode;
set currencyCode(String? value) {
_currencyCode = value;
}

String? get currencyName => _currencyName;
set currencyName(String? value) {
_currencyName = value;
}

String? get countryID => _countryID;
set countryID(String? value) {
_countryID = value;
}

String? get standardCurrencyCode => _standardCurrencyCode;
set standardCurrencyCode(String? value) {
_standardCurrencyCode = value;
}

String? get currencySymbol => _currencySymbol;
set currencySymbol(String? value) {
_currencySymbol = value;
}

String? get exchangeRate => _exchangeRate;
set exchangeRate(String? value) {
_exchangeRate = value;
}

String? get isDefaultCurrency => _isDefaultCurrency;
set isDefaultCurrency(String? value) {
_isDefaultCurrency = value;
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

String? get countryName => _countryName;
set countryName(String? value) {
_countryName = value;
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
'CurrencyID': _currencyID,
'CurrencyCode': _currencyCode,
'CurrencyName': _currencyName,
'CountryID': _countryID,
'StandardCurrencyCode': _standardCurrencyCode,
'CurrencySymbol': _currencySymbol,
'ExchangeRate': _exchangeRate,
'IsDefaultCurrency': _isDefaultCurrency,
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
'CountryName': _countryName,
'AppUserName': _appUserName,
'AppUserGroupName': _appUserGroupName,
};
}

 CurrencyBase.fromMap(Map<String, dynamic> map) {
_currencyID = map['CurrencyID'];
_currencyCode = map['CurrencyCode'];
_currencyName = map['CurrencyName'];
_countryID = map['CountryID'];
_standardCurrencyCode = map['StandardCurrencyCode'];
_currencySymbol = map['CurrencySymbol'];
_exchangeRate = map['ExchangeRate'];
_isDefaultCurrency = map['IsDefaultCurrency'];
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
_countryName = map['CountryName'];
_appUserName = map['AppUserName'];
_appUserGroupName = map['AppUserGroupName'];
}
}