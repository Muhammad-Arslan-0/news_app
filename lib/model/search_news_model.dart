class SearchNewsModel {
  SearchNewsModel({
      this.status, 
      this.news, 
      this.page,});

  SearchNewsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['news'] != null) {
      news = [];
      json['news'].forEach((v) {
        news?.add(SearchNews.fromJson(v));
      });
    }
    page = json['page'];
  }
  String? status;
  List<SearchNews>? news;
  num? page;
SearchNewsModel copyWith({  String? status,
  List<SearchNews>? news,
  num? page,
}) => SearchNewsModel(  status: status ?? this.status,
  news: news ?? this.news,
  page: page ?? this.page,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (news != null) {
      map['news'] = news?.map((v) => v.toJson()).toList();
    }
    map['page'] = page;
    return map;
  }

}

class SearchNews {
  SearchNews({
      this.id, 
      this.title, 
      this.description, 
      this.url, 
      this.author, 
      this.image, 
      this.language, 
      this.category, 
      this.published,});

  SearchNews.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    author = json['author'];
    image = json['image'];
    language = json['language'];
    category = json['category'] != null ? json['category'].cast<String>() : [];
    published = json['published'];
  }
  String? id;
  String? title;
  String? description;
  String? url;
  String? author;
  String? image;
  String? language;
  List<String>? category;
  String? published;
SearchNews copyWith({  String? id,
  String? title,
  String? description,
  String? url,
  String? author,
  String? image,
  String? language,
  List<String>? category,
  String? published,
}) => SearchNews(  id: id ?? this.id,
  title: title ?? this.title,
  description: description ?? this.description,
  url: url ?? this.url,
  author: author ?? this.author,
  image: image ?? this.image,
  language: language ?? this.language,
  category: category ?? this.category,
  published: published ?? this.published,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['author'] = author;
    map['image'] = image;
    map['language'] = language;
    map['category'] = category;
    map['published'] = published;
    return map;
  }

}