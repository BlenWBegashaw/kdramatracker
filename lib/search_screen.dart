import 'package:flutter/material.dart';
import '../models/kdrama.dart';
import '../services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<KDrama> _results = [];
  bool _isLoading = false;

  void _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final dramas = await apiService.searchKDrama(query);
      setState(() {
        _results = dramas;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching dramas: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showRatingDialog(KDrama drama) {
    double? rating;
    String? review;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(drama.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Your Rating (1-10)'),
              onChanged: (val) => rating = double.tryParse(val),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Your Review'),
              onChanged: (val) => review = val,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                drama.userRating = rating;
                drama.userReview = review;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search K-Dramas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter K-Drama name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final drama = _results[index];
                        return Card(
                          child: ListTile(
                            leading: drama.imageUrl.isNotEmpty
                                ? Image.network(drama.imageUrl, width: 50, fit: BoxFit.cover)
                                : const SizedBox(width: 50),
                            title: Text(drama.title),
                            subtitle: drama.userRating != null
                                ? Text('Your rating: ${drama.userRating} ⭐\n${drama.userReview ?? ""}')
                                : null,
                            onTap: () => _showRatingDialog(drama),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
