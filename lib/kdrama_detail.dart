import 'package:flutter/material.dart';
import '../models/kdrama.dart';

class KDramaDetailScreen extends StatefulWidget {
  final KDrama drama;

  const KDramaDetailScreen({super.key, required this.drama});

  @override
  State<KDramaDetailScreen> createState() => _KDramaDetailScreenState();
}

class _KDramaDetailScreenState extends State<KDramaDetailScreen> {
  double _userRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  void _saveReview() {
    if (_userRating == 0 || _reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a rating and review')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review saved')),
    );

    _reviewController.clear();
    setState(() => _userRating = 0);
  }

  @override
  Widget build(BuildContext context) {
    final drama = widget.drama;

    return Scaffold(
      appBar: AppBar(
        title: Text(drama.title),
      ),
      body: SingleChildScrollView(   // ✅ FIX
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (drama.imageUrl.isNotEmpty)
              Center(
                child: Image.network(
                  drama.imageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 16),

            Text(
              drama.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              drama.description.isNotEmpty
                  ? drama.description
                  : 'No description available.',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            const Text(
              'Your Rating',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            Slider(
              value: _userRating,
              min: 0,
              max: 10,
              divisions: 10,
              label: _userRating.toString(),
              onChanged: (value) {
                setState(() => _userRating = value);
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _reviewController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Write your review',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveReview,
                child: const Text('Save Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
