import 'package:flutter/material.dart';
import '../../widgets/parent_drawer.dart';
const Color primaryBlue = Color(0xFF2563EB);

class ParentHomeworkScreen extends StatelessWidget {
  const ParentHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> homework = [
      {
        "title": "Math Assignment",
        "description": "Complete algebra problems",
        "subject": "Mathematics",
        "assignedDate": "Mar 20",
        "dueDate": "Mar 25",
        "teacher": "Mr. John"
      },
      {
        "title": "Science Project",
        "description": "Prepare solar system model",
        "subject": "Science",
        "assignedDate": "Mar 18",
        "dueDate": "Mar 28",
        "teacher": "Mrs. Smith"
      },
    ];

    final pendingCount = homework.length;
    final completedCount = 42;

    return Scaffold(
      drawer: const ParentDrawer(),
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Home Work & Assignment",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔵 HEADER CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.book, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Student Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text("Class 10",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 📊 STATS CARDS
            Row(
              children: [
                Expanded(
                  child: _statCard(
                      icon: Icons.warning,
                      color: Colors.orange,
                      title: "Pending",
                      value: pendingCount.toString()),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                      icon: Icons.bookmark,
                      color: Colors.green,
                      title: "Completed",
                      value: completedCount.toString()),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                      icon: Icons.access_time,
                      color: Colors.purple,
                      title: "Due",
                      value: "3"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 📌 PENDING HOMEWORK
            _sectionTitle("Pending Homework & Assignments"),

            const SizedBox(height: 10),

            Column(
              children: homework.map((hw) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.orange.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// TITLE + SUBJECT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              hw["title"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),

                          _badge(hw["subject"], Colors.grey),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Text(hw["description"],
                          style: const TextStyle(color: Colors.grey)),

                      const SizedBox(height: 10),

                      /// DATES
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _info("Assigned", hw["assignedDate"]),
                          _info("Due", hw["dueDate"], isDue: true),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// FOOTER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _outlineBadge("Pending Submission"),
                          Text("By: ${hw["teacher"]}",
                              style: const TextStyle(fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// ✅ COMPLETED
            _sectionTitle("Recently Completed"),

            const SizedBox(height: 10),

            Column(
              children: [
                _completedItem(
                    "Science Lab Report", "Mar 10", "A", "Science"),
                _completedItem(
                    "History Essay", "Mar 8", "A+", "History"),
                _completedItem(
                    "Geometry Problems", "Mar 5", "B+", "Math"),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 🔹 STAT CARD
  Widget _statCard(
      {required IconData icon,
        required Color color,
        required String title,
        required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 5),
          Text(title),
          Text(value,
              style:
              const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// 🔹 SECTION TITLE
  Widget _sectionTitle(String text) {
    return Text(text,
        style:
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  /// 🔹 BADGE
  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }

  /// 🔹 OUTLINE BADGE
  Widget _outlineBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text("Pending Submission",
          style: TextStyle(fontSize: 12, color: Colors.orange)),
    );
  }

  /// 🔹 INFO TEXT
  Widget _info(String label, String value, {bool isDue = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDue ? Colors.orange : Colors.black),
        ),
      ],
    );
  }

  /// 🔹 COMPLETED ITEM
  Widget _completedItem(
      String title, String date, String grade, String subject) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.green.shade50],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("Submitted: $date",
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),

          Column(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(grade,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12)),
              ),
              Text(subject, style: const TextStyle(fontSize: 11))
            ],
          )
        ],
      ),
    );
  }
}