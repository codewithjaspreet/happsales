import 'package:happsales_crm/database/models/BaseEntity.dart';

class LocationBase extends BaseEntity {
  String? _locationID;
  String? _locationName;
  String? _city;
  String? _district;
  String? _taluk;
  String? _state;
  String? _pinCode;
  String? _country;


  LocationBase();

  String? get locationID => _locationID;
  set locationID(String? value) {
    _locationID = value;
  }

  String? get locationName => _locationName;
  set locationName(String? value) {
    _locationName = value;
  }

  String? get city => _city;
  set city(String? value) {
    _city = value;
  }

  String? get district => _district;
  set district(String? value) {
    _district = value;
  }

  String? get taluk => _taluk;
  set taluk(String? value) {
    _taluk = value;
  }

  String? get state => _state;
  set state(String? value) {
    _state = value;
  }

  String? get pinCode => _pinCode;
  set pinCode(String? value) {
    _pinCode = value;
  }

  String? get country => _country;
  set country(String? value) {
    _country = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'LocationID': _locationID,
      'LocationName': _locationName,
      'City': _city,
      'District': _district,
      'Taluk': _taluk,
      'State': _state,
      'PINCode': _pinCode,
      'Country': _country,
    };
  }

  LocationBase.fromMapObject(Map<String, dynamic> map) {
    _locationID = map['LocationID'];
    _locationName = map['LocationName'];
    _city = map['City'];
    _district = map['District'];
    _taluk = map['Taluk'];
    _state = map['State'];
    _pinCode = map['PINCode'];
    _country = map['Country'];

  }
}
