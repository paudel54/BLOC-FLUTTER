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
    return Todo(
        title: json['title'],
        subtitle: json['subtitle'],
        isDone: json['isDone']);
  }
//convert Todo object to json map
  Map<String, dynamic> toJson() {
    return {'title': title, 'subtitle': subtitle, 'isDone': isDone};
  }

//overides the 'toString' method to provide a custom string representation of a 'Todo' object. It returns a formatted string
//including 'title', 'subtitle' and 'isDone' properties.
  @override
  String toString() {
    return '''Todo: {
			title: $title\n
			subtitle: $subtitle\n
			isDone: $isDone\n
		}''';
  }
}
