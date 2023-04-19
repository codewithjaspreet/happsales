class Account {
  int? accountID;
  String? accountCode;
  String? accountName;
  String? accountLocation;
  String? accountIdentifier;
  int? accountSegmentID;
  int? accountStatusID;
  String? accountTypeID;
  String? parentAccountID;
  String? industryName;
  String? website;
  String? turnover;
  String? numberOfEmployees;
  String? creditRatingID;
  int? currencyID;
  String? primaryContactName;
  String? phone;
  String? email;
  String? fax;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? state;
  String? country;
  String? pIN;
  String? territoryName;
  String? gPSCoordinates;
  String? logoImagePath;
  String? logoImageContent;
  String? taxPayerIdentificationNumber;
  String? freeTextField1;
  String? freeTextField2;
  String? freeTextField3;
  String? tags;
  String? marketingContactID;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? deviceIdentifier;
  String? referenceIdentifier;
  bool? isActive;
  String? uid;
  int? appUserID;
  String? assignedByAppUserID;
  int? appUserGroupID;
  bool? isArchived;
  bool? isDeleted;
  String? leadQualificationID;
  String? accountSegmentName;
  String? accountStatusName;
  String? accountTypeName;
  String? parentAccountName;
  String? creditRatingName;
  String? currencyName;
  String? companyName;
  String? appUserName;
  String? assignedByAppUserName;
  String? appUserGroupName;
  String? iD;
  String? userLoginName;
  String? deviceAndLocation;
  String? userInput;
  String? appUserUid;
  String? appUserGroupUid;
  String? createdForUser;
  String? rowNum;

  Account(
      {this.accountID,
        this.accountCode,
        this.accountName,
        this.accountLocation,
        this.accountIdentifier,
        this.accountSegmentID,
        this.accountStatusID,
        this.accountTypeID,
        this.parentAccountID,
        this.industryName,
        this.website,
        this.turnover,
        this.numberOfEmployees,
        this.creditRatingID,
        this.currencyID,
        this.primaryContactName,
        this.phone,
        this.email,
        this.fax,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.city,
        this.state,
        this.country,
        this.pIN,
        this.territoryName,
        this.gPSCoordinates,
        this.logoImagePath,
        this.logoImageContent,
        this.taxPayerIdentificationNumber,
        this.freeTextField1,
        this.freeTextField2,
        this.freeTextField3,
        this.tags,
        this.marketingContactID,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.deviceIdentifier,
        this.referenceIdentifier,
        this.isActive,
        this.uid,
        this.appUserID,
        this.assignedByAppUserID,
        this.appUserGroupID,
        this.isArchived,
        this.isDeleted,
        this.leadQualificationID,
        this.accountSegmentName,
        this.accountStatusName,
        this.accountTypeName,
        this.parentAccountName,
        this.creditRatingName,
        this.currencyName,
        this.companyName,
        this.appUserName,
        this.assignedByAppUserName,
        this.appUserGroupName,
        this.iD,
        this.userLoginName,
        this.deviceAndLocation,
        this.userInput,
        this.appUserUid,
        this.appUserGroupUid,
        this.createdForUser,
        this.rowNum});

  Account.fromJson(Map<String, dynamic> json) {
    accountID = json['AccountID'] ?? 0;
    accountCode = json['AccountCode'] ?? '-';
    accountName = json['AccountName'] ?? '-';
    accountLocation = json['AccountLocation'] ?? '-';
    accountIdentifier = json['AccountIdentifier'] ?? '-';
    accountSegmentID = json['AccountSegmentID'] ?? 0;
    accountStatusID = json['AccountStatusID'] ?? 0;
    accountTypeID = json['AccountTypeID'] ?? '-';
    parentAccountID = json['ParentAccountID'] ?? '-';
    industryName = json['IndustryName'] ?? 'Chemical';
    website = json['Website'] ??  'www.suvarnatraders.com';
    turnover = json['Turnover'] ?? '150';
    numberOfEmployees = json['NumberOfEmployees']   ?? '1150';
    creditRatingID = json['CreditRatingID'] ?? '-';
    currencyID = json['CurrencyID'] ?? 0;
    primaryContactName = json['PrimaryContactName'] ?? '-';
    phone = json['Phone'] ?? '080 2222 5555';
    email = json['Email'] ?? '-';
    fax = json['Fax'] ?? '-';
    addressLine1 = json['AddressLine1'] ?? '-';
    addressLine2 = json['AddressLine2'] ?? '-';
    addressLine3 = json['AddressLine3'] ?? '-';
    city = json['City'] ?? '-';
    state = json['State'] ?? 'Onboarded';
    country = json['Country'] ?? '-';
    pIN = json['PIN'] ?? '-';
    territoryName = json['TerritoryName'] ?? '-';
    gPSCoordinates = json['GPSCoordinates'] ?? '-';
    logoImagePath = json['LogoImagePath'] ?? '-';
    logoImageContent = json['LogoImageContent']   ?? '-';
    taxPayerIdentificationNumber = json['TaxPayerIdentificationNumber'] ?? '-';
    freeTextField1 = json['FreeTextField1'] ?? '-';
    freeTextField2 = json['FreeTextField2'] ?? '-';
    freeTextField3 = json['FreeTextField3'] ?? '-';
    tags = json['Tags'] ?? 'open';
    marketingContactID = json['MarketingContactID'] ?? '-';
    createdBy = json['CreatedBy']   ?? '-';
    createdOn = json['CreatedOn'] ?? '-';
    modifiedBy = json['ModifiedBy'] ?? '-';
    modifiedOn = json['ModifiedOn'] ?? '-';
    deviceIdentifier = json['DeviceIdentifier'] ?? '-';
    referenceIdentifier = json['ReferenceIdentifier'] ?? '-';
    isActive = json['IsActive'] ?? false;
    uid = json['Uid'] ?? '-';
    appUserID = json['AppUserID'] ?? 0;
    assignedByAppUserID = json['AssignedByAppUserID'] ?? '-';
    appUserGroupID = json['AppUserGroupID'] ?? 0;
    isArchived = json['IsArchived'] ?? false;
    isDeleted = json['IsDeleted'] ?? false;
    leadQualificationID = json['LeadQualificationID'] ?? '-';
    accountSegmentName = json['AccountSegmentName'] ?? 'medium Enterprise';
    accountStatusName = json['AccountStatusName'] ?? '-';
    accountTypeName = json['AccountTypeName'] ?? 'Organisation';
    parentAccountName = json['ParentAccountName'] ?? '-';
    creditRatingName = json['CreditRatingName'] ?? '-';
    currencyName = json['CurrencyName'] ?? 'Rupees';
    companyName = json['CompanyName'] ?? '-';
    appUserName = json['AppUserName'] ?? '-';
    assignedByAppUserName = json['AssignedByAppUserName'] ?? '-';
    appUserGroupName = json['AppUserGroupName'] ?? '-';
    iD = json['ID'] ?? '-';
    userLoginName = json['UserLoginName'] ?? '-';
    deviceAndLocation = json['DeviceAndLocation'] ?? '-';
    userInput = json['UserInput'] ?? '-';
    appUserUid = json['AppUserUid'] ?? '-';
    appUserGroupUid = json['AppUserGroupUid'] ?? '-';
    createdForUser = json['CreatedForUser'] ?? '-';
    rowNum = json['RowNum'] ?? '-';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['AccountID'] = this.accountID;
    data['AccountCode'] = this.accountCode ;
    data['AccountName'] = this.accountName;
    data['AccountLocation'] = this.accountLocation;
    data['AccountIdentifier'] = this.accountIdentifier ;
    data['AccountSegmentID'] = this.accountSegmentID ;
    data['AccountStatusID'] = this.accountStatusID ;
    data['AccountTypeID'] = this.accountTypeID ;
    data['ParentAccountID'] = this.parentAccountID ;
    data['IndustryName'] = this.industryName ;
    data['Website'] = this.website ;
    data['Turnover'] = this.turnover ;
    data['NumberOfEmployees'] = this.numberOfEmployees ;
    data['CreditRatingID'] = this.creditRatingID ;
    data['CurrencyID'] = this.currencyID ;
    data['PrimaryContactName'] = this.primaryContactName ;
    data['Phone'] = this.phone ;
    data['Email'] = this.email ;
    data['Fax'] = this.fax;
    data['AddressLine1'] = this.addressLine1 ;
    data['AddressLine2'] = this.addressLine2 ;
    data['AddressLine3'] = this.addressLine3 ;
    data['City'] = this.city ;
    data['State'] = this.state ;
    data['Country'] = this.country ;
    data['PIN'] = this.pIN ;
    data['TerritoryName'] = this.territoryName ;
    data['GPSCoordinates'] = this.gPSCoordinates ;
    data['LogoImagePath'] = this.logoImagePath ;
    data['LogoImageContent'] = this.logoImageContent ;
    data['TaxPayerIdentificationNumber'] = this.taxPayerIdentificationNumber ;
    data['FreeTextField1'] = this.freeTextField1 ;
    data['FreeTextField2'] = this.freeTextField2 ;
    data['FreeTextField3'] = this.freeTextField3 ;
    data['Tags'] = this.tags ;
    data['MarketingContactID'] = this.marketingContactID ;
    data['CreatedBy'] = this.createdBy ;
    data['CreatedOn'] = this.createdOn ;
    data['ModifiedBy'] = this.modifiedBy ;
    data['ModifiedOn'] = this.modifiedOn ;
    data['DeviceIdentifier'] = this.deviceIdentifier ;
    data['ReferenceIdentifier'] = this.referenceIdentifier ;
    data['IsActive'] = this.isActive ;
    data['Uid'] = this.uid ;
    data['AppUserID'] = this.appUserID ;
    data['AssignedByAppUserID'] = this.assignedByAppUserID ;
    data['AppUserGroupID'] = this.appUserGroupID ;
    data['IsArchived'] = this.isArchived;
    data['IsDeleted'] = this.isDeleted ;
    data['LeadQualificationID'] = this.leadQualificationID ;
    data['AccountSegmentName'] = this.accountSegmentName ;
    data['AccountStatusName'] = this.accountStatusName ;
    data['AccountTypeName'] = this.accountTypeName ;
    data['ParentAccountName'] = this.parentAccountName ;
    data['CreditRatingName'] = this.creditRatingName ;
    data['CurrencyName'] = this.currencyName ;
    data['CompanyName'] = this.companyName ;
    data['AppUserName'] = this.appUserName ;
    data['AssignedByAppUserName'] = this.assignedByAppUserName ;
    data['AppUserGroupName'] = this.appUserGroupName ;
    data['ID'] = this.iD ;
    data['UserLoginName'] = this.userLoginName ;
    data['DeviceAndLocation'] = this.deviceAndLocation ;
    data['UserInput'] = this.userInput ;
    data['AppUserUid'] = this.appUserUid ;
    data['AppUserGroupUid'] = this.appUserGroupUid ;
    data['CreatedForUser'] = this.createdForUser ;
    data['RowNum'] = this.rowNum ;
    return data ;
  }
}