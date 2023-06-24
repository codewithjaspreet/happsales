import 'package:happsales_crm/database/models/BaseEntity.dart';

class SyncCalender  {
  String? _eventName;
  String? _description;
  String? _location;
  int? _startDateTime;
  int? _endDateTime;
  bool? _checkedBox;

  String? get eventName => _eventName;
  set eventName(String? value) => _eventName = value;

  String? get description => _description;
  set description(String? value) => _description = value;

  String? get location => _location;
  set location(String? value) => _location = value;

  int? get startDateTime => _startDateTime;
  set startDateTime(int? value) => _startDateTime = value;

  int? get endDateTime => _endDateTime;
  set endDateTime(int? value) => _endDateTime = value;

  bool? get checkedBox => _checkedBox;
  set checkedBox(bool? value) => _checkedBox = value;
}