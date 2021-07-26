class User {
  int id;
  String title;
  String body;

  User({this.id, this.title, this.body});

  factory User.fromJson(json) {
    return User(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
