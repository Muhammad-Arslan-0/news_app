import 'package:news_app/api/api_request.dart';
import 'package:news_app/helper/app_constant.dart';
import 'package:news_app/model/categories_model.dart';
import 'package:news_app/model/search_news_model.dart';
import '../model/latest_news_model.dart';

class ApiCalls {
  static Future<LatestNewsModel?> getLatestNews() async {
    var jsonData = await ApiRequest.get(url: "latest-news", headers: {
      "Accept": "application/json",
      "Authorization": AppConstant.apiKey
    });
    if (jsonData != null) {
      LatestNewsModel latestModel = LatestNewsModel.fromJson(jsonData);
      return latestModel;
    } else {
      return null;
    }
  }

  static Future<CategoriesModel?> getNewsCategories() async {
    var jsonData = await ApiRequest.get(url: "available/categories", headers: {
      "Accept": "application/json",
      "Authorization": AppConstant.apiKey
    });
    if (jsonData != null) {
      CategoriesModel categoriesModel = CategoriesModel.fromJson(jsonData);
      return categoriesModel;
    } else {
      return null;
    }
  }

  static Future<SearchNewsModel?> searchNewsByCountry(String country) async {
    var jsonData = await ApiRequest.get(
        url: "search?country=$country",
        headers: {
          "Accept": "application/json",
          "Authorization": AppConstant.apiKey
        });
    if (jsonData != null) {
      SearchNewsModel searchNewsModel = SearchNewsModel.fromJson(jsonData);
      return searchNewsModel;
    } else {
      return null;
    }
  }

  static Future<SearchNewsModel?> searchNewsByCategory(String category) async {
    var jsonData = await ApiRequest.get(
        url: "search?category=$category",
        headers: {
          "Accept": "application/json",
          "Authorization": AppConstant.apiKey
        });
    if (jsonData != null) {
      SearchNewsModel searchNewsModel = SearchNewsModel.fromJson(jsonData);
      return searchNewsModel;
    } else {
      return null;
    }
  }

  static Future<SearchNewsModel?> searchNewsByKeyword(String keyword) async {
    var jsonData = await ApiRequest.get(
        url: "search?keyword=$keyword",
        headers: {
          "Accept": "application/json",
          "Authorization": AppConstant.apiKey
        });
    if (jsonData != null) {
      SearchNewsModel searchNewsModel = SearchNewsModel.fromJson(jsonData);
      return searchNewsModel;
    } else {
      return null;
    }
  }
}
