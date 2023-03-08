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

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        contactId: json["contactId"],
        contactCode: json["contactCode"],
        title: json["title"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        contactName: json["contactName"],
        contactIdentifier: json["contactIdentifier"],
        accountId: json["accountId"],
        departmentName: json["departmentName"],
        designation: json["designation"],
        rolesAndResponsibilities: json["rolesAndResponsibilities"],
        reportingManager: json["reportingManager"],
        reportingContactId: json["reportingContactId"],
        mobileNumber: json["mobileNumber"],
        alternateMobileNumber: json["alternateMobileNumber"],
        workPhone: json["workPhone"],
        residencePhone: json["residencePhone"],
        email: json["email"],
        alternateEmail: json["alternateEmail"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        addressLine3: json["addressLine3"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pin: json["pin"],
        gpsCoordinates: json["gpsCoordinates"],
        linkedIn: json["linkedIn"],
        pastAccounts: json["pastAccounts"],
        pastDesignations: json["pastDesignations"],
        dateOfBirth: json["dateOfBirth"],
        remindBirthday: json["remindBirthday"],
        contactAlignmentId: json["contactAlignmentId"],
        remarks: json["remarks"],
        referenceHistory: json["referenceHistory"],
        isPrimaryContact: json["isPrimaryContact"],
        tags: json["tags"],
        freeTextField1: json["freeTextField1"],
        freeTextField2: json["freeTextField2"],
        freeTextField3: json["freeTextField3"],
        companyName: json["companyName"],
        taxPayerIdentificationNumber: json["taxPayerIdentificationNumber"],
        socialSecurityNumber: json["socialSecurityNumber"],
        passportNumber: json["passportNumber"],
        drivingLicenseNumber: json["drivingLicenseNumber"],
        voterIdCardNumber: json["voterIdCardNumber"],
        marketingContactId: json["marketingContactId"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"],
        modifiedBy: json["modifiedBy"],
        modifiedOn: json["modifiedOn"],
        deviceIdentifier: json["deviceIdentifier"],
        referenceIdentifier: json["referenceIdentifier"],
        isActive: json["isActive"],
        uid: json["uid"],
        appUserId: json["appUserId"],
        appUserGroupId: json["appUserGroupId"],
        isArchived: json["isArchived"],
        isDeleted: json["isDeleted"],
        leadQualificationId: json["leadQualificationId"],
        isDirty: json["isDirty"],
        isActive1: json["isActive1"],
        isDeleted1: json["isDeleted1"],
        upSyncMessage: json["upSyncMessage"],
        downSyncMessage: json["downSyncMessage"],
        sCreatedOn: json["sCreatedOn"],
        sModifiedOn: json["sModifiedOn"],
        createdByUser: json["createdByUser"],
        modifiedByUser: json["modifiedByUser"],
        upSyncIndex: json["upSyncIndex"],
        ownerUserId: json["ownerUserId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contactId": contactId,
        "contactCode": contactCode,
        "title": title,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "contactName": contactName,
        "contactIdentifier": contactIdentifier,
        "accountId": accountId,
        "departmentName": departmentName,
        "designation": designation,
        "rolesAndResponsibilities": rolesAndResponsibilities,
        "reportingManager": reportingManager,
        "reportingContactId": reportingContactId,
        "mobileNumber": mobileNumber,
        "alternateMobileNumber": alternateMobileNumber,
        "workPhone": workPhone,
        "residencePhone": residencePhone,
        "email": email,
        "alternateEmail": alternateEmail,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "addressLine3": addressLine3,
        "city": city,
        "state": state,
        "country": country,
        "pin": pin,
        "gpsCoordinates": gpsCoordinates,
        "linkedIn": linkedIn,
        "pastAccounts": pastAccounts,
        "pastDesignations": pastDesignations,
        "dateOfBirth": dateOfBirth,
        "remindBirthday": remindBirthday,
        "contactAlignmentId": contactAlignmentId,
        "remarks": remarks,
        "referenceHistory": referenceHistory,
        "isPrimaryContact": isPrimaryContact,
        "tags": tags,
        "freeTextField1": freeTextField1,
        "freeTextField2": freeTextField2,
        "freeTextField3": freeTextField3,
        "companyName": companyName,
        "taxPayerIdentificationNumber": taxPayerIdentificationNumber,
        "socialSecurityNumber": socialSecurityNumber,
        "passportNumber": passportNumber,
        "drivingLicenseNumber": drivingLicenseNumber,
        "voterIdCardNumber": voterIdCardNumber,
        "marketingContactId": marketingContactId,
        "createdBy": createdBy,
        "createdOn": createdOn,
        "modifiedBy": modifiedBy,
        "modifiedOn": modifiedOn,
        "deviceIdentifier": deviceIdentifier,
        "referenceIdentifier": referenceIdentifier,
        "isActive": isActive,
        "uid": uid,
        "appUserId": appUserId,
        "appUserGroupId": appUserGroupId,
        "isArchived": isArchived,
        "isDeleted": isDeleted,
        "leadQualificationId": leadQualificationId,
        "isDirty": isDirty,
        "isActive1": isActive1,
        "isDeleted1": isDeleted1,
        "upSyncMessage": upSyncMessage,
        "downSyncMessage": downSyncMessage,
        "sCreatedOn": sCreatedOn,
        "sModifiedOn": sModifiedOn,
        "createdByUser": createdByUser,
        "modifiedByUser": modifiedByUser,
        "upSyncIndex": upSyncIndex,
        "ownerUserId": ownerUserId,
      };
}