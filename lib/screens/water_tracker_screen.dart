import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../providers/app_state_provider.dart';

class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Water Tracker",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, state, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_drink_rounded,
                  size: 60,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                Text(
                  "Stay Hydrated!",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 15.0,
                  animation: true,
                  percent: state.waterProgress,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${state.waterIntakeMl}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        "/ ${state.waterGoalMl} ml",
                        style: GoogleFonts.inter(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.blue,
                  backgroundColor: Colors.blue.withOpacity(0.1),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAddWaterButton(context, state, 100),
                    const SizedBox(width: 20),
                    _buildAddWaterButton(context, state, 250),
                    const SizedBox(width: 20),
                    _buildAddWaterButton(context, state, 500),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton.icon(
                  onPressed: () => state.resetWater(),
                  icon: const Icon(Icons.refresh, color: Colors.grey),
                  label: Text(
                    "Reset Tracking",
                    style: GoogleFonts.inter(color: Colors.grey),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddWaterButton(BuildContext context, AppStateProvider state, int amount) {
    return InkWell(
      onTap: () {
        state.addWater(amount);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added $amount ml of water!'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.shade100, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.blue, size: 20),
            Text(
              "$amount",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            Text(
              "ml",
              style: GoogleFonts.inter(fontSize: 10, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
