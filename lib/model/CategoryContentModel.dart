class CategoryContentModel {
  List<CategoryContentItemModel>? data;

  CategoryContentModel({this.data});

  CategoryContentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryContentItemModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryContentItemModel.fromJson(v));
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

class CategoryContentItemModel {
  int? id;
  String? title;
  String? content;
  int? pid;

  CategoryContentItemModel({this.id, this.title, this.content, this.pid});

  CategoryContentItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    pid = json['pid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['pid'] = this.pid;
    return data;
  }
}
