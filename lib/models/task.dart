class Task {
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
  });

  get isCompleted => null;
}
