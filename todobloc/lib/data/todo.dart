// Represents a tasks or item in todo list.
class Todo {
  final String title;
  final String subtitle;
  bool isDone;

  Todo({this.title = '', this.subtitle = '', this.isDone = false});
//Create new Todo object based on existing one with some feilds updated. Returns new todo with specified feild updated.

  Todo copyWith({String? title, String? subtitle, bool? isDone}) {
    return Todo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone,
    );
  }

//Create todo object from JSON map.
  factory Todo.fromJson(Map<String, dynamic> json) {
    print('3 from the from json in data todo.dart');
    return Todo(
        title: json['title'],
        subtitle: json['subtitle'],
        isDone: json['isDone']);
  }
//convert Todo object to json map
  Map<String, dynamic> toJson() {
    print('6 from the to json in data todo.dart');
    return {'title': title, 'subtitle': subtitle, 'isDone': isDone};
  }
}
