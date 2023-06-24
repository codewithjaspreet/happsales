class SectionModel {
  final String sectionLabel;
  final List<String> itemArrayList;

  SectionModel(this.sectionLabel, this.itemArrayList);

  String getSectionLabel() {
    return sectionLabel;
  }

  List<String> getItemArrayList() {
    return itemArrayList;
  }
}
