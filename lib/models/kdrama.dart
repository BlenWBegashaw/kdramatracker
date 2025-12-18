class KDrama {
  final String title;
  final String description;
  final String imageUrl;

  double? userRating;
  String? userReview;

  KDrama({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.userRating,
    this.userReview,
  });

  factory KDrama.fromJson(Map<String, dynamic> json) {
    return KDrama(
      title: json['name'] ?? '',
      description: json['overview'] ?? '',
      imageUrl: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '',
    );
  }
}
