class Student {
  final String title;
  final String subtitle;
  Student({required this.title, required this.subtitle});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(title: json['title'], subtitle: json['subtitle']);
  }
}
