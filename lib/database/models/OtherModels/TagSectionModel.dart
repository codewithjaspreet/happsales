import 'TagModel.dart';

class TagSectionModel {
  String sectionLabel;
  List<TagModel> itemArrayList;

  TagSectionModel(this.sectionLabel, this.itemArrayList);

  String getSectionLabel() {
    return sectionLabel;
  }

  List<TagModel> getItemArrayList() {
    return itemArrayList;
  }
}
