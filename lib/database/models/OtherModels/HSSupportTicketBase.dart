import 'package:happsales_crm/database/models/BaseEntity.dart';

class HSSupportTicketBase extends BaseEntity {
  String? _hSSupportTicketID;
  String? _hSSupportTicketCode;
  String? _hSSupportTicketTitle;
  String? _hSSupportTicketType;
  String? _hSSupportTicketDetail;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _parentHSSupportTicketID;
  String? _assignedToHSUserID;
  String? _ticketStatus;
  String? _resolution;
  String? _resolutionTime;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;

  String? _assignedToHSUserName;
  String? _appUserName;
  String? _appUserGroupName;

  HSSupportTicketBase();

  String? get hSSupportTicketID => _hSSupportTicketID;
  set hSSupportTicketID(String? value) {
    _hSSupportTicketID = value;
  }

  String? get hSSupportTicketCode => _hSSupportTicketCode;
  set hSSupportTicketCode(String? value) {
    _hSSupportTicketCode = value;
  }

  String? get hSSupportTicketTitle => _hSSupportTicketTitle;
  set hSSupportTicketTitle(String? value) {
    _hSSupportTicketTitle = value;
  }

  String? get hSSupportTicketType => _hSSupportTicketType;
  set hSSupportTicketType(String? value) {
    _hSSupportTicketType = value;
  }

  String? get hSSupportTicketDetail => _hSSupportTicketDetail;
  set hSSupportTicketDetail(String? value) {
    _hSSupportTicketDetail = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get parentHSSupportTicketID => _parentHSSupportTicketID;
  set parentHSSupportTicketID(String? value) {
    _parentHSSupportTicketID = value;
  }

  String? get assignedToHSUserID => _assignedToHSUserID;
  set assignedToHSUserID(String? value) {
    _assignedToHSUserID = value;
  }

  String? get ticketStatus => _ticketStatus;
  set ticketStatus(String? value) {
    _ticketStatus = value;
  }

  String? get resolution => _resolution;
  set resolution(String? value) {
    _resolution = value;
  }

  String? get resolutionTime => _resolutionTime;
  set resolutionTime(String? value) {
    _resolutionTime = value;
  }

  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get assignedToHSUserName => _assignedToHSUserName;
  set assignedToHSUserName(String? value) {
    _assignedToHSUserName = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'HSSupportTicketID': _hSSupportTicketID,
      'HSSupportTicketCode': _hSSupportTicketCode,
      'HSSupportTicketTitle': _hSSupportTicketTitle,
      'HSSupportTicketType': _hSSupportTicketType,
      'HSSupportTicketDetail': _hSSupportTicketDetail,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'ParentHSSupportTicketID': _parentHSSupportTicketID,
      'AssignedToHSUserID': _assignedToHSUserID,
      'TicketStatus': _ticketStatus,
      'Resolution': _resolution,
      'ResolutionTime': _resolutionTime,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
      'AssignedToHSUserName': _assignedToHSUserName,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  HSSupportTicketBase.fromMapObject(Map<String, dynamic> map) {
    _hSSupportTicketID = map['HSSupportTicketID'];
    _hSSupportTicketCode = map['HSSupportTicketCode'];
    _hSSupportTicketTitle = map['HSSupportTicketTitle'];
    _hSSupportTicketType = map['HSSupportTicketType'];
    _hSSupportTicketDetail = map['HSSupportTicketDetail'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _parentHSSupportTicketID = map['ParentHSSupportTicketID'];
    _assignedToHSUserID = map['AssignedToHSUserID'];
    _ticketStatus = map['TicketStatus'];
    _resolution = map['Resolution'];
    _resolutionTime = map['ResolutionTime'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isDeleted = map['IsDeleted'];
    _assignedToHSUserName = map['AssignedToHSUserName'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
