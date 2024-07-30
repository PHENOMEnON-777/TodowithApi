import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiTodo {
  late final String id;
  final String title;
  final String subtitle;
   bool isCompleted;
  ApiTodo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });

  ApiTodo copyWith({
    String? id,
    String? title,
    String? subtitle,
    bool? isCompleted,
  }) {
    return ApiTodo(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isCompleted': isCompleted,
    };
  }

  factory ApiTodo.fromMap(Map<String, dynamic> map) {
    return ApiTodo(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiTodo.fromJson(String source) => ApiTodo.fromMap(json.decode(source) as Map<String, dynamic>);
}
