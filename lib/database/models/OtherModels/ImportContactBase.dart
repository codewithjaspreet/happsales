import 'dart:typed_data';


class ImportContactBase  {
  String? _phone;
  String? _name;
  Uint8List? _thumb;
  String? _email;
  String? _id;
  bool _checkedBox = false;

  String? get phone => _phone;
  set phone(String? value) {
    _phone = value;
  }

  String? get name => _name;
  set name(String? value) {
    _name = value;
  }

  Uint8List? get thumb => _thumb;
  set thumb(Uint8List? value) {
    _thumb = value;
  }

  String? get email => _email;
  set email(String? value) {
    _email = value;
  }

  String? get id => _id;
  set id(String? value) {
    _id = value;
  }

  bool get checkedBox => _checkedBox;
  set checkedBox(bool value) {
    _checkedBox = value;
  }

 
}
