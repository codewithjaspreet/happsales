import 'dart:convert';

List<Contact> contactFromJson(String str) =>
    List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Contact {
  int? contactID;
  String? contactCode;
  String? title;
  String? firstName;
  String? middleName;
  String? lastName;
  String? contactName;
  String? contactIdentifier;
  int? accountID;
  String? contactCategoryID;
  String? departmentName;
  String? designation;
  String? rolesAndResponsibilities;
  String? reportingManager;
  String? reportingContactID;
  String? mobileNumber;
  String? alternateMobileNumber;
  String? workPhone;
  String? residencePhone;
  String? email;
  String? alternateEmail;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? state;
  String? country;
  String? pIN;
  String? gPSCoordinates;
  String? linkedIn;
  String? pastAccounts;
  String? pastDesignations;
  String? dateOfBirth;
  bool? remindBirthday;
  String? contactAlignmentID;
  String? remarks;
  String? referenceHistory;
  bool? isPrimaryContact;
  String? tags;
  String? freeTextField1;
  String? freeTextField2;
  String? freeTextField3;
  String? companyName;
  String? taxPayerIdentificationNumber;
  String? socialSecurityNumber;
  String? passportNumber;
  String? drivingLicenseNumber;
  String? voterIDCardNumber;
  String? marketingContactID;
  String? createdBy;
  String? createdOn;
  int? appUserID;
  // String? modifiedBy;
  // String? modifiedOn;
  // String? deviceIdentifier;
  // String? referenceIdentifier;
  // bool? isActive;
  // String? uid;
  // int? appUserID;
  // Null? assignedByAppUserID;
  // int? appUserGroupID;
  // bool? isArchived;
  // bool? isDeleted;
  // Null? leadQualificationID;
  String? accountName ;
  // Null? contactCategoryName;
  // Null? accountLocation;
  // String? reportingContactName;
  // String? contactAlignmentName;
  // String? appUserName;
  // Null? assignedByAppUserName;
  // String? appUserGroupName;
  // Null? iD;
  // Null? userLoginName;
  // Null? deviceAndLocation;
  // Null? userInput;
  // Null? appUserUid;
  // Null? appUserGroupUid;
  // Null? createdForUser;
  // int? rowNum;

  Contact({
    this.contactID,
    this.contactCode,
    this.title,
    this.firstName,
    this.middleName,
    this.lastName,
    this.contactName,

    this.contactIdentifier,
    this.accountID,
    this.contactCategoryID,
    this.departmentName,
    this.designation,
    this.rolesAndResponsibilities,
    this.reportingManager,
    this.reportingContactID,
    this.mobileNumber,
    this.alternateMobileNumber,
    this.workPhone,
    this.residencePhone,
    this.email,
    this.alternateEmail,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.state,
    this.country,
    this.pIN,
    this.gPSCoordinates,
    this.linkedIn,
    this.pastAccounts,
    this.pastDesignations,
    this.dateOfBirth,
    this.remindBirthday,
    this.contactAlignmentID,
    this.remarks,
    this.referenceHistory,
    this.isPrimaryContact,
    this.tags,
    this.freeTextField1,
    this.freeTextField2,
    this.freeTextField3,
    this.companyName,
    this.taxPayerIdentificationNumber,
    this.socialSecurityNumber,
    this.passportNumber,
    this.drivingLicenseNumber,
    this.voterIDCardNumber,
    this.marketingContactID,
    this.createdBy,
    this.createdOn,
    // this.modifiedBy,
    // this.modifiedOn,
    // this.deviceIdentifier,
    // this.referenceIdentifier,
    // this.isActive,
    // this.uid,
    this.appUserID,
    // this.assignedByAppUserID,
    // this.appUserGroupID,
    // this.isArchived,
    // this.isDeleted,
    // this.leadQualificationID,
    this.accountName,
    // this.contactCategoryName,
    // this.accountLocation,
    // this.reportingContactName,
    // this.contactAlignmentName,
    // this.appUserName,
    // this.assignedByAppUserName,
    // this.appUserGroupName,
    // this.iD,
    // this.userLoginName,
    // this.deviceAndLocation,
    // this.userInput,
    // this.appUserUid,
    // this.appUserGroupUid,
    // this.createdForUser,
    // this.rowNum});
  });
  Contact.fromJson(Map<String, dynamic> json) {
    contactID = json['ContactID'] ?? 0;
    contactCode = json['ContactCode'] ?? "" ;
    title = json['Title'] ??  "";
    firstName = json['FirstName'] ?? "";
    middleName = json['MiddleName'] ?? "";
    lastName = json['LastName'] ?? "";
    contactName = json['ContactName'] ?? "";
    contactIdentifier = json['ContactIdentifier'] ?? "";
    accountID = json['AccountID'] ?? 0;
    contactCategoryID = json['ContactCategoryID'] ?? "";
    departmentName = json['DepartmentName'] ?? "";
    designation = json['Designation'] ?? "";
    rolesAndResponsibilities = json['RolesAndResponsibilities'] ?? "";
    reportingManager = json['ReportingManager'] ?? "";
    reportingContactID = json['ReportingContactID'] ?? "";
    mobileNumber = json['MobileNumber'] ?? "";
    alternateMobileNumber = json['AlternateMobileNumber'] ?? "";
    workPhone = json['WorkPhone'] ?? "";
    residencePhone = json['ResidencePhone'] ?? "";
    email = json['Email'] ?? "";
    alternateEmail = json['AlternateEmail'] ?? "";
    addressLine1 = json['AddressLine1'] ?? "";
    addressLine2 = json['AddressLine2'] ?? "";
    addressLine3 = json['AddressLine3'] ?? "";
    city = json['City'] ?? "";
    state = json['State'] ?? "";
    country = json['Country'] ?? "";
    pIN = json['PIN'] ?? "";
    gPSCoordinates = json['GPSCoordinates'] ?? "";
    linkedIn = json['LinkedIn'] ?? "";
    pastAccounts = json['PastAccounts'] ?? "";
    pastDesignations = json['PastDesignations'] ?? "";
    dateOfBirth = json['DateOfBirth'] ?? "";
    remindBirthday = json['RemindBirthday'] ?? false;
    contactAlignmentID = json['ContactAlignmentID'] ?? "";
    // remarks = json['Remarks'];
    // referenceHistory = json['ReferenceHistory'];
    // isPrimaryContact = json['IsPrimaryContact'];
    // tags = json['Tags'];
    freeTextField1 = json['FreeTextField1'];
    freeTextField2 = json['FreeTextField2'];
    freeTextField3 = json['FreeTextField3'];
    // companyName = json['CompanyName'];
    taxPayerIdentificationNumber  = json['TaxPayerIdentificationNumber'] ?? "";
    socialSecurityNumber = json['SocialSecurityNumber'] ?? "";
    passportNumber = json['PassportNumber'] ?? "";
    drivingLicenseNumber = json['DrivingLicenseNumber'] ?? "";
    voterIDCardNumber = json['VoterIDCardNumber'] ?? "";
    marketingContactID = json['MarketingContactID'] ?? "";
    createdBy = json['CreatedBy'] ?? "";
    createdOn = json['CreatedOn'] ?? "2023-03-08T12:06:05.484455";
    // modifiedBy = json['ModifiedBy'];
    // modifiedOn = json['ModifiedOn'];
    // deviceIdentifier = json['DeviceIdentifier'];
    // referenceIdentifier = json['ReferenceIdentifier'];
    // isActive = json['IsActive'];
    // uid = json['Uid'];
    appUserID = json['AppUserID'] ?? 0;
    // assignedByAppUserID = json['AssignedByAppUserID'];
    // appUserGroupID = json['AppUserGroupID'];
    // isArchived = json['IsArchived'];
    // isDeleted = json['IsDeleted'];
    // leadQualificationID = json['LeadQualificationID'];
    accountName = json['AccountName'] ?? "";
    // contactCategoryName = json['ContactCategoryName'];
    // accountLocation = json['AccountLocation'];
    // reportingContactName = json['ReportingContactName'];
    // contactAlignmentName = json['ContactAlignmentName'];
    // appUserName = json['AppUserName'];
    // assignedByAppUserName = json['AssignedByAppUserName'];
    // appUserGroupName = json['AppUserGroupName'];
    // iD = json['ID'];
    // userLoginName = json['UserLoginName'];
    // deviceAndLocation = json['DeviceAndLocation'];
    // userInput = json['UserInput'];
    // appUserUid = json['AppUserUid'];
    // appUserGroupUid = json['AppUserGroupUid'];
    // createdForUser = json['CreatedForUser'];
    // rowNum = json['RowNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ContactID'] = this.contactID;
    data['ContactCode'] = this.contactCode;
    data['Title'] = this.title;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['ContactName'] = this.contactName;
    // data['ContactIdentifier'] = this.contactIdentifier;
    // data['AccountID'] = this.accountID;
    // data['ContactCategoryID'] = this.contactCategoryID;
    // data['DepartmentName'] = this.departmentName;
    // data['Designation'] = this.designation;
    // data['RolesAndResponsibilities'] = this.rolesAndResponsibilities;
    // data['ReportingManager'] = this.reportingManager;
    // data['ReportingContactID'] = this.reportingContactID;
    // data['MobileNumber'] = this.mobileNumber;
    // data['AlternateMobileNumber'] = this.alternateMobileNumber;
    // data['WorkPhone'] = this.workPhone;
    // data['ResidencePhone'] = this.residencePhone;
    // data['Email'] = this.email;
    // data['AlternateEmail'] = this.alternateEmail;
    // data['AddressLine1'] = this.addressLine1;
    // data['AddressLine2'] = this.addressLine2;
    // data['AddressLine3'] = this.addressLine3;
    // data['City'] = this.city;
    // data['State'] = this.state;
    // data['Country'] = this.country;
    // data['PIN'] = this.pIN;
    // data['GPSCoordinates'] = this.gPSCoordinates;
    // data['LinkedIn'] = this.linkedIn;
    // data['PastAccounts'] = this.pastAccounts;
    // data['PastDesignations'] = this.pastDesignations;
    // data['DateOfBirth'] = this.dateOfBirth;
    // data['RemindBirthday'] = this.remindBirthday;
    // data['ContactAlignmentID'] = this.contactAlignmentID;
    // data['Remarks'] = this.remarks;
    // data['ReferenceHistory'] = this.referenceHistory;
    // data['IsPrimaryContact'] = this.isPrimaryContact;
    // data['Tags'] = this.tags;
    // data['FreeTextField1'] = this.freeTextField1;
    // data['FreeTextField2'] = this.freeTextField2;
    // data['FreeTextField3'] = this.freeTextField3;
    // data['CompanyName'] = this.companyName;
    // data['TaxPayerIdentificationNumber'] = this.taxPayerIdentificationNumber;
    // data['SocialSecurityNumber'] = this.socialSecurityNumber;
    // data['PassportNumber'] = this.passportNumber;
    // data['DrivingLicenseNumber'] = this.drivingLicenseNumber;
    // data['VoterIDCardNumber'] = this.voterIDCardNumber;
    // data['MarketingContactID'] = this.marketingContactID;
    // data['CreatedBy'] = this.createdBy;
    // data['CreatedOn'] = this.createdOn;
    // data['ModifiedBy'] = this.modifiedBy;
    // data['ModifiedOn'] = this.modifiedOn;
    // data['DeviceIdentifier'] = this.deviceIdentifier;
    // data['ReferenceIdentifier'] = this.referenceIdentifier;
    // data['IsActive'] = this.isActive;
    // data['Uid'] = this.uid;
    data['AppUserID'] = this.appUserID;
    // data['AssignedByAppUserID'] = this.assignedByAppUserID;
    // data['AppUserGroupID'] = this.appUserGroupID;
    // data['IsArchived'] = this.isArchived;
    // data['IsDeleted'] = this.isDeleted;
    // data['LeadQualificationID'] = this.leadQualificationID;
    data['AccountName'] = this.accountName;
    // data['ContactCategoryName'] = this.contactCategoryName;
    // data['AccountLocation'] = this.accountLocation;
    // data['ReportingContactName'] = this.reportingContactName;
    // data['ContactAlignmentName'] = this.contactAlignmentName;
    // data['AppUserName'] = this.appUserName;
    // data['AssignedByAppUserName'] = this.assignedByAppUserName;
    // data['AppUserGroupName'] = this.appUserGroupName;
    // data['ID'] = this.iD;
    // data['UserLoginName'] = this.userLoginName;
    // data['DeviceAndLocation'] = this.deviceAndLocation;
    // data['UserInput'] = this.userInput;
    // data['AppUserUid'] = this.appUserUid;
    // data['AppUserGroupUid'] = this.appUserGroupUid;
    // data['CreatedForUser'] = this.createdForUser;
    // data['RowNum'] = this.rowNum;
    return data;
  }
}