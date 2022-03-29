class CategoryModel {
  List<CategoryItemModel>? data;

  CategoryModel({this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryItemModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryItemModel.fromJson(v));
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

class CategoryItemModel {
  int? id;
  Object? url;
  Object? name;
  int? status;
  int? sort;
  Object? icon;

  CategoryItemModel(
      {this.id, this.url, this.name, this.status, this.sort, this.icon});

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    status = json['status'];
    sort = json['sort'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['status'] = this.status;
    data['sort'] = this.sort;
    data['icon'] = this.icon;
    return data;
  }
}
