import 'package:happsales_crm/database/models/BaseEntity.dart';

class AccountAddressBase extends BaseEntity {
  String? _accountAddressID;
  String? _accountAddressCode;
  String? _addressTypeName;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _city;
  String? _state;
  String? _country;
  String? _pin;
  String? _accountID;
  String? _contactID;
  String? _gpsCoordinates;
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
  String? _isArchived;
  String? _isDeleted;
  String? _leadQualificationID;

  String? _accountName;
  String? _contactName;
  String? _appUserName;
  String? _appUserGroupName;

  AccountAddressBase();

  String? get accountAddressID => _accountAddressID;
  set accountAddressID(String? value) => _accountAddressID = value;

  String? get accountAddressCode => _accountAddressCode;
  set accountAddressCode(String? value) => _accountAddressCode = value;

  String? get addressTypeName => _addressTypeName;
  set addressTypeName(String? value) => _addressTypeName = value;

  String? get addressLine1 => _addressLine1;
  set addressLine1(String? value) => _addressLine1 = value;

  String? get addressLine2 => _addressLine2;
  set addressLine2(String? value) => _addressLine2 = value;

  String? get addressLine3 => _addressLine3;
  set addressLine3(String? value) => _addressLine3 = value;

  String? get city => _city;
  set city(String? value) => _city = value;

  String? get state => _state;
  set state(String? value) => _state = value;

  String? get country => _country;
  set country(String? value) => _country = value;

  String? get pin => _pin;
  set pin(String? value) => _pin = value;

  String? get accountID => _accountID;
  set accountID(String? value) => _accountID = value;

  String? get contactID => _contactID;
  set contactID(String? value) => _contactID = value;

  String? get gpsCoordinates => _gpsCoordinates;
  set gpsCoordinates(String? value) => _gpsCoordinates = value;

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

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get leadQualificationID => _leadQualificationID;
  set leadQualificationID(String? value) => _leadQualificationID = value;

  String? get accountName => _accountName;
  set accountName(String? value) => _accountName = value;

  String? get contactName => _contactName;
  set contactName(String? value) => _contactName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  Map<String, dynamic> toJson() {
    return {
      'AccountAddressID': _accountAddressID,
      'AccountAddressCode': _accountAddressCode,
      'AddressTypeName': _addressTypeName,
      'AddressLine1': _addressLine1,
      'AddressLine2': _addressLine2,
      'AddressLine3': _addressLine3,
      'City': _city,
      'State': _state,
      'Country': _country,
      'PIN': _pin,
      'AccountID': _accountID,
      'ContactID': _contactID,
      'GPSCoordinates': _gpsCoordinates,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'DeviceIdentifier': _deviceIdentifier,
      'ReferenceIdentifier': _referenceIdentifier,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'LeadQualificationID': _leadQualificationID,
      'AccountName': _accountName,
      'ContactName': _contactName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  AccountAddressBase.fromMapObject(Map<String, dynamic> map) {
    _accountAddressID = map['AccountAddressID'];
    _accountAddressCode = map['AccountAddressCode'];
    _addressTypeName = map['AddressTypeName'];
    _addressLine1 = map['AddressLine1'];
    _addressLine2 = map['AddressLine2'];
   _addressLine3 = map['AddressLine3'];
    _city = map['City'];
    _state = map['State'];
    _country = map['Country'];
    _pin = map['PIN'];
    _accountID = map['AccountID'];
    _contactID = map['ContactID'];
    _gpsCoordinates = map['GPSCoordinates'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _leadQualificationID = map['LeadQualificationID'];
    _accountName = map['AccountName'];
    _contactName = map['ContactName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
