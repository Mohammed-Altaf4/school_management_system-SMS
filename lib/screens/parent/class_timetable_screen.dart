import 'package:flutter/material.dart';
import '../../widgets/parent_drawer.dart';
class ParentTimetableScreen extends StatelessWidget {
  const ParentTimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myChild = {
      "name": "Rahul Sharma",
      "class": "10"
    };

    final timetable = [
      {
        "class": "10",
        "day": "Monday",
        "periods": [
          {"subject": "Math", "time": "9:00 - 10:00", "teacher": "Mr. Sharma"},
          {"subject": "Science", "time": "10:00 - 11:00", "teacher": "Mrs. Gupta"},
          {"subject": "Break", "time": "11:00 - 11:30", "teacher": ""},
          {"subject": "English", "time": "11:30 - 12:30", "teacher": "Ms. Rao"},
          {"subject": "Social", "time": "12:30 - 1:30", "teacher": "Mr. Khan"},
        ]
      }
    ];

    final todaySchedule = timetable[0]["periods"] as List;

    return Scaffold(
      drawer: const ParentDrawer(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Class Timetable",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// HEADER CARD
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.access_time,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myChild["name"] as String,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Class ${(timetable[0]["class"] as String)} - ${(timetable[0]["day"] as String)}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// SCHEDULE CARD
            _card(
              title: "Today's Schedule",
              child: Column(
                children: todaySchedule.map((period) {
                  final subject = period["subject"] as String;
                  final isBreak = subject == "Break";

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isBreak
                          ? Colors.grey.shade100
                          : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isBreak
                            ? Colors.grey.shade300
                            : const Color(0xFFBFDBFE),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                period["time"] as String,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        /// Teacher (only if not break)
                        if (!isBreak)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                period["teacher"] as String,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const Text(
                                "Teacher",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// REUSABLE CARD
  static Widget _card({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.access_time, size: 18),
                SizedBox(width: 6),
                Text("Today's Schedule",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            child
          ]),
    );
  }
}