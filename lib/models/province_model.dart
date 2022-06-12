

class ProvinceModel {

  String? id;
  String? provinceName;


  ProvinceModel({this.id, this.provinceName});

  factory ProvinceModel.fromJson(Map<String, dynamic> data) {
    return ProvinceModel(
      id: data['id'],
      provinceName: data['provinceName'],
    );
  }

}