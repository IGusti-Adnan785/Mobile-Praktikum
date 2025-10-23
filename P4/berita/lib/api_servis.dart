import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_model.dart';

class ApiServis {
  static const _apiKey = 'b0179514ffba4c5080b108a44970d045';
  static const _baseName =
      'https://newsapi.org/v2/everything?q=tesla&from=2025-09-23&sortBy=publishedAt&apiKey=$_apiKey';

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_baseName));
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> articlesJson = json['articles'];
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Articles');
      }
    } catch (e) {
      throw Exception('failed to connect to server: $e');
    }
  }
}
