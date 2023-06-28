import 'package:happsales_crm/database/models/BaseEntity.dart';

class AppUserBase  extends BaseEntity{
  String? _appUserID;
  String? _appUserCode;
  String? _appUserName;
  String? _appUserTypeID;
  String? _designation;
  String? _mobileNumber;
  String? _email;
  String? _officialAddress;
  String? _employeeId;
  String? _loginName;
  String? _passCode;
  String? _reportingToAppUserID1;
  String? _reportingToAppUserID2;
  String? _reportingToAppUserID3;
  String? _profilePicture;
  String? _profileCaption;
  String? _profileLocation;
  String? _companyLogo;
  String? _companyCaption;
  String? _useCompanyLogo;
  String? _timeZoneCode;
  String? _currecyCode;
  String? _currentLoginOn;
  String? _lastLoginOn;
  String? _appLastLoginOn;
  String? _passCodeLastChangedOn;
  String? _isMailSent;
  String? _accountSort;
  String? _contactSort;
  String? _activityPlannedSort;
  String? _activityInProcessSort;
  String? _activityCompletedSort;
  String? _activityOthersSort;
  String? _opportunityOnGoingSort;
  String? _opportunityWonSort;
  String? _opportunityClosedSort;
  String? _opportunityDeliveredSort;
  String? _noteSort;
  String? _accountAddressSort;
  String? _accountBuyingProcessSort;
  String? _accountBusinessPlanSort;
  String? _accountCompetitionActivitySort;
  String? _accountMediaSort;
  String? _userToken;
  String? _isSystemDefined;
  String? _configuration;
  String? _systemConfiguration;
  String? _isWor;
  String? _isAppAllowed;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _isActive;
  String? _uid;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserTypeName;
  String? _reportingTo1AppUserName;
  String? _reportingTo2AppUserName;
  String? _reportingTo3AppUserName;
  String? _appUserGroupName;

  String? get appUserID => _appUserID;
  set appUserID(String? value) => _appUserID = value;

  String? get appUserCode => _appUserCode;
  set appUserCode(String? value) => _appUserCode = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserTypeID => _appUserTypeID;
  set appUserTypeID(String? value) => _appUserTypeID = value;

  String? get designation => _designation;
  set designation(String? value) => _designation = value;

  String? get mobileNumber => _mobileNumber;
  set mobileNumber(String? value) => _mobileNumber = value;

  String? get email => _email;
  set email(String? value) => _email = value;

  String? get officialAddress => _officialAddress;
  set officialAddress(String? value) => _officialAddress = value;

  String? get employeeId => _employeeId;
  set employeeId(String? value) => _employeeId = value;

  String? get loginName => _loginName;
  set loginName(String? value) => _loginName = value;

  String? get passCode => _passCode;
  set passCode(String? value) => _passCode = value;

  String? get reportingToAppUserID1 => _reportingToAppUserID1;
  set reportingToAppUserID1(String? value) => _reportingToAppUserID1 = value;

  String? get reportingToAppUserID2 => _reportingToAppUserID2;
  set reportingToAppUserID2(String? value) => _reportingToAppUserID2 = value;

  String? get reportingToAppUserID3 => _reportingToAppUserID3;
  set reportingToAppUserID3(String? value) => _reportingToAppUserID3 = value;

  String? get profilePicture => _profilePicture;
  set profilePicture(String? value) => _profilePicture = value;

  String? get profileCaption => _profileCaption;
  set profileCaption(String? value) => _profileCaption = value;

  String? get profileLocation => _profileLocation;
  set profileLocation(String? value) => _profileLocation = value;

  String? get companyLogo => _companyLogo;
  set companyLogo(String? value) => _companyLogo = value;

  String? get companyCaption => _companyCaption;
  set companyCaption(String? value) => _companyCaption = value;

  String? get useCompanyLogo => _useCompanyLogo;
  set useCompanyLogo(String? value) => _useCompanyLogo = value;

  String? get timeZoneCode => _timeZoneCode;
  set timeZoneCode(String? value) => _timeZoneCode = value;

  String? get currecyCode => _currecyCode;
  set currecyCode(String? value) => _currecyCode = value;

  String? get currentLoginOn => _currentLoginOn;
  set currentLoginOn(String? value) => _currentLoginOn = value;

  String? get lastLoginOn => _lastLoginOn;
  set lastLoginOn(String? value) => _lastLoginOn = value;

  String? get appLastLoginOn => _appLastLoginOn;
  set appLastLoginOn(String? value) => _appLastLoginOn = value;

  String? get passCodeLastChangedOn => _passCodeLastChangedOn;
  set passCodeLastChangedOn(String? value) => _passCodeLastChangedOn = value;

  String? get isMailSent => _isMailSent;
  set isMailSent(String? value) => _isMailSent = value;

  String? get accountSort => _accountSort;
  set accountSort(String? value) => _accountSort = value;

  String? get contactSort => _contactSort;
  set contactSort(String? value) => _contactSort = value;

