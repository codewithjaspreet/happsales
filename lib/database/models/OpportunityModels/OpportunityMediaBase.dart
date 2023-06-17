import 'package:happsales_crm/database/models/BaseEntity.dart';

class OpportunityMediaBase extends BaseEntity {
  String? opportunityMediaID;
  String? opportunityMediaCode;
  String? opportunityMediaName;
  String? opportunityID;
  String? contentTypeID;
  String? mediaPath;
  String? mediaContent;
  String? description;
  String? tags;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? isActive;
  String? uid;
  String? appUserID;
  String? appUserGroupID;
  String? isArchived;
  String? isDeleted;
  String? opportunityName;
  String? contentTypeName;
  String? appUserName;
  String? appUserGroupName;
OpportunityMediaBase();
  OpportunityMediaBase.fromMapObject(Map<String, dynamic> map) {
    opportunityMediaID = map['OpportunityMediaID'];
    opportunityMediaCode = map['OpportunityMediaCode'];
    opportunityMediaName = map['OpportunityMediaName'];
    opportunityID = map['OpportunityID'];
    contentTypeID = map['ContentTypeID'];
    mediaPath = map['MediaPath'];
    mediaContent = map['MediaContent'];
    description = map['Description'];
    tags = map['Tags'];
    createdBy = map['CreatedBy'];
    createdOn = map['CreatedOn'];
    modifiedBy = map['ModifiedBy'];
    modifiedOn = map['ModifiedOn'];
    isActive = map['IsActive'];
    uid = map['Uid'];
    appUserID = map['AppUserID'];
    appUserGroupID = map['AppUserGroupID'];
    isArchived = map['IsArchived'];
    isDeleted = map['IsDeleted'];
    opportunityName = map['OpportunityName'];
    contentTypeName = map['ContentTypeName'];
    appUserName = map['AppUserName'];
    appUserGroupName = map['AppUserGroupName'];
  }

  String? get getOpportunityMediaID => opportunityMediaID;
  set setOpportunityMediaID(String? value) => opportunityMediaID = value;

  String? get getOpportunityMediaCode => opportunityMediaCode;
  set setOpportunityMediaCode(String? value) =>
      opportunityMediaCode = value;

  String? get getOpportunityMediaName => opportunityMediaName;
  set setOpportunityMediaName(String? value) =>
      opportunityMediaName = value;

  String? get getOpportunityID => opportunityID;
  set setOpportunityID(String? value) => opportunityID = value;

  String? get getContentTypeID => contentTypeID;
  set setContentTypeID(String? value) => contentTypeID = value;

  String? get getMediaPath => mediaPath;
  set setMediaPath(String? value) => mediaPath = value;

  String? get getMediaContent => mediaContent;
  set setMediaContent(String? value) => mediaContent = value;

  String? get getDescription => description;
  set setDescription(String? value) => description = value;

  String? get getTags => tags;
  set setTags(String? value) => tags = value;

  String? get getCreatedBy => createdBy;
  set setCreatedBy(String? value) => createdBy = value;

  String? get getCreatedOn => createdOn;
  set setCreatedOn(String? value) => createdOn = value;

  String? get getModifiedBy => modifiedBy;
  set setModifiedBy(String? value) => modifiedBy = value;

  String? get getModifiedOn => modifiedOn;
  set setModifiedOn(String? value) => modifiedOn = value;

  String? get getIsActive => isActive;
  set setIsActive(String? value) => isActive = value;

  String? get getUid => uid;
  set setUid(String? value) => uid = value;

  String? get getAppUserID => appUserID;
  set setAppUserID(String? value) => appUserID = value;

  String? get getAppUserGroupID => appUserGroupID;
  set setAppUserGroupID(String? value) => appUserGroupID = value;

  String? get getIsArchived => isArchived;
  set setIsArchived(String? value) => isArchived = value;

  String? get getIsDeleted => isDeleted;
  set setIsDeleted(String? value) => isDeleted = value;

  String? get getOpportunityName => opportunityName;
  set setOpportunityName(String? value) => opportunityName = value;

  String? get getContentTypeName => contentTypeName;
  set setContentTypeName(String? value) => contentTypeName = value;

  String? get getAppUserName => appUserName;
  set setAppUserName(String? value) => appUserName = value;

  String? get getAppUserGroupName => appUserGroupName;
  set setAppUserGroupName(String? value) => appUserGroupName = value;

  Map<String, dynamic> toMap() {
    return {
      'OpportunityMediaID': opportunityMediaID,
      'OpportunityMediaCode': opportunityMediaCode,
      'OpportunityMediaName': opportunityMediaName,
      'OpportunityID': opportunityID,
      'ContentTypeID': contentTypeID,
      'MediaPath': mediaPath,
      'MediaContent': mediaContent,
      'Description': description,
      'Tags': tags,
      'CreatedBy': createdBy,
      'CreatedOn': createdOn,
      'ModifiedBy': modifiedBy,
      'ModifiedOn': modifiedOn,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'OpportunityName': opportunityName,
      'ContentTypeName': contentTypeName,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }
}
