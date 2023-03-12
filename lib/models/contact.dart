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
    data['id'] = id;
    data['contactId'] = contactId;
    data['contactCode'] = contactCode;
    data['title'] = title;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['contactName'] = contactName;
    data['contactIdentifier'] = contactIdentifier;
    data['accountId'] = accountId;
    data['departmentName'] = departmentName;
    data['designation'] = designation;
    data['rolesAndResponsibilities'] = rolesAndResponsibilities;
    data['reportingManager'] = reportingManager;
    data['reportingContactId'] = reportingContactId;
    data['mobileNumber'] = mobileNumber;
    data['alternateMobileNumber'] = alternateMobileNumber;
    data['workPhone'] = workPhone;
    data['residencePhone'] = residencePhone;
    data['email'] = email;
    data['alternateEmail'] = alternateEmail;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['addressLine3'] = addressLine3;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['pin'] = pin;
    data['gpsCoordinates'] = gpsCoordinates;
    data['linkedIn'] = linkedIn;
    data['pastAccounts'] = pastAccounts;
    data['pastDesignations'] = pastDesignations;
    data['dateOfBirth'] = dateOfBirth;
    data['remindBirthday'] = remindBirthday;
    data['contactAlignmentId'] = contactAlignmentId;
    data['remarks'] = remarks;
    data['referenceHistory'] = referenceHistory;
    data['isPrimaryContact'] = isPrimaryContact;
    data['tags'] = tags;
    data['freeTextField1'] = freeTextField1;
    data['freeTextField2'] = freeTextField2;
    data['freeTextField3'] = freeTextField3;
    data['companyName'] = companyName;
    data['taxPayerIdentificationNumber'] = taxPayerIdentificationNumber;
    data['socialSecurityNumber'] = socialSecurityNumber;
    data['passportNumber'] = passportNumber;
    data['drivingLicenseNumber'] = drivingLicenseNumber;
    data['voterIdCardNumber'] = voterIdCardNumber;
    data['marketingContactId'] = marketingContactId;
    data['createdBy'] = createdBy;
    data['createdOn'] = createdOn;
    data['modifiedBy'] = modifiedBy;
    data['modifiedOn'] = modifiedOn;
    data['deviceIdentifier'] = deviceIdentifier;
    data['referenceIdentifier'] = referenceIdentifier;
    data['isActive'] = isActive;
    data['uid'] = uid;
    data['appUserId'] = appUserId;
    data['appUserGroupId'] = appUserGroupId;
    data['isArchived'] = isArchived;
    data['isDeleted'] = isDeleted;
    data['leadQualificationId'] = leadQualificationId;
    data['isDirty'] = isDirty;
    data['isActive1'] = isActive1;
    data['isDeleted1'] = isDeleted1;
    data['upSyncMessage'] = upSyncMessage;
    data['downSyncMessage'] = downSyncMessage;
    data['sCreatedOn'] = sCreatedOn;
    data['sModifiedOn'] = sModifiedOn;
    data['createdByUser'] = createdByUser;
    data['modifiedByUser'] = modifiedByUser;
    data['upSyncIndex'] = upSyncIndex;
    data['ownerUserId'] = ownerUserId;

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