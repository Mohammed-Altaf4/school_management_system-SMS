import 'package:flutter/material.dart';

// Dummy students data
final List<Map<String, dynamic>> students = [
  {'id': 1, 'name': 'John Doe', 'rollNo': '101', 'class': '10-A'},
  {'id': 2, 'name': 'Jane Smith', 'rollNo': '102', 'class': '10-A'},
  {'id': 3, 'name': 'Mike Johnson', 'rollNo': '103', 'class': '10-B'},
  {'id': 4, 'name': 'Alice Brown', 'rollNo': '104', 'class': '10-B'},
  {'id': 5, 'name': 'Bob White', 'rollNo': '105', 'class': '9-A'},
];

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  String selectedClass = '10-A';
  Map<int, String> attendanceData = {};
  final List<String> myClasses = ['10-A', '10-B', '9-A'];

  @override
  void initState() {
    super.initState();
    _initializeAttendance();
  }

  void _initializeAttendance() {
    final classStudents = students.where((s) => s['class'] == selectedClass);
    attendanceData = {
      for (var s in classStudents) s['id'] as int: 'Present'
    };
  }

  void _toggleAttendance(int studentId) {
    setState(() {
      attendanceData[studentId] =
      attendanceData[studentId] == 'Present' ? 'Absent' : 'Present';
    });
  }

  void _saveAttendance() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Attendance saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classStudents =
    students.where((s) => s['class'] == selectedClass).toList();
    final presentCount =
        attendanceData.values.where((v) => v == 'Present').length;
    final attendancePercentage =
    classStudents.isEmpty ? 0 : (presentCount / classStudents.length * 100);

    return Scaffold(
      backgroundColor: const Color(0xFFE6EEF8),
      appBar: AppBar(
        title: const Text("Mark Attendance"),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Header + Smaller Save Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mark Attendance",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Record student attendance for your classes",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                /// Smaller Button
                SizedBox(
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: _saveAttendance,
                    icon: const Icon(Icons.save, size: 18),
                    label: const Text(
                      "Save",
                      style: TextStyle(fontSize: 13),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Class Selector
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<String>(
                  value: selectedClass,
                  decoration: const InputDecoration(
                    labelText: 'Select Class',
                    border: OutlineInputBorder(),
                  ),
                  items: myClasses
                      .map((cls) => DropdownMenuItem(
                    value: cls,
                    child: Text("Class $cls"),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedClass = value;
                        _initializeAttendance();
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Stats Cards — FIXED (Responsive Row instead of vertical)
            Row(
              children: [
                Expanded(
                    child: _statCard("Total Students",
                        classStudents.length.toString(), Colors.blue)),
                const SizedBox(width: 10),
                Expanded(
                    child: _statCard(
                        "Present", presentCount.toString(), Colors.green)),
                const SizedBox(width: 10),
                Expanded(
                    child: _statCard(
                        "Attendance",
                        "${attendancePercentage.toStringAsFixed(1)}%",
                        Colors.purple)),
              ],
            ),

            const SizedBox(height: 16),

            /// Attendance Table
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Roll No')),
                    DataColumn(label: Text('Student Name')),
                    DataColumn(label: Text('Student ID')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: classStudents.map((student) {
                    final id = student['id'] as int;
                    final status = attendanceData[id] ?? 'Present';
                    return DataRow(cells: [
                      DataCell(Text(student['rollNo'].toString())),
                      DataCell(Text(student['name'].toString())),
                      DataCell(Text(student['id'].toString())),
                      DataCell(Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: status == 'Present'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(status,
                            style: const TextStyle(color: Colors.white)),
                      )),
                      DataCell(ElevatedButton.icon(
                        onPressed: () => _toggleAttendance(id),
                        icon: Icon(
                          status == 'Present'
                              ? Icons.cancel_outlined
                              : Icons.check_circle_outline,
                          size: 18,
                          color: status == 'Present'
                              ? Colors.red
                              : Colors.green,
                        ),
                        label: Text(
                          status == 'Present'
                              ? "Absent"
                              : "Present",
                          style: const TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: const BorderSide(color: Colors.grey),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                        ),
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54)),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color)),
        ],
      ),
    );
  }
}
