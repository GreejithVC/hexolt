class Post {
  Post({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  static List<Post> fromListJson(final dynamic json) {
    if (json is List) {
      return json.map(Post.fromJson).toList().cast<Post>();
    }
    return [];
  }

  static Post fromJson(final dynamic json) {
    if (json is Map<String, dynamic>) {
      return Post(
        id: json['id'] as int?,
        userId: json['userId']?.toString(),
        title: json['title']?.toString(),
        body: json['body']?.toString(),
      );
    }
    return Post();
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
  int? id;
  String? userId;
  String? title;
  String? body;
}
