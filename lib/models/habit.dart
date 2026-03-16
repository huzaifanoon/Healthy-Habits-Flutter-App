class Habit {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  bool isCompleted;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    this.isCompleted = false,
  });
}
