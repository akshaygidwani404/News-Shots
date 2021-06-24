import 'dart:convert';

import 'package:news_shots/models/blog_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<BlogModel> news = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&apiKey=4754d2d97b66435593268626777adb2a";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element["description"] != null) {
          var dateOfPublish1 = element["publishedAt"].substring(0, 10);
          BlogModel blogModel = BlogModel(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
              dateOfPublish: dateOfPublish1);

          news.add(blogModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<BlogModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=4754d2d97b66435593268626777adb2a";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element["description"] != null) {
          var dateOfPublish1 = element["publishedAt"].substring(0, 10);
          BlogModel blogModel = BlogModel(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
              dateOfPublish: dateOfPublish1);

          news.add(blogModel);
        }
      });
    }
  }
}
