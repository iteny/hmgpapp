class SelfSelectModel {
  List<SelfSelectItemModel>? data;

  SelfSelectModel({this.data});

  SelfSelectModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SelfSelectItemModel>[];
      json['data'].forEach((v) {
        data!.add(new SelfSelectItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelfSelectItemModel {
  int? id;
  String? name;
  String? code;
  String? sector;
  int? type;

  SelfSelectItemModel({this.id, this.name, this.code, this.sector, this.type});

  SelfSelectItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    sector = json['sector'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['sector'] = this.sector;
    data['type'] = this.type;
    return data;
  }
}
