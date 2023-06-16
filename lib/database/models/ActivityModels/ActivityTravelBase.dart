import 'package:happsales_crm/database/models/BaseEntity.dart';

class ActivityTravelBase extends BaseEntity {
  String? _activityTravelID;
  String? _activityTravelCode;
  String? _activityTravelTitle;
  String? _activityID;
  String? _activityTravelDate;
  String? _activityTravelEndDate;
  String? _travelPurposeName;
  String? _startLocation;
  String? _endLocation;
  String? _startLocationCoordinate;
  String? _endLocationCoordinate;
  String? _actualDistance;
  String? _distanceTravelled;
  String? _modeOfTravelID;
  String? _travelExpense;
  String? _reasonForDeviation;
  String? _otherExpense;
  String? _totalExpense;
  String? _tags;
  String? _isSubmitted;
  String? _remarks;
  String? _approvalStatus;
  String? _approvedTime;
  String? _approverRemarks;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _location;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _activityTitle;
  String? _modeOfTravelName;
  String? _approvedByAppUserName;
  String? _appUserName;
  String? _appUserGroupName;

  ActivityTravelBase();

  String? get activityTravelID => _activityTravelID;
  set activityTravelID(String? value) => _activityTravelID = value;

  String? get activityTravelCode => _activityTravelCode;
  set activityTravelCode(String? value) => _activityTravelCode = value;

  String? get activityTravelTitle => _activityTravelTitle;
  set activityTravelTitle(String? value) => _activityTravelTitle = value;

  String? get activityID => _activityID;
  set activityID(String? value) => _activityID = value;

  String? get activityTravelDate => _activityTravelDate;
  set activityTravelDate(String? value) => _activityTravelDate = value;

  String? get activityTravelEndDate => _activityTravelEndDate;
  set activityTravelEndDate(String? value) => _activityTravelEndDate = value;

  String? get travelPurposeName => _travelPurposeName;
  set travelPurposeName(String? value) => _travelPurposeName = value;

  String? get startLocation => _startLocation;
  set startLocation(String? value) => _startLocation = value;

  String? get endLocation => _endLocation;
  set endLocation(String? value) => _endLocation = value;

  String? get startLocationCoordinate => _startLocationCoordinate;
  set startLocationCoordinate(String? value) => _startLocationCoordinate = value;

  String? get endLocationCoordinate => _endLocationCoordinate;
  set endLocationCoordinate(String? value) => _endLocationCoordinate = value;

  String? get actualDistance => _actualDistance;
  set actualDistance(String? value) => _actualDistance = value;

  String? get distanceTravelled => _distanceTravelled;
  set distanceTravelled(String? value) => _distanceTravelled = value;

  String? get modeOfTravelID => _modeOfTravelID;
  set modeOfTravelID(String? value) => _modeOfTravelID = value;

  String? get travelExpense => _travelExpense;
  set travelExpense(String? value) => _travelExpense = value;

  String? get reasonForDeviation => _reasonForDeviation;
  set reasonForDeviation(String? value) => _reasonForDeviation = value;

  String? get otherExpense => _otherExpense;
  set otherExpense(String? value) => _otherExpense = value;

  String? get totalExpense => _totalExpense;
  set totalExpense(String? value) => _totalExpense = value;

  String? get tags => _tags;
  set tags(String? value) => _tags = value;

  String? get isSubmitted => _isSubmitted;
  set isSubmitted(String? value) => _isSubmitted = value;

  String? get remarks => _remarks;
  set remarks(String? value) => _remarks = value;

  String? get approvalStatus => _approvalStatus;
  set approvalStatus(String? value) => _approvalStatus = value;

  String? get approvedTime => _approvedTime;
  set approvedTime(String? value) => _approvedTime = value;

  String? get approverRemarks => _approverRemarks;
  set approverRemarks(String? value) => _approverRemarks = value;

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

  String? get location => _location;
  set location(String? value) => _location = value;

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

  String? get activityTitle => _activityTitle;
  set activityTitle(String? value) => _activityTitle = value;

  String? get modeOfTravelName => _modeOfTravelName;
  set modeOfTravelName(String? value) => _modeOfTravelName = value;

  String? get approvedByAppUserName => _approvedByAppUserName;
  set approvedByAppUserName(String? value) => _approvedByAppUserName = value;

  String? get appUserName => _appUserName;
  set appUserName(String? value) => _appUserName = value;

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) => _appUserGroupName = value;

  ActivityTravelBase.toJson() {
    final Map<String, dynamic> data = {
      'ActivityTravelID': _activityTravelID,
      'ActivityTravelCode': _activityTravelCode,
      'ActivityTravelTitle': _activityTravelTitle,
      'ActivityID': _activityID,
      'ActivityTravelDate': _activityTravelDate,
      'ActivityTravelEndDate': _activityTravelEndDate,
      'TravelPurposeName': _travelPurposeName,
      'StartLocation': _startLocation,
      'EndLocation': _endLocation,
      'StartLocationCoordinate': _startLocationCoordinate,
      'EndLocationCoordinate': _endLocationCoordinate,
      'ActualDistance': _actualDistance,
      'DistanceTravelled': _distanceTravelled,
      'ModeOfTravelID': _modeOfTravelID,
      'TravelExpense': _travelExpense,
      'ReasonForDeviation': _reasonForDeviation,
      'OtherExpense': _otherExpense,
      'TotalExpense': _totalExpense,
      'Tags': _tags,
      'IsSubmitted': _isSubmitted,
      'Remarks': _remarks,
      'ApprovalStatus': _approvalStatus,
      'ApprovedTime': _approvedTime,
      'ApproverRemarks': _approverRemarks,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'DeviceIdentifier': _deviceIdentifier,
      'ReferenceIdentifier': _referenceIdentifier,
      'Location': _location,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'ActivityTitle': _activityTitle,
      'ModeOfTravelName': _modeOfTravelName,
      'ApprovedByAppUserName': _approvedByAppUserName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  ActivityTravelBase.fromMapObject(Map<String,dynamic> map){

    _activityID = map['ActivityID'];
    _activityTravelID = map['ActivityTravelID'];
    _activityTravelCode = map['ActivityTravelCode'];
    _activityTravelTitle = map['ActivityTravelTitle'];
    _activityTravelDate = map['ActivityTravelDate'];
    _activityTravelEndDate = map['ActivityTravelEndDate'];
    _travelPurposeName = map['TravelPurposeName'];
    _startLocation = map['StartLocation'];
    _endLocation = map['EndLocation'];
    _startLocationCoordinate = map['StartLocationCoordinate'];
    _endLocationCoordinate = map['EndLocationCoordinate'];
    _actualDistance = map['ActualDistance'];
    _distanceTravelled = map['DistanceTravelled'];

    _modeOfTravelID = map['ModeOfTravelID'];
    _travelExpense = map['TravelExpense'];
    _reasonForDeviation = map['ReasonForDeviation'];
    _otherExpense = map['OtherExpense'];
    _totalExpense = map['TotalExpense'];
    _tags = map['Tags'];
    _isSubmitted = map['IsSubmitted'];
    _remarks = map['Remarks'];
    _approvalStatus = map['ApprovalStatus'];
    _approvedTime = map['ApprovedTime'];
    _approverRemarks = map['ApproverRemarks'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _location = map['Location'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];

    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _activityTitle = map['ActivityTitle'];
    _modeOfTravelName = map['ModeOfTravelName'];
    _approvedByAppUserName = map['ApprovedByAppUserName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];


  }

 


}
