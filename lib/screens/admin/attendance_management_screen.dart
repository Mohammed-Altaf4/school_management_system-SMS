import 'package:flutter/material.dart';
import '../../widgets/admin_drawer.dart';

class AttendanceManagementScreen extends StatefulWidget {
  const AttendanceManagementScreen({super.key});

  @override
  State<AttendanceManagementScreen> createState() =>
      _AttendanceManagementScreenState();
}

class _AttendanceManagementScreenState
    extends State<AttendanceManagementScreen> {

  /// ✅ FIX: Scaffold Key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const Color primaryColor = Color(0xFF1F3C88);
  static const Color iceBlue = Color(0xFFE6EEF8);
  static const Color cardColor = Color(0xFFF4F7FC);

  String selectedClass = "10-A";
  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> students = [
    {"id": "STU001", "name": "Rahul Sharma", "roll": 1, "class": "10-A"},
    {"id": "STU002", "name": "Anjali Verma", "roll": 2, "class": "10-A"},
    {"id": "STU003", "name": "Amit Kumar", "roll": 3, "class": "10-A"},
    {"id": "STU004", "name": "Sneha Patel", "roll": 4, "class": "10-A"},
    {"id": "STU005", "name": "Rohit Singh", "roll": 5, "class": "10-A"},
  ];

  Map<String, String> attendanceData = {};

  @override
  void initState() {
    super.initState();
    _initializeAttendance();
  }

  void _initializeAttendance() {
    for (var student in students) {
      attendanceData[student["id"]] = "Present";
    }
  }

  void _toggleAttendance(String id) {
    setState(() {
      attendanceData[id] =
      attendanceData[id] == "Present" ? "Absent" : "Present";
    });
  }

  void _saveAttendance() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Attendance saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {

    final classStudents =
    students.where((s) => s["class"] == selectedClass).toList();

    int totalStudents = classStudents.length;

    int presentCount = attendanceData.values
        .where((status) => status == "Present")
        .length;

    int absentCount = totalStudents - presentCount;

    double percentage =
    totalStudents == 0 ? 0 : (presentCount / totalStudents) * 100;

    return Scaffold(
      key: _scaffoldKey, // ✅ IMPORTANT

      drawer: AppDrawer(),

      backgroundColor: iceBlue,

      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,

        /// ✅ FIXED HAMBURGER MENU
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),

        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance Management",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Track and manage student attendance",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          bool isMobile = constraints.maxWidth < 800;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                _card(
                  child: isMobile
                      ? Column(
                    children: [
                      _classDropdown(),
                      const SizedBox(height: 16),
                      _datePicker(),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(child: _classDropdown()),
                      const SizedBox(width: 20),
                      Expanded(child: _datePicker()),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: isMobile ? 110 : 120,
                  ),
                  itemBuilder: (context, index) {
                    final stats = [
                      ["Total Students", totalStudents.toString(), Icons.people, Colors.blue],
                      ["Present", presentCount.toString(), Icons.check_circle, Colors.green],
                      ["Absent", absentCount.toString(), Icons.cancel, Colors.red],
                      ["Attendance %",
                        "${percentage.toStringAsFixed(1)}%",
                        Icons.percent,
                        Colors.purple],
                    ];

                    return _statCard(
                      stats[index][0] as String,
                      stats[index][1] as String,
                      stats[index][2] as IconData,
                      stats[index][3] as Color,
                    );
                  },
                ),

                const SizedBox(height: 30),

                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mark Attendance - $selectedClass",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Attendance: ${percentage.toStringAsFixed(1)}%",
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          _saveButton(),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text("Roll No")),
                            DataColumn(label: Text("Student Name")),
                            DataColumn(label: Text("Student ID")),
                            DataColumn(label: Text("Status")),
                            DataColumn(label: Text("Action")),
                          ],
                          rows: classStudents.map((student) {

                            String status =
                                attendanceData[student["id"]] ?? "Present";

                            return DataRow(cells: [
                              DataCell(Text(student["roll"].toString())),
                              DataCell(Text(student["name"])),
                              DataCell(Text(student["id"])),
                              DataCell(_statusBadge(status)),
                              DataCell(
                                OutlinedButton(
                                  onPressed: () =>
                                      _toggleAttendance(student["id"]),
                                  child: Text(
                                    status == "Present"
                                        ? "Mark Absent"
                                        : "Mark Present",
                                  ),
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _classDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedClass,
      decoration: const InputDecoration(labelText: "Select Class"),
      items: const [
        DropdownMenuItem(value: "10-A", child: Text("Class 10-A")),
        DropdownMenuItem(value: "10-B", child: Text("Class 10-B")),
        DropdownMenuItem(value: "9-A", child: Text("Class 9-A")),
      ],
      onChanged: (value) {
        setState(() {
          selectedClass = value!;
        });
      },
    );
  }

  Widget _datePicker() {
    return TextFormField(
      readOnly: true,
      decoration: const InputDecoration(
        labelText: "Select Date",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      controller: TextEditingController(
        text:
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            selectedDate = picked;
          });
        }
      },
    );
  }

  Widget _saveButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
      ),
      onPressed: _saveAttendance,
      icon: const Icon(Icons.save),
      label: const Text("Save Attendance"),
    );
  }

  Widget _statusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: status == "Present"
            ? Colors.green.withOpacity(0.15)
            : Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: status == "Present" ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  Widget _statCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 6),
                Text(value,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ]),
          Icon(icon, color: color),
        ],
      ),
    );
  }
}