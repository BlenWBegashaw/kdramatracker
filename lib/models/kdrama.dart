class KDrama {
  final String title;
  final String description;
  final String imageUrl;
  final double rating;

  double? userRating;
  String? userReview;

  KDrama({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    this.userRating,
    this.userReview,
  });

  factory KDrama.fromJson(Map<String, dynamic> json) {
    return KDrama(
      title: json['name'] ?? '',
      description: json['overview'] ?? 'No description available.',
      rating: (json['vote_average'] ?? 0).toDouble(),
      imageUrl: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '',
    );
  }
}
