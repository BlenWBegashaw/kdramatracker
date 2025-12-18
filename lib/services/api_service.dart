import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kdrama.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<KDrama>> searchKDrama(String query) async {
    final url = Uri.parse(
        '$baseUrl/search/tv?api_key=$apiKey&language=en-US&query=$query&page=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => KDrama.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load K-Dramas');
    }
  }
}
