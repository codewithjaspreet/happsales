class Contact {
  int? id;
  String? contactId;
  String? contactCode;
  String? title;
  String? firstName;
  String? middleName;
  String? lastName;
  String? contactName;
  String? contactIdentifier;
  String? accountId;
  String? departmentName;
  String? designation;
  String? rolesAndResponsibilities;
  String? reportingManager;
  String? reportingContactId;
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
  String? pin;
  String? gpsCoordinates;
  String? linkedIn;
  String? pastAccounts;
  String? pastDesignations;
  String? dateOfBirth;
  String? remindBirthday;
  String? contactAlignmentId;
  String? remarks;
  String? referenceHistory;
  String? isPrimaryContact;
  String? tags;
  String? freeTextField1;
  String? freeTextField2;
  String? freeTextField3;
  String? companyName;
  String? taxPayerIdentificationNumber;
  String? socialSecurityNumber;
  String? passportNumber;
  String? drivingLicenseNumber;
  String? voterIdCardNumber;
  String? marketingContactId;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? deviceIdentifier;
  String? referenceIdentifier;
  String? isActive;
  String? uid;
  String? appUserId;
  String? appUserGroupId;
  String? isArchived;
  String? isDeleted;
  String? leadQualificationId;
  String? isDirty;
  String? isActive1;
  String? isDeleted1;
  String? upSyncMessage;
  String? downSyncMessage;
  String? sCreatedOn;
  String? sModifiedOn;
  String? createdByUser;
  String? modifiedByUser;
  int? upSyncIndex;
  String? ownerUserId;

  Contact({
    this.id,
    this.contactId,
    this.contactCode,
    this.title,
    this.firstName,
    this.middleName,
    this.lastName,
    this.contactName,
    this.contactIdentifier,
    this.accountId,
    this.departmentName,
    this.designation,
    this.rolesAndResponsibilities,
    this.reportingManager,
    this.reportingContactId,
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
    this.pin,
    this.gpsCoordinates,
    this.linkedIn,
    this.pastAccounts,
    this.pastDesignations,
    this.dateOfBirth,
    this.remindBirthday,
    this.contactAlignmentId,
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
    this.voterIdCardNumber,
    this.marketingContactId,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.deviceIdentifier,
    this.referenceIdentifier,
    this.isActive,
    this.uid,
    this.appUserId,
    this.appUserGroupId,
    this.isArchived,
    this.isDeleted,
    this.leadQualificationId,
    this.isDirty,
    this.isActive1,
    this.isDeleted1,
    this.upSyncMessage,
    this.downSyncMessage,
    this.sCreatedOn,
    this.sModifiedOn,
    this.createdByUser,
    this.modifiedByUser,
    this.upSyncIndex,
    this.ownerUserId,
  });

  // tojson

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = this.id;
    data['contactId'] = this.contactId;
    data['contactCode'] = this.contactCode;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['contactName'] = this.contactName;
    data['contactIdentifier'] = this.contactIdentifier;
    data['accountId'] = this.accountId;
    data['departmentName'] = this.departmentName;
    data['designation'] = this.designation;
    data['rolesAndResponsibilities'] = this.rolesAndResponsibilities;
    data['reportingManager'] = this.reportingManager;
    data['reportingContactId'] = this.reportingContactId;
    data['mobileNumber'] = this.mobileNumber;
    data['alternateMobileNumber'] = this.alternateMobileNumber;
    data['workPhone'] = this.workPhone;
    data['residencePhone'] = this.residencePhone;
    data['email'] = this.email;
    data['alternateEmail'] = this.alternateEmail;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['addressLine3'] = this.addressLine3;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin'] = this.pin;
    data['gpsCoordinates'] = this.gpsCoordinates;
    data['linkedIn'] = this.linkedIn;
    data['pastAccounts'] = this.pastAccounts;
    data['pastDesignations'] = this.pastDesignations;
    data['dateOfBirth'] = this.dateOfBirth;
    data['remindBirthday'] = this.remindBirthday;
    data['contactAlignmentId'] = this.contactAlignmentId;
    data['remarks'] = this.remarks;
    data['referenceHistory'] = this.referenceHistory;
    data['isPrimaryContact'] = this.isPrimaryContact;
    data['tags'] = this.tags;
    data['freeTextField1'] = this.freeTextField1;
    data['freeTextField2'] = this.freeTextField2;
    data['freeTextField3'] = this.freeTextField3;
    data['companyName'] = this.companyName;
    data['taxPayerIdentificationNumber'] = this.taxPayerIdentificationNumber;
    data['socialSecurityNumber'] = this.socialSecurityNumber;
    data['passportNumber'] = this.passportNumber;
    data['drivingLicenseNumber'] = this.drivingLicenseNumber;
    data['voterIdCardNumber'] = this.voterIdCardNumber;
    data['marketingContactId'] = this.marketingContactId;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['deviceIdentifier'] = this.deviceIdentifier;
    data['referenceIdentifier'] = this.referenceIdentifier;
    data['isActive'] = this.isActive;
    data['uid'] = this.uid;
    data['appUserId'] = this.appUserId;
    data['appUserGroupId'] = this.appUserGroupId;
    data['isArchived'] = this.isArchived;
    data['isDeleted'] = this.isDeleted;
    data['leadQualificationId'] = this.leadQualificationId;
    data['isDirty'] = this.isDirty;
    data['isActive1'] = this.isActive1;
    data['isDeleted1'] = this.isDeleted1;
    data['upSyncMessage'] = this.upSyncMessage;
    data['downSyncMessage'] = this.downSyncMessage;
    data['sCreatedOn'] = this.sCreatedOn;
    data['sModifiedOn'] = this.sModifiedOn;
    data['createdByUser'] = this.createdByUser;
    data['modifiedByUser'] = this.modifiedByUser;
    data['upSyncIndex'] = this.upSyncIndex;
    data['ownerUserId'] = this.ownerUserId;

    return data;
  }

  //fromjson method

   Contact.fromJson(Map<String, dynamic> json) {

      id: json['id'];
      contactId: json['contactId'];
      contactCode: json['contactCode'];
      title: json['title'];
      firstName: json['firstName'];
      middleName: json['middleName'];
      lastName: json['lastName'];
      contactName: json['contactName'];
      contactIdentifier: json['contactIdentifier'];
      accountId: json['accountId'];
      departmentName: json['departmentName'];
      designation: json['designation'];
      rolesAndResponsibilities: json['rolesAndResponsibilities'];
      reportingManager: json['reportingManager'];
      reportingContactId: json['reportingContactId'];
      mobileNumber: json['mobileNumber'];
      alternateMobileNumber: json['alternateMobileNumber'];
      workPhone: json['workPhone'];
      residencePhone: json['residencePhone'];
      email: json['email'];
      alternateEmail: json['alternateEmail'];
      addressLine1: json['addressLine1'];
      addressLine2: json['addressLine2'];
      addressLine3: json['addressLine3'];
      city: json['city'];
      state: json['state'];
      country: json['country'];
      pin: json['pin'];
      gpsCoordinates: json['gpsCoordinates'];
      linkedIn: json['linkedIn'];
      pastAccounts: json['pastAccounts'];
      pastDesignations: json['pastDesignations'];
      dateOfBirth: json['dateOfBirth'];
      remindBirthday: json['remindBirthday'];
      contactAlignmentId: json['contactAlignmentId'];
      remarks: json['remarks'];
      referenceHistory: json['referenceHistory'];
      isPrimaryContact: json['isPrimaryContact'];
      tags: json['tags'];
      freeTextField1: json['freeTextField1'];
      freeTextField2: json['freeTextField2'];
      freeTextField3: json['freeTextField3'];
      companyName: json['companyName'];
      taxPayerIdentificationNumber: json['taxPayerIdentificationNumber'];
      socialSecurityNumber: json['socialSecurityNumber'];
      passportNumber: json['passportNumber'];
      drivingLicenseNumber: json['drivingLicenseNumber'];
      voterIdCardNumber: json['voterIdCardNumber'];
      marketingContactId: json['marketingContactId'];
      createdBy: json['createdBy'];
      createdOn: json['createdOn'];
      modifiedBy: json['modifiedBy'];
      modifiedOn: json['modifiedOn'];
      deviceIdentifier: json['deviceIdentifier'];
      referenceIdentifier: json['referenceIdentifier'];
      isActive: json['isActive'];
      uid: json['uid'];
      appUserId: json['appUserId'];
      appUserGroupId: json['appUserGroupId'];
      isArchived: json['isArchived'];
      isDeleted: json['isDeleted'];
      leadQualificationId: json['leadQualificationId'];
      isDirty: json['isDirty'];
      isActive1: json['isActive1'];
      isDeleted1: json['isDeleted1'];
      upSyncMessage: json['upSyncMessage'];
      downSyncMessage: json['downSyncMessage'];
      sCreatedOn: json['sCreatedOn'];
      sModifiedOn: json['sModifiedOn'];
      createdByUser: json['createdByUser'];
      modifiedByUser: json['modifiedByUser'];
      upSyncIndex: json['upSyncIndex'];
      ownerUserId: json['ownerUserId'];


    }

}