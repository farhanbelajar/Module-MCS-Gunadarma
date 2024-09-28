class Result {
  final String id;

  Result({
    required this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'] as String,
    );
  }
}
