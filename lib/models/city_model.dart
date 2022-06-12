

class CityModel {

  String? id;
  String? cityName;
  String? provinceId;
  String? districtId;


  CityModel({this.id, this.cityName, this.provinceId, this.districtId});

  factory CityModel.fromJson(Map<String, dynamic> data) {
    return CityModel(
      id: data['id'],
      cityName: data['cityName'],
      provinceId: data['provinceId'],
      districtId: data['districtId'],
    );
  }

}