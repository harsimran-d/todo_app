class Todo {
  final int id;
  final String title;
  final bool status;

  Todo({required this.id, required this.title, required this.status});

  Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"] as int,
      title: json["title"] as String,
      status: json["status"] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "status": status,
    };
  }
}
