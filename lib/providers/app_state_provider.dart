import 'package:flutter/material.dart';
import '../models/habit.dart';

class AppStateProvider extends ChangeNotifier {
  // Water Tracking State
  int _waterIntakeMl = 0;
  final int _waterGoalMl = 2500; // 2.5L daily goal

  int get waterIntakeMl => _waterIntakeMl;
  int get waterGoalMl => _waterGoalMl;
  double get waterProgress => (_waterIntakeMl / _waterGoalMl).clamp(0.0, 1.0);

  void addWater(int amountMl) {
    _waterIntakeMl += amountMl;
    notifyListeners();
  }

  void resetWater() {
    _waterIntakeMl = 0;
    notifyListeners();
  }

  // Habits Tracking State
  final List<Habit> _habits = [
    Habit(
      id: "h1",
      title: "Drink Water",
      description: "Drink at least 8 glasses of water every day to stay hydrated.",
      iconPath: "assets/water.png",
    ),
    Habit(
      id: "h2",
      title: "Exercise",
      description: "Exercise for 30 minutes daily to keep your body active.",
      iconPath: "assets/exercise.png",
    ),
    Habit(
      id: "h3",
      title: "Reading",
      description: "Read books daily to improve your knowledge and focus.",
      iconPath: "assets/reading.png",
    ),
    Habit(
      id: "h4",
      title: "Sleep",
      description: "Sleep 7 to 8 hours every night for a healthy lifestyle.",
      iconPath: "assets/sleep.png",
    ),
  ];

  List<Habit> get habits => _habits;
  
  double get habitsProgress {
    if (_habits.isEmpty) return 0.0;
    int completedCount = _habits.where((h) => h.isCompleted).length;
    return completedCount / _habits.length;
  }

  void toggleHabitCompletion(String id) {
    final index = _habits.indexWhere((h) => h.id == id);
    if (index != -1) {
      _habits[index].isCompleted = !_habits[index].isCompleted;
      notifyListeners();
    }
  }

  void resetHabits() {
    for (var habit in _habits) {
      habit.isCompleted = false;
    }
    notifyListeners();
  }
}
