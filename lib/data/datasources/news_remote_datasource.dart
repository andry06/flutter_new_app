import 'package:fluttter_news_app/data/models/news_response_model.dart';
import 'package:http/http.dart' as http;

class NewsRemoteDatasource {
  Future<NewsResponseModel> getNews() async {
    String apiKey = '745fc8773151426695f3366ddf6a4483';

    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/everything?q=indonesia&from=2024-11-01&sortBy=publishedAt&apiKey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      return NewsResponseModel.fromJson(response.body);
    } else {
      throw Exception('error');
    }
  }

  Future<NewsResponseModel> search(String data) async {
    String apiKey = '745fc8773151426695f3366ddf6a4483';

    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/everything?q=$data&from=2024-11-01&sortBy=publishedAt&apiKey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      return NewsResponseModel.fromJson(response.body);
    } else {
      throw Exception('error');
    }
  }
}
