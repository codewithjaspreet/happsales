class BaseEntity {
  static final String KEY_ID = 'Id';
  static final String KEY_ISDIRTY = 'IsDirty';
  static final String KEY_ISDELETED = 'IsDeleted1';
  static final String KEY_UPSYNCMESSAGE = 'UpSyncMessage';
  static final String KEY_DOWNSYNCMESSAGE = 'DownSyncMessage';
  static final String KEY_SCREATEDON = 'SCreatedOn';
  static final String KEY_SMODIFIEDON = 'SModifiedOn';
  static final String KEY_CREATEDBYUSER = 'CreatedByUser';
  static final String KEY_MODIFIEDBYUSER = 'ModifiedByUser';
  static final String KEY_UPSYNCINDEX = 'UpSyncIndex';
  static final String KEY_OWNERUSERID = 'OwnerUserID';

  String? _id;
  bool? _isDirty;
  bool? _isDeleted1;
  String? _upSyncMessage;
  String? _downSyncMessage;
  DateTime? _sCreatedOn;
  DateTime? _sModifiedOn;
  String? _createdByUser;
  String? _modifiedByUser;
  int? _upSyncIndex;
  String? _ownerUserID;

  BaseEntity();

  String? get id => _id;
  set id(String? value) => _id = value;

  bool? get isDirty => _isDirty;
  set isDirty(bool? value) => _isDirty = value;

  bool? get isDeleted1 => _isDeleted1;
  set isDeleted1(bool? value) => _isDeleted1 = value;

  String? get upSyncMessage => _upSyncMessage;
  set upSyncMessage(String? value) => _upSyncMessage = value;

  String? get downSyncMessage => _downSyncMessage;
  set downSyncMessage(String? value) => _downSyncMessage = value;

  DateTime? get sCreatedOn => _sCreatedOn;
  set sCreatedOn(DateTime? value) => _sCreatedOn = value;

  DateTime? get sModifiedOn => _sModifiedOn;
  set sModifiedOn(DateTime? value) => _sModifiedOn = value;

  String? get createdByUser => _createdByUser;
  set createdByUser(String? value) => _createdByUser = value;

  String? get modifiedByUser => _modifiedByUser;
  set modifiedByUser(String? value) => _modifiedByUser = value;

  int? get upSyncIndex => _upSyncIndex;
  set upSyncIndex(int? value) => _upSyncIndex = value;

  String? get ownerUserID => _ownerUserID;
  set ownerUserID(String? value) => _ownerUserID = value;
}


 