class CategoriesModel {
  CategoriesModel({
    this.categories,
    this.description,
    this.status,
  });

  CategoriesModel.fromJson(dynamic json) {
    categories =
        json['categories'] != null ? json['categories'].cast<String>() : [];
    description = json['description'];
    status = json['status'];
  }
  List<String>? categories;
  String? description;
  String? status;
  CategoriesModel copyWith({
    List<String>? categories,
    String? description,
    String? status,
  }) =>
      CategoriesModel(
        categories: categories ?? this.categories,
        description: description ?? this.description,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categories'] = categories;
    map['description'] = description;
    map['status'] = status;
    return map;
  }
}
