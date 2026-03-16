import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/app_state_provider.dart';

class HabitTrackerScreen extends StatelessWidget {
  const HabitTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Daily Habits",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<AppStateProvider>(context, listen: false).resetHabits();
            },
          )
        ],
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, state, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.habits.length,
            itemBuilder: (context, index) {
              final habit = state.habits[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: habit.isCompleted ? Colors.green.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: habit.isCompleted ? Colors.green.shade200 : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: Image.asset(
                    habit.iconPath,
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.star, color: Colors.amber),
                  ),
                  title: Text(
                    habit.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: habit.isCompleted ? TextDecoration.lineThrough : null,
                      color: habit.isCompleted ? Colors.green.shade700 : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    habit.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: habit.isCompleted,
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onChanged: (val) {
                        state.toggleHabitCompletion(habit.id);
                      },
                    ),
                  ),
                  onTap: () {
                    state.toggleHabitCompletion(habit.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
