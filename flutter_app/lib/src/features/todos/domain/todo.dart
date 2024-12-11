class Todo {
  final int id;
  final String title;
  final bool status;

  Todo({required this.id, required this.title, required this.status});

  factory Todo.fromJson(Map<String, dynamic> json) {
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

  Todo copyWith({
    int? id,
    String? title,
    bool? status,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }
}
