class TagModel {
  String? _groupName;
  String? _tagId;
  String? _tagText;
  bool? _isFromList;
  int? _backGroundColor;
  int? _foreGroundColor;

 

  TagModel(this._groupName, this._tagId, this._tagText, this._isFromList);

  String? get groupName {
    return _groupName;
  }

  set groupName(String? groupName) {
    _groupName = groupName;
  }

  String? get tagId {
    return _tagId;
  }

  set tagId(String? tagId) {
    _tagId = tagId;
  }

  String? get tagText {
    return _tagText;
  }

  set tagText(String? tagText) {
    _tagText = tagText;
  }

  bool? get isFromList {
    return _isFromList;
  }

  set isFromList(bool? isFromList) {
    _isFromList = isFromList;
  }

  int? get backGroundColor {
    return _backGroundColor;
  }

  set backGroundColor(int? backGroundColor) {
    _backGroundColor = backGroundColor;
  }

  int? get foreGroundColor {
    return _foreGroundColor;
  }

  set foreGroundColor(int? foreGroundColor) {
    _foreGroundColor = foreGroundColor;
  }
}
