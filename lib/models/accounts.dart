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
    data['AccountID'] = accountID;
    data['AccountCode'] = accountCode ;
    data['AccountName'] = accountName;
    data['AccountLocation'] = accountLocation;
    data['AccountIdentifier'] = accountIdentifier ;
    data['AccountSegmentID'] = accountSegmentID ;
    data['AccountStatusID'] = accountStatusID ;
    data['AccountTypeID'] = accountTypeID ;
    data['ParentAccountID'] = parentAccountID ;
    data['IndustryName'] = industryName ;
    data['Website'] = website ;
    data['Turnover'] = turnover ;
    data['NumberOfEmployees'] = numberOfEmployees ;
    data['CreditRatingID'] = creditRatingID ;
    data['CurrencyID'] = currencyID ;
    data['PrimaryContactName'] = primaryContactName ;
    data['Phone'] = phone ;
    data['Email'] = email ;
    data['Fax'] = fax;
    data['AddressLine1'] = addressLine1 ;
    data['AddressLine2'] = addressLine2 ;
    data['AddressLine3'] = addressLine3 ;
    data['City'] = city ;
    data['State'] = state ;
    data['Country'] = country ;
    data['PIN'] = pIN ;
    data['TerritoryName'] = territoryName ;
    data['GPSCoordinates'] = gPSCoordinates ;
    data['LogoImagePath'] = logoImagePath ;
    data['LogoImageContent'] = logoImageContent ;
    data['TaxPayerIdentificationNumber'] = taxPayerIdentificationNumber ;
    data['FreeTextField1'] = freeTextField1 ;
    data['FreeTextField2'] = freeTextField2 ;
    data['FreeTextField3'] = freeTextField3 ;
    data['Tags'] = tags ;
    data['MarketingContactID'] = marketingContactID ;
    data['CreatedBy'] = createdBy ;
    data['CreatedOn'] = createdOn ;
    data['ModifiedBy'] = modifiedBy ;
    data['ModifiedOn'] = modifiedOn ;
    data['DeviceIdentifier'] = deviceIdentifier ;
    data['ReferenceIdentifier'] = referenceIdentifier ;
    data['IsActive'] = isActive ;
    data['Uid'] = uid ;
    data['AppUserID'] = appUserID ;
    data['AssignedByAppUserID'] = assignedByAppUserID ;
    data['AppUserGroupID'] = appUserGroupID ;
    data['IsArchived'] = isArchived;
    data['IsDeleted'] = isDeleted ;
    data['LeadQualificationID'] = leadQualificationID ;
    data['AccountSegmentName'] = accountSegmentName ;
    data['AccountStatusName'] = accountStatusName ;
    data['AccountTypeName'] = accountTypeName ;
    data['ParentAccountName'] = parentAccountName ;
    data['CreditRatingName'] = creditRatingName ;
    data['CurrencyName'] = currencyName ;
    data['CompanyName'] = companyName ;
    data['AppUserName'] = appUserName ;
    data['AssignedByAppUserName'] = assignedByAppUserName ;
    data['AppUserGroupName'] = appUserGroupName ;
    data['ID'] = iD ;
    data['UserLoginName'] = userLoginName ;
    data['DeviceAndLocation'] = deviceAndLocation ;
    data['UserInput'] = userInput ;
    data['AppUserUid'] = appUserUid ;
    data['AppUserGroupUid'] = appUserGroupUid ;
    data['CreatedForUser'] = createdForUser ;
    data['RowNum'] = rowNum ;
    return data ;
  }
}