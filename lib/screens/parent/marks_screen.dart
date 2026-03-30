import 'package:flutter/material.dart';
import '../../widgets/parent_drawer.dart';

class ParentMarksScreen extends StatelessWidget {
  const ParentMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myChild = {
      "name": "Rahul Sharma",
      "class": "10"
    };

    final childMarks = [
      {"subject": "Math", "marksObtained": 85, "totalMarks": 100},
      {"subject": "Science", "marksObtained": 90, "totalMarks": 100},
      {"subject": "English", "marksObtained": 78, "totalMarks": 100},
      {"subject": "Social", "marksObtained": 88, "totalMarks": 100},
    ];

    double overallPercentage = _calculateOverall(childMarks);

    return Scaffold(
      drawer: const ParentDrawer(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Exam Results & Marks",
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
                    child: const Icon(Icons.emoji_events,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myChild["name"]!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Class ${myChild["class"]} - Mid-Term Results",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Overall %",
                          style: TextStyle(color: Colors.white70)),
                      Text(
                        "${overallPercentage.toStringAsFixed(1)}%",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// TOP STATS
            Row(
              children: [
                _statCard(
                    icon: Icons.trending_up,
                    title: "Overall Grade",
                    value: "A",
                    color: Colors.blue),

                const SizedBox(width: 10),

                _statCard(
                    icon: Icons.emoji_events,
                    title: "Class Rank",
                    value: "3rd",
                    color: Colors.green),

                const SizedBox(width: 10),

                _statCard(
                    icon: Icons.menu_book,
                    title: "Subjects",
                    value: "${childMarks.length}",
                    color: Colors.purple),
              ],
            ),

            const SizedBox(height: 20),

            /// SUBJECT PERFORMANCE
            _card(
              title: "Subject-wise Performance",
              child: Column(
                children: childMarks.map((mark) {
                  double percentage =
                      ((mark["marksObtained"] as int) /
                          (mark["totalMarks"] as int)) *
                          100;

                  String grade;
                  if (percentage >= 90) {
                    grade = "A+";
                  } else if (percentage >= 75) {
                    grade = "A";
                  } else if (percentage >= 60) {
                    grade = "B";
                  } else {
                    grade = "C";
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Color(0xFFEFF6FF)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// TOP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mark["subject"] as String,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: percentage >= 75
                                    ? Colors.green
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${percentage.toStringAsFixed(1)}%",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 10),

                        _row("Marks Obtained", "${mark["marksObtained"]}"),
                        _row("Total Marks", "${mark["totalMarks"]}"),
                        _row("Grade", grade),

                        const SizedBox(height: 10),

                        /// PROGRESS BAR
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: percentage / 100,
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              percentage >= 75
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
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

  /// FIXED FUNCTION
  static double _calculateOverall(List<Map<String, dynamic>> marks) {
    double total = 0;
    double obtained = 0;

    for (var m in marks) {
      total += (m["totalMarks"] as int);
      obtained += (m["marksObtained"] as int);
    }

    return (obtained / total) * 100;
  }

  static Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  static Widget _card({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child
        ],
      ),
    );
  }

  static Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 5),
            Text(title,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ],
        ),
      ),
    );
  }
}