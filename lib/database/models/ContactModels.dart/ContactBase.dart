import 'package:happsales_crm/database/models/BaseEntity.dart';

class ContactBase extends BaseEntity{

  String? _contactID;
  String? _contactCode;
  String? _title;
  String? _firstName;
  String? _middleName;
  String? _lastName;
  String? _contactName;
  String? _contactIdentifier;
  String? _accountID;
  String? _contactCategoryID;
  String? _departmentName;
  String? _designation;
  String? _rolesAndResponsibilities;
  String? _reportingManager;
  String? _reportingContactID;
  String? _mobileNumber;
  String? _alternateMobileNumber;
  String? _workPhone;
  String? _residencePhone;
  String? _email;
  String? _alternateEmail;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _city;
  String? _state;
  String? _country;
  String? _pin;
  String? _gpsCoordinates;
  String? _linkedIn;
  String? _pastAccounts;
  String? _pastDesignations;
  String? _dateOfBirth;
  String? _remindBirthday;
  String? _contactAlignmentID;
  String? _remarks;
  String? _referenceHistory;
  String? _isPrimaryContact;
  String? _tags;
  String? _freeTextField1;
  String? _freeTextField2;
  String? _freeTextField3;
  String? _companyName;
  String? _taxPayerIdentificationNumber;
  String? _socialSecurityNumber;
  String? _passportNumber;
  String? _drivingLicenseNumber;
  String? _voterIDCardNumber;
  String? _marketingContactID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _assignedByAppUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _leadQualificationID;

  String? _accountName;
  String? _contactCategoryName;
  String? _reportingContactName;
  String? _contactAlignmentName;
  String? _appUserName;
  String? _appUserGroupName;
  String? _contactCodeInternal; //26 may 2023

  ContactBase();




 String? get contactID => _contactID;
  set contactID(String? value) => _contactID = value;
  String? get contactCode => _contactCode;
  set contactCode(String? value) => _contactCode = value;
  String? get title => _title;
  set title(String? value) => _title = value;
  String? get firstName => _firstName;
  set firstName(String? value) => _firstName = value;
  String? get middleName => _middleName;
  set middleName(String? value) => _middleName = value;
  String? get lastName => _lastName;
  set lastName(String? value) => _lastName = value;
  String? get contactName => _contactName;
  set contactName(String? value) => _contactName = value;
  String? get contactIdentifier => _contactIdentifier;
  set contactIdentifier(String? value) => _contactIdentifier = value;
  String? get accountID => _accountID;
  set accountID(String? value) => _accountID = value;
  String? get contactCategoryID => _contactCategoryID;
  set contactCategoryID(String? value) => _contactCategoryID = value;
  String? get departmentName => _departmentName;
  set departmentName(String? value) => _departmentName = value;
  String? get designation => _designation;
  set designation(String? value) => _designation = value;
  String? get rolesAndResponsibilities => _rolesAndResponsibilities;
  set rolesAndResponsibilities(String? value) =>
      _rolesAndResponsibilities = value;
  String? get reportingManager => _reportingManager;
  set reportingManager(String? value) => _reportingManager = value;
  String? get reportingContactID => _reportingContactID;
  set reportingContactID(String? value) => _reportingContactID = value;
  String? get mobileNumber => _mobileNumber;
  set mobileNumber(String? value) => _mobileNumber = value;
  String? get alternateMobileNumber => _alternateMobileNumber;
  set alternateMobileNumber(String? value) => _alternateMobileNumber = value;
  String? get workPhone => _workPhone;
  set workPhone(String? value) => _workPhone = value;
  String? get residencePhone => _residencePhone;
  set residencePhone(String? value) => _residencePhone = value;
  String? get email => _email;
  set email(String? value) => _email = value;
  String? get alternateEmail => _alternateEmail;
  set alternateEmail(String? value) => _alternateEmail = value;
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
  String? get gpsCoordinates => _gpsCoordinates;
  set gpsCoordinates(String? value) => _gpsCoordinates = value;
  String? get linkedIn => _linkedIn;
  set linkedIn(String? value) => _linkedIn = value;
  String? get pastAccounts => _pastAccounts;
  set pastAccounts(String? value) => _pastAccounts = value;
  String? get pastDesignations => _pastDesignations;
  set pastDesignations(String? value) => _pastDesignations = value;
  String? get dateOfBirth => _dateOfBirth;
  set dateOfBirth(String? value) => _dateOfBirth = value;
  String? get remindBirthday => _remindBirthday;
  set remindBirthday(String? value) => _remindBirthday = value;
  String? get contactAlignmentID => _contactAlignmentID;
  set contactAlignmentID(String? value) => _contactAlignmentID = value;
  String? get remarks => _remarks;
  set remarks(String? value) => _remarks = value;
  String? get referenceHistory => _referenceHistory;
  set referenceHistory(String? value) => _referenceHistory = value;
  String? get isPrimaryContact => _isPrimaryContact;
  set isPrimaryContact(String? value) => _isPrimaryContact = value;
  String? get tags => _tags;
  set tags(String? value) => _tags = value;
  String? get freeTextField1 => _freeTextField1;
  set freeTextField1(String? value) => _freeTextField1 = value;
  String? get freeTextField2 => _freeTextField2;
  set freeTextField2(String? value) => _freeTextField2 = value;
  String? get freeTextField3 => _freeTextField3;
  set freeTextField3(String? value) => _freeTextField3 = value;
  String? get companyName => _companyName;
  set companyName(String? value) => _companyName = value;
  String? get taxPayerIdentificationNumber => _taxPayerIdentificationNumber;
  set taxPayerIdentificationNumber(String? value) =>
      _taxPayerIdentificationNumber = value;
  String? get socialSecurityNumber => _socialSecurityNumber;
  set socialSecurityNumber(String? value) => _socialSecurityNumber = value;
  String? get passportNumber => _passportNumber;
  set passportNumber(String? value) => _passportNumber = value;
  String? get drivingLicenseNumber => _drivingLicenseNumber;
  set drivingLicenseNumber(String? value) => _drivingLicenseNumber = value;
  String? get voterIDCardNumber => _voterIDCardNumber;
  set voterIDCardNumber(String? value) => _voterIDCardNumber = value;
  String? get marketingContactID => _marketingContactID;
  set marketingContactID(String? value) => _marketingContactID = value;
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
  String? get assignedByAppUserID => _assignedByAppUserID;
  set assignedByAppUserID(String? value) => _assignedByAppUserID = value;
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
  String? get contactCategoryName => _contactCategoryName;
  set contactCategoryName(String? value) => _contactCategoryName = value;
  String? get reportingContactName => _reportingContactName;
  set reportingContactName(String? value) => _reportingContactName = value;
  String? get contactAlignmentName => _contactAlignmentName;
  set contactAlignmentName(String? value) => _contactAlignmentName = value;
  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;
  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;
  String? get contactCodeInternal => _contactCodeInternal;
  set contactCodeInternal(String? value) => _contactCodeInternal = value;




  Map<String, dynamic> toJson() => {
        'contactID': _contactID,
        'contactCode': _contactCode,
        'title': _title,
        'firstName': _firstName,
        'middleName': _middleName,
        'lastName': _lastName,
        'contactName': _contactName,
        'contactIdentifier': _contactIdentifier,
        'accountID': _accountID,
        'contactCategoryID': _contactCategoryID,
        'departmentName': _departmentName,
        'designation': _designation,
        'rolesAndResponsibilities': _rolesAndResponsibilities,
        'reportingManager': _reportingManager,
        'reportingContactID': _reportingContactID,
        'mobileNumber': _mobileNumber,
        'alternateMobileNumber': _alternateMobileNumber,
        'workPhone': _workPhone,
        'residencePhone': _residencePhone,
        'email': _email,
        'alternateEmail': _alternateEmail,
        'addressLine1': _addressLine1,
        'addressLine2': _addressLine2,
        'addressLine3': _addressLine3,
        'city': _city,
        'state': _state,
        'country': _country,
        'pin': _pin,
        'gpsCoordinates': _gpsCoordinates,
        'linkedIn': _linkedIn,
        'pastAccounts': _pastAccounts,
        'pastDesignations': _pastDesignations,
        'dateOfBirth': _dateOfBirth,
        'remindBirthday': _remindBirthday,
        'contactAlignmentID': _contactAlignmentID,
        'remarks': _remarks,
        'referenceHistory': _referenceHistory,
        'isPrimaryContact': _isPrimaryContact,
        'tags': _tags,
        'freeTextField1': _freeTextField1,
        'freeTextField2': _freeTextField2,
        'freeTextField3': _freeTextField3,
        'companyName': _companyName,
        'taxPayerIdentificationNumber': _taxPayerIdentificationNumber,
        'socialSecurityNumber': _socialSecurityNumber,
        'passportNumber': _passportNumber,
        'drivingLicenseNumber': _drivingLicenseNumber,
        'voterIDCardNumber': _voterIDCardNumber,
        'marketingContactID': _marketingContactID,
        'createdBy': _createdBy,
        'createdOn': _createdOn,
        'modifiedBy': _modifiedBy,
        'modifiedOn': _modifiedOn,
        'deviceIdentifier': _deviceIdentifier,
        'referenceIdentifier': _referenceIdentifier,
        'isActive': _isActive,
        'uid': _uid,
        'appUserID': _appUserID,
        'assignedByAppUserID': _assignedByAppUserID,
        'appUserGroupID': _appUserGroupID,
        'isArchived': _isArchived,
        'isDeleted': _isDeleted,
        'leadQualificationID': _leadQualificationID,
        'accountName': _accountName,
        'contactCategoryName': _contactCategoryName,
        'reportingContactName': _reportingContactName,
        'contactAlignmentName': _contactAlignmentName,
        'appUserName': _appUserName,
        'appUserGroupName': _appUserGroupName,
        'contactCodeInternal': _contactCodeInternal,
      };



  Map<String, dynamic> toMap() {
  return {
    'contactID': _contactID,
    'contactCode': _contactCode,
    'title': _title,
    'firstName': _firstName,
    'middleName': _middleName,
    'lastName': _lastName,
    'contactName': _contactName,
    'contactIdentifier': _contactIdentifier,
    'accountID': _accountID,
    'contactCategoryID': _contactCategoryID,
    'departmentName': _departmentName,
    'designation': _designation,
    'rolesAndResponsibilities': _rolesAndResponsibilities,
    'reportingManager': _reportingManager,
    'reportingContactID': _reportingContactID,
    'mobileNumber': _mobileNumber,
    'alternateMobileNumber': _alternateMobileNumber,
    'workPhone': _workPhone,
    'residencePhone': _residencePhone,
    'email': _email,
    'alternateEmail': _alternateEmail,
    'addressLine1': _addressLine1,
    'addressLine2': _addressLine2,
    'addressLine3': _addressLine3,
    'city': _city,
    'state': _state,
    'country': _country,
    'pin': _pin,
    'gpsCoordinates': _gpsCoordinates,
    'linkedIn': _linkedIn,
    'pastAccounts': _pastAccounts,
    'pastDesignations': _pastDesignations,
    'dateOfBirth': _dateOfBirth,
    'remindBirthday': _remindBirthday,
    'contactAlignmentID': _contactAlignmentID,
    'remarks': _remarks,
    'referenceHistory': _referenceHistory,
    'isPrimaryContact': _isPrimaryContact,
    'tags': _tags,
    'freeTextField1': _freeTextField1,
    'freeTextField2': _freeTextField2,
    'freeTextField3': _freeTextField3,
    'companyName': _companyName,
    'taxPayerIdentificationNumber': _taxPayerIdentificationNumber,
    'socialSecurityNumber': _socialSecurityNumber,
    'passportNumber': _passportNumber,
    'drivingLicenseNumber': _drivingLicenseNumber,
    'voterIDCardNumber': _voterIDCardNumber,
    'marketingContactID': _marketingContactID,
    'createdBy': _createdBy,
    'createdOn': _createdOn,
    'modifiedBy': _modifiedBy,
    'modifiedOn': _modifiedOn,
    'deviceIdentifier': _deviceIdentifier,
    'referenceIdentifier': _referenceIdentifier,
    'isActive': _isActive,
    'uid': _uid,
    'appUserID': _appUserID,
    'assignedByAppUserID': _assignedByAppUserID,
    'appUserGroupID': _appUserGroupID,
    'isArchived': _isArchived,
    'isDeleted': _isDeleted,
    'leadQualificationID': _leadQualificationID,
    'accountName': _accountName,
    'contactCategoryName': _contactCategoryName,
    'reportingContactName': _reportingContactName,
    'contactAlignmentName': _contactAlignmentName,
    'appUserName': _appUserName,
    'appUserGroupName': _appUserGroupName,
    'contactCodeInternal': _contactCodeInternal,
  };
}


}