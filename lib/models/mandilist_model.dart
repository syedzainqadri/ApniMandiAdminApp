class MandiListModel {
  String? id;
  String? mandiName;
  String? provinceId;
  String? districtId;
  String? cityId;

  MandiListModel(
      {this.id, this.mandiName, this.provinceId, this.districtId, this.cityId});

  factory MandiListModel.fromJson(Map<String, dynamic> data) {
    return MandiListModel(
      id: data['id'],
      mandiName: data['mandiName'],
      provinceId: data['provinceId'],
      districtId: data['districtId'],
      cityId: data['cityId'],
    );
  }
}
