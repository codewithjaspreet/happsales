import '../../Models/BaseEntity.dart';

class CreditRatingBase extends BaseEntity {
  String? _creditRatingID;
  String? _creditRatingCode;
  String? _creditRatingName;
  String? _creditRatingDescription;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

CreditRatingBase();
  String? get creditRatingID => _creditRatingID;
  set creditRatingID(String? value) {
    _creditRatingID = value;
  }

  String? get creditRatingCode => _creditRatingCode;
  set creditRatingCode(String? value) {
    _creditRatingCode = value;
  }

  String? get creditRatingName => _creditRatingName;
  set creditRatingName(String? value) {
    _creditRatingName = value;
  }

  String? get creditRatingDescription => _creditRatingDescription;
  set creditRatingDescription(String? value) {
    _creditRatingDescription = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
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

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
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
      'CreditRatingID': creditRatingID,
      'CreditRatingCode': creditRatingCode,
      'CreditRatingName': creditRatingName,
      'CreditRatingDescription': creditRatingDescription,
      'CreatedOn': createdOn,
      'CreatedBy': createdBy,
      'ModifiedOn': modifiedOn,
      'ModifiedBy': modifiedBy,
      'IsActive': isActive,
      'Uid': uid,
      'AppUserID': appUserID,
      'AppUserGroupID': appUserGroupID,
      'IsArchived': isArchived,
      'IsDeleted': isDeleted,
      'AppUserName': appUserName,
      'AppUserGroupName': appUserGroupName,
    };
  }

   CreditRatingBase.fromMap(Map<String, dynamic> map) {
    _creditRatingID = map['CreditRatingID'];
    _creditRatingCode = map['CreditRatingCode'];
    _creditRatingName = map['CreditRatingName'];
    _creditRatingDescription = map['CreditRatingDescription'];
    _createdOn = map['CreatedOn'];
    _createdBy = map['CreatedBy'];
    _modifiedOn = map['ModifiedOn'];
    _modifiedBy = map['ModifiedBy'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];
  }
}
