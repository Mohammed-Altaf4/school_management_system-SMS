import 'package:flutter/material.dart';
import '../../widgets/teacher_drawer.dart';
class TeacherResultsScreen extends StatefulWidget {
  const TeacherResultsScreen({super.key});

  @override
  State<TeacherResultsScreen> createState() =>
      _TeacherResultsScreenState();
}

class _TeacherResultsScreenState extends State<TeacherResultsScreen> {
  String selectedClass = "10-A";

  final List<String> myClasses = ["10-A", "10-B", "9-A"];

  final List<Map<String, dynamic>> students = [
    {"id": 1, "name": "John Doe", "class": "10-A"},
    {"id": 2, "name": "Jane Smith", "class": "10-A"},
    {"id": 3, "name": "Mike Johnson", "class": "10-B"},
    {"id": 4, "name": "Alice Brown", "class": "9-A"},
  ];

  final List<Map<String, dynamic>> marks = [
    {"studentId": 1, "subject": "Math", "marks": 85, "total": 100},
    {"studentId": 2, "subject": "Math", "marks": 92, "total": 100},
    {"studentId": 3, "subject": "Science", "marks": 74, "total": 100},
    {"studentId": 4, "subject": "English", "marks": 60, "total": 100},
  ];

  final List<Map<String, String>> exams = [
    {
      "name": "Mid Term Exam",
      "start": "2026-03-10",
      "end": "2026-03-20",
      "status": "Upcoming"
    },
    {
      "name": "Final Exam",
      "start": "2026-06-01",
      "end": "2026-06-15",
      "status": "Scheduled"
    },
  ];

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upload Student Marks"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "Select Exam"),
                  items: exams
                      .map((e) => DropdownMenuItem(
                    value: e["name"],
                    child: Text(e["name"]!),
                  ))
                      .toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "Select Class"),
                  items: myClasses
                      .map((cls) => DropdownMenuItem(
                    value: cls,
                    child: Text("Class $cls"),
                  ))
                      .toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(labelText: "Subject"),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_file, size: 30),
                        SizedBox(height: 6),
                        Text("Upload Excel File"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Marks uploaded successfully!")),
                  );
                },
                child: const Text("Upload Marks"))
          ],
        );
      },
    );
  }

  String calculateGrade(double percentage) {
    if (percentage >= 90) return "A+";
    if (percentage >= 80) return "A";
    if (percentage >= 70) return "B";
    if (percentage >= 60) return "C";
    if (percentage >= 50) return "D";
    return "F";
  }

  @override
  Widget build(BuildContext context) {
    final classStudents =
    students.where((s) => s["class"] == selectedClass).toList();
    return Scaffold(
      drawer: const TeacherDrawer(),
      backgroundColor: const Color(0xFFE6EEF8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Exam Results",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Filter Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<String>(
                  value: selectedClass,
                  decoration: const InputDecoration(
                    labelText: "Select Class",
                    border: OutlineInputBorder(),
                  ),
                  items: myClasses
                      .map((cls) => DropdownMenuItem(
                    value: cls,
                    child: Text("Class $cls"),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedClass = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Student Results Table
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("ID")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Subject")),
                    DataColumn(label: Text("Marks")),
                    DataColumn(label: Text("Total")),
                    DataColumn(label: Text("Percentage")),
                    DataColumn(label: Text("Grade")),
                  ],
                  rows: marks.map((mark) {
                    final student = students
                        .firstWhere((s) => s["id"] == mark["studentId"]);
                    if (student["class"] != selectedClass) {
                      return const DataRow(cells: []);
                    }

                    double percentage =
                        (mark["marks"] / mark["total"]) * 100;
                    String grade = calculateGrade(percentage);

                    return DataRow(cells: [
                      DataCell(Text(mark["studentId"].toString())),
                      DataCell(Text(student["name"])),
                      DataCell(Text(mark["subject"])),
                      DataCell(Text(mark["marks"].toString())),
                      DataCell(Text(mark["total"].toString())),
                      DataCell(Text("${percentage.toStringAsFixed(1)}%")),
                      DataCell(Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: grade.startsWith("A")
                              ? Colors.green
                              : grade == "B"
                              ? Colors.orange
                              : Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          grade,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
                    ]);
                  }).where((row) => row.cells.isNotEmpty).toList(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Upcoming Exams
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Upcoming Exams",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...exams.map((exam) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(exam["name"]!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "${exam["start"]} to ${exam["end"]}",
                                    style: const TextStyle(
                                        color: Colors.grey)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                exam["status"]!,
                                style: const TextStyle(
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