  String? get activityPlannedSort => _activityPlannedSort;
  set activityPlannedSort(String? value) => _activityPlannedSort = value;

  String? get activityInProcessSort => _activityInProcessSort;
  set activityInProcessSort(String? value) => _activityInProcessSort = value;

  String? get activityCompletedSort => _activityCompletedSort;
  set activityCompletedSort(String? value) => _activityCompletedSort = value;

  String? get activityOthersSort => _activityOthersSort;
  set activityOthersSort(String? value) => _activityOthersSort = value;

  String? get opportunityOnGoingSort => _opportunityOnGoingSort;
  set opportunityOnGoingSort(String? value) => _opportunityOnGoingSort = value;

  String? get opportunityWonSort => _opportunityWonSort;
  set opportunityWonSort(String? value) => _opportunityWonSort = value;

  String? get opportunityClosedSort => _opportunityClosedSort;
  set opportunityClosedSort(String? value) => _opportunityClosedSort = value;

  String? get opportunityDeliveredSort => _opportunityDeliveredSort;
  set opportunityDeliveredSort(String? value) => _opportunityDeliveredSort = value;

  String? get noteSort => _noteSort;
  set noteSort(String? value) => _noteSort = value;

  String? get accountAddressSort => _accountAddressSort;
  set accountAddressSort(String? value) => _accountAddressSort = value;

  String? get accountBuyingProcessSort => _accountBuyingProcessSort;
  set accountBuyingProcessSort(String? value) =>
      _accountBuyingProcessSort = value;

  String? get accountBusinessPlanSort => _accountBusinessPlanSort;
  set accountBusinessPlanSort(String? value) => _accountBusinessPlanSort = value;

  String? get accountCompetitionActivitySort => _accountCompetitionActivitySort;
  set accountCompetitionActivitySort(String? value) =>
      _accountCompetitionActivitySort = value;

  String? get accountMediaSort => _accountMediaSort;
  set accountMediaSort(String? value) => _accountMediaSort = value;

  String? get userToken => _userToken;
  set userToken(String? value) => _userToken = value;

  String? get isSystemDefined => _isSystemDefined;
  set isSystemDefined(String? value) => _isSystemDefined = value;

  String? get configuration => _configuration;
  set configuration(String? value) => _configuration = value;

  String? get systemConfiguration => _systemConfiguration;
  set systemConfiguration(String? value) => _systemConfiguration = value;

  String? get isWor => _isWor;
  set isWor(String? value) => _isWor = value;

