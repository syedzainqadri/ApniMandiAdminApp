

class DistrictModel {

  String? id;
  String? districtName;
  String? provinceId;


  DistrictModel({this.id, this.districtName, this.provinceId});

  factory DistrictModel.fromJson(Map<String, dynamic> data) {
    return DistrictModel(
      id: data['id'],
      districtName: data['districtName'],
      provinceId: data['provinceId'],
    );
  }

}