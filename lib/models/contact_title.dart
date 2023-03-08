class ContactTitle {
  int id;
  String contactTitleId;
  String contactTitleCode;
  String contactTitleName;
  String createdOn;
  String createdBy;
  String modifiedOn;
  String modifiedBy;
  String isActive;
  String uid;
  String appUserId;
  String appUserGroupId;
  String isArchived;
  String isDeleted;
  String isDirty;
  String isActive1;
  String isDeleted1;
  String upSyncMessage;
  String downSyncMessage;
  String sCreatedOn;
  String sModifiedOn;
  String createdByUser;
  String modifiedByUser;
  int upSyncIndex;
  String ownerUserId;

  ContactTitle({
    required this.id,
   required this.contactTitleId,
     required this.contactTitleCode,
    required this.contactTitleName,
    required  this.createdOn,
    required  this.createdBy,
    required  this.modifiedOn,
    required  this.modifiedBy,
    required  this.isActive,
    required  this.uid,
    required  this.appUserId,
    required  this.appUserGroupId,
    required  this.isArchived,
    required  this.isDeleted,
    required  this.isDirty,
    required  this.isActive1,
    required  this.isDeleted1,
    required  this.upSyncMessage,
    required  this.downSyncMessage,
    required this.sCreatedOn,
    required   this.sModifiedOn,
    required   this.createdByUser,
    required  this.modifiedByUser,
    required  this.upSyncIndex,
    required  this.ownerUserId,
  });

  factory ContactTitle.fromJson(Map<String, dynamic> json) {
    return ContactTitle(
      id: json['Id'],
      contactTitleId: json['ContactTitleID'],
      contactTitleCode: json['ContactTitleCode'],
      contactTitleName: json['ContactTitleName'],
      createdOn: json['CreatedOn'],
      createdBy: json['CreatedBy'],
      modifiedOn: json['ModifiedOn'],
      modifiedBy: json['ModifiedBy'],
      isActive: json['IsActive'],
      uid: json['Uid'],
      appUserId: json['AppUserID'],
      appUserGroupId: json['AppUserGroupID'],
      isArchived: json['IsArchived'],
      isDeleted: json['IsDeleted'],
      isDirty: json['IsDirty'],
      isActive1: json['IsActive1'],
      isDeleted1: json['IsDeleted1'],
      upSyncMessage: json['UpSyncMessage'],
      downSyncMessage: json['DownSyncMessage'],
      sCreatedOn: json['SCreatedOn'],
      sModifiedOn: json['SModifiedOn'],
      createdByUser: json['CreatedByUser'],
      modifiedByUser: json['ModifiedByUser'],
      upSyncIndex: json['UpSyncIndex'],
      ownerUserId: json['OwnerUserID'],
    );
  }

  Map<String, dynamic> toJson() => {
  'Id': id,
  'ContactTitleID': contactTitleId,
  'ContactTitleCode': contactTitleCode,
  'ContactTitleName': contactTitleName,
  'CreatedOn': createdOn,
  'CreatedBy': createdBy,
  'ModifiedOn': modifiedOn,
  'ModifiedBy': modifiedBy,
  'IsActive': isActive,
  'Uid': uid,
  'AppUserID': appUserId,
  'AppUserGroupID': appUserGroupId,
  'IsArchived': isArchived,
  'IsDeleted': isDeleted,
  'IsDirty': isDirty,
  'IsActive1': isActive1,
  'IsDeleted1': isDeleted1,
  'UpSyncMessage': upSyncMessage,
  'DownSyncMessage': downSyncMessage,
  'SCreatedOn': sCreatedOn,
  'SModifiedOn': sModifiedOn,
  'CreatedByUser': createdByUser,
  'ModifiedByUser': modifiedByUser,
  'UpSyncIndex': upSyncIndex,
  'OwnerUserID': ownerUserId,
  };
}