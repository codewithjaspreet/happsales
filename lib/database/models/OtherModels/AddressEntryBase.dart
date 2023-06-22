import 'package:happsales_crm/database/models/BaseEntity.dart';

class AddressEntry  extends BaseEntity{
  String? _id;
  String? _timeId;
  String? _address;
  String? _userLocationAddress;
  String? _userLocationDate;
  double? _latitude;
  double? _longitude;

  String? get id => _id;
  set id(String? value) => _id = value;

  String? get timeId => _timeId;
  set timeId(String? value) => _timeId = value;

  String? get address => _address;
  set address(String? value) => _address = value;

  String? get userLocationAddress => _userLocationAddress;
  set userLocationAddress(String? value) => _userLocationAddress = value;

  String? get userLocationDate => _userLocationDate;
  set userLocationDate(String? value) => _userLocationDate = value;

  double? get latitude => _latitude;
  set latitude(double? value) => _latitude = value;

  double? get longitude => _longitude;
  set longitude(double? value) => _longitude = value;
}
