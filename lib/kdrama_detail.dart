import 'package:flutter/material.dart';
import 'models/kdrama.dart';

class KDramaDetailScreen extends StatelessWidget {
  final KDrama drama;
  const KDramaDetailScreen({super.key, required this.drama});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(drama.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(drama.imageUrl),
            const SizedBox(height: 16),
            Text(drama.description),
            const SizedBox(height: 16),
            if (drama.userRating != null)
              Text('Your rating: ${drama.userRating} ⭐'),
            if (drama.userReview != null)
              Text('Your review: ${drama.userReview}'),
          ],
        ),
      ),
    );
  }
}