  String? get isAppAllowed => _isAppAllowed;
  set isAppAllowed(String? value) => _isAppAllowed = value;

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

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) => _appUserGroupID = value;

  String? get isArchived => _isArchived;
  set isArchived(String? value) => _isArchived = value;

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) => _isDeleted = value;

  String? get appUserTypeName => _appUserTypeName;
  set appUserTypeName(String? value) => _appUserTypeName = value;

  String? get reportingTo1AppUserName => _reportingTo1AppUserName;
  set reportingTo1AppUserName(String? value) =>
      _reportingTo1AppUserName = value;

  String? get reportingTo2AppUserName => _reportingTo2AppUserName;
  set reportingTo2AppUserName(String? value) =>
      _reportingTo2AppUserName = value;

  String? get reportingTo3AppUserName => _reportingTo3AppUserName;
  set reportingTo3AppUserName(String? value) =>
      _reportingTo3AppUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  AppUserBase();

  Map<String, dynamic> toMap() {
    return {
      'AppUserID': appUserID,
      'AppUserCode': appUserCode,
      'AppUserName': appUserName,
      'AppUserTypeID': appUserTypeID,
      'Designation': designation,
      'MobileNumber': mobileNumber,
      'Email': email,
      'OfficialAddress': officialAddress,
      'EmployeeId': employeeId,
      'LoginName': loginName,
      'PassCode': passCode,
      'ReportingToAppUserID1': reportingToAppUserID1,
      'ReportingToAppUserID2': reportingToAppUserID2,
      'ReportingToAppUserID3': reportingToAppUserID3,
      'ProfilePicture': profilePicture,
      'ProfileCaption': profileCaption,
      'ProfileLocation': profileLocation,
      'CompanyLogo': companyLogo,
      'CompanyCaption': companyCaption,
      'UseCompanyLogo': useCompanyLogo,
      'TimeZoneCode': timeZoneCode,
      'CurrecyCode': currecyCode,
      'CurrentLoginOn': currentLoginOn,
      'LastLoginOn': lastLoginOn,
      'AppLastLoginOn': appLastLoginOn,
      'PassCodeLastChangedOn': passCodeLastChangedOn,
      'IsMailSent': isMailSent,
      'AccountSort': accountSort,
      'ContactSort': contactSort,
      'ActivityPlannedSort': activityPlannedSort,
      'ActivityInProcessSort': activityInProcessSort,
      'ActivityCompletedSort': activityCompletedSort,
      'ActivityOthersSort': activityOthersSort,
      'OpportunityOnGoingSort': opportunityOnGoingSort,
      'OpportunityWonSort': opportunityWonSort,
      'OpportunityClosedSort': opportunityClosedSort,
      'OpportunityDeliveredSort': opportunityDeliveredSort,
      'NoteSort': noteSort,
      'AccountAddressSort': accountAddressSort,
      'AccountBuyingProcessSort': accountBuyingProcessSort,
      'AccountBusinessPlanSort': accountBusinessPlanSort,
      'AccountCompetitionActivitySort': accountCompetitionActivitySort,
      'AccountMediaSort': accountMediaSort,
      'UserToken': userToken,
      'IsSystemDefined': isSystemDefined,
      'Configuration': configuration,
      'SystemConfiguration': systemConfiguration,
      'IsWor': isWor,
      'IsAppAllowed': isAppAllowed,
      'CreatedBy': createdBy,
      'CreatedOn': createdOn,
      'ModifiedBy': modifiedBy,
      'ModifiedOn': modifiedOn,
      'DeviceIdentifier': deviceIdentifier,
      'ReferenceIdentifier': referenceIdentifier,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'AppUserTypeName': appUserTypeName,
      'ReportingTo1AppUserName': reportingTo1AppUserName,
      'ReportingTo2AppUserName': reportingTo2AppUserName,
      'ReportingTo3AppUserName': reportingTo3AppUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   AppUserBase.fromMap(Map<String, dynamic> map) {
      appUserID: map['AppUserID'];
      appUserCode: map['AppUserCode'];
      appUserName: map['AppUserName'];
      appUserTypeID: map['AppUserTypeID'];
      designation: map['Designation'];
      mobileNumber: map['MobileNumber'];
      email: map['Email'];
      officialAddress: map['OfficialAddress'];
      employeeId: map['EmployeeId'];
      loginName: map['LoginName'];
      passCode: map['PassCode'];
      reportingToAppUserID1: map['ReportingToAppUserID1'];
      reportingToAppUserID2: map['ReportingToAppUserID2'];
      reportingToAppUserID3: map['ReportingToAppUserID3'];
      profilePicture: map['ProfilePicture'];
      profileCaption: map['ProfileCaption'];
      profileLocation: map['ProfileLocation'];
      companyLogo: map['CompanyLogo'];
      companyCaption: map['CompanyCaption'];
      useCompanyLogo: map['UseCompanyLogo'];
      timeZoneCode: map['TimeZoneCode'];
      currecyCode: map['CurrecyCode'];
      currentLoginOn: map['CurrentLoginOn'];
      lastLoginOn: map['LastLoginOn'];
      appLastLoginOn: map['AppLastLoginOn'];
      passCodeLastChangedOn: map['PassCodeLastChangedOn'];
      isMailSent: map['IsMailSent'];
      accountSort: map['AccountSort'];
      contactSort: map['ContactSort'];
      activityPlannedSort: map['ActivityPlannedSort'];
      activityInProcessSort: map['ActivityInProcessSort'];
      activityCompletedSort: map['ActivityCompletedSort'];
      activityOthersSort: map['ActivityOthersSort'];
      opportunityOnGoingSort: map['OpportunityOnGoingSort'];
      opportunityWonSort: map['OpportunityWonSort'];
      opportunityClosedSort: map['OpportunityClosedSort'];
      opportunityDeliveredSort: map['OpportunityDeliveredSort'];
      noteSort: map['NoteSort'];
      accountAddressSort: map['AccountAddressSort'];
      accountBuyingProcessSort: map['AccountBuyingProcessSort'];
      accountBusinessPlanSort: map['AccountBusinessPlanSort'];
      accountCompetitionActivitySort: map['AccountCompetitionActivitySort'];
      accountMediaSort: map['AccountMediaSort'];
      userToken: map['UserToken'];
      isSystemDefined: map['IsSystemDefined'];
      configuration: map['Configuration'];
      systemConfiguration: map['SystemConfiguration'];
      isWor: map['IsWor'];
      isAppAllowed: map['IsAppAllowed'];
      createdBy: map['CreatedBy'];
      createdOn: map['CreatedOn'];
      modifiedBy: map['ModifiedBy'];
      modifiedOn: map['ModifiedOn'];
      deviceIdentifier: map['DeviceIdentifier'];
      referenceIdentifier: map['ReferenceIdentifier'];
      isActive: map['IsActive'];
      uid: map['Uid'];
      appUserGroupID: map['AppUserGroupID'];
      isArchived: map['IsArchived'];
      isDeleted: map['IsDeleted'];
      appUserTypeName: map['AppUserTypeName'];
      reportingTo1AppUserName: map['ReportingTo1AppUserName'];
      reportingTo2AppUserName: map['ReportingTo2AppUserName'];
      reportingTo3AppUserName: map['ReportingTo3AppUserName'];
      appUserGroupName: map['AppUserGroupName'];
    
  }
}
