import 'package:flutter/material.dart';
import '../../widgets/teacher_drawer.dart';

class TeacherHomeworkScreen extends StatefulWidget {
  const TeacherHomeworkScreen({super.key});

  @override
  State<TeacherHomeworkScreen> createState() =>
      _TeacherHomeworkScreenState();
}

class _TeacherHomeworkScreenState extends State<TeacherHomeworkScreen> {

  final List<Map<String, String>> homework = [
    {
      "title": "Quadratic Equations",
      "class": "10-A",
      "description": "Solve exercise 5.2 from textbook",
      "subject": "Mathematics",
      "assignedDate": "2026-02-10",
      "dueDate": "2026-02-20"
    },
    {
      "title": "Grammar Practice",
      "class": "9-A",
      "description": "Complete page 45 and 46",
      "subject": "English",
      "assignedDate": "2026-02-12",
      "dueDate": "2026-02-18"
    }
  ];

  void _showAssignDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Assign New Homework"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "Class"),
                  items: const [
                    DropdownMenuItem(value: "10-A", child: Text("Class 10-A")),
                    DropdownMenuItem(value: "10-B", child: Text("Class 10-B")),
                    DropdownMenuItem(value: "9-A", child: Text("Class 9-A")),
                  ],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(labelText: "Subject"),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 10),
                const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(labelText: "Due Date"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Homework assigned successfully!")),
                );
              },
              child: const Text("Assign Homework"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const TeacherDrawer(),
      backgroundColor: const Color(0xFFE6EEF8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Homework Management",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Assign Homework Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _showAssignDialog,
                icon: const Icon(Icons.add),
                label: const Text("Assign Homework"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Stats Cards
            Row(
              children: [
                Expanded(child: _statCard("Total Assigned", "12", Colors.blue, Icons.book)),
                const SizedBox(width: 10),
                Expanded(child: _statCard("Pending Review", "45", Colors.orange, Icons.calendar_today)),
                const SizedBox(width: 10),
                Expanded(child: _statCard("Completed", "120", Colors.green, Icons.check_circle)),
              ],
            ),

            const SizedBox(height: 16),

            /// Homework List
            Column(
              children: homework.map((hw) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                hw["title"]!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(hw["class"]!),
                            )
                          ],
                        ),

                        const SizedBox(height: 6),
                        Text(hw["description"]!,
                            style: const TextStyle(color: Colors.grey)),

                        const SizedBox(height: 10),

                        Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          children: [
                            _infoTile("Subject", hw["subject"]!),
                            _infoTile("Assigned", hw["assignedDate"]!),
                            _infoTile("Due Date", hw["dueDate"]!),
                            _infoTile("Submissions", "24/30"),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text("View Submissions"),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text("Edit"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(title,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color)),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
