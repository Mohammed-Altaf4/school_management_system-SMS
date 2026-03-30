import 'package:flutter/material.dart';
import 'teacher_management_screen.dart';
import 'attendance_management_screen.dart';
import 'academic_management_screen.dart';
import 'fee_management_screen.dart';
import 'communication_screen.dart';
import 'reports_screen.dart';
import 'admin_dashboard.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {

  final Color primaryColor = const Color(0xFF1F3C88);
  final Color darkBlue = const Color(0xFF162E6E);
  final Color iceBlue = const Color(0xFFE6EEF8);

  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> filteredStudents = [];

  int studentCounter = 6;

  @override
  void initState() {
    super.initState();

    students = [
      _dummyStudent("STU001", "Aarav Sharma", "10", "A", "12", "9876543210", "Paid"),
      _dummyStudent("STU002", "Ishita Patel", "9", "B", "5", "9123456780", "Unpaid"),
      _dummyStudent("STU003", "Rahul Verma", "8", "C", "18", "9988776655", "Paid"),
      _dummyStudent("STU004", "Sneha Reddy", "7", "A", "2", "9876501234", "Paid"),
      _dummyStudent("STU005", "Arjun Singh", "10", "B", "9", "9012345678", "Unpaid"),
    ];

    filteredStudents = students;
  }

  Map<String, dynamic> _dummyStudent(
      String id,
      String name,
      String className,
      String section,
      String roll,
      String phone,
      String feeStatus) {

    return {
      "id": id,
      "name": name,
      "class": className,
      "section": section,
      "roll": roll,
      "phone": phone,
      "feeStatus": feeStatus,
    };
  }

  void _searchStudent(String query) {
    setState(() {
      filteredStudents = students.where((student) {
        return student.values
            .join(" ")
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  void _deleteStudent(String id) {
    setState(() {
      students.removeWhere((student) => student["id"] == id);
      filteredStudents = students;
    });
  }

  void _addStudent(Map<String, dynamic> newStudent) {
    setState(() {
      students.add(newStudent);
      filteredStudents = students;
      studentCounter++;
    });
  }

  void _openAddStudentDialog() {
    showDialog(
      context: context,
      builder: (_) => AddStudentDialog(
        studentId: "STU00$studentCounter",
        onSave: (student) {
          _addStudent(student);
        },
      ),
    );
  }

  /// ================= DRAWER =================

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        children: [

          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF162E6E)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.school, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "School Management",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  "Administrator Panel",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          _drawerItem(Icons.dashboard, "Admin Dashboard", () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const AdminDashboard()));
          }),

          _drawerItem(Icons.people, "Student Management", () {
            Navigator.pop(context);
          }),

          _drawerItem(Icons.person, "Teacher Management", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const TeacherManagementScreen()));
          }),

          _drawerItem(Icons.check_circle, "Attendance Management", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AttendanceManagementScreen()));
          }),

          _drawerItem(Icons.menu_book, "Academic Management", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AcademicManagementScreen()));
          }),

          _drawerItem(Icons.attach_money, "Fee Management", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const FeeManagementScreen()));
          }),

          _drawerItem(Icons.message, "Communication", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const CommunicationScreen()));
          }),

          _drawerItem(Icons.bar_chart, "Report", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ReportsScreen()));
          }),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      hoverColor: Colors.white10,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      drawer: _buildDrawer(context),

      backgroundColor: iceBlue,

      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Student Management",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Manage student records",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            )
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "All Students (${filteredStudents.length})",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F3C88),
                  ),
                ),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _openAddStudentDialog,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Student"),
                )
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: searchController,
              onChanged: _searchStudent,
              decoration: InputDecoration(
                hintText: "Search students...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: DataTable(
                    columnSpacing: 30,

                    columns: const [
                      DataColumn(label: Text("Student ID")),
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Class")),
                      DataColumn(label: Text("Section")),
                      DataColumn(label: Text("Roll")),
                      DataColumn(label: Text("Phone")),
                      DataColumn(label: Text("Fee Status")),
                      DataColumn(label: Text("Actions")),
                    ],

                    rows: filteredStudents.map((student) {

                      return DataRow(cells: [

                        DataCell(Text(student["id"])),
                        DataCell(Text(student["name"])),
                        DataCell(Text(student["class"])),
                        DataCell(Text(student["section"])),
                        DataCell(Text(student["roll"])),
                        DataCell(Text(student["phone"])),

                        DataCell(Text(student["feeStatus"])),

                        DataCell(
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == "Delete") {
                                _deleteStudent(student["id"]);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: "Delete",
                                child: Text("Delete"),
                              ),
                            ],
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddStudentDialog extends StatefulWidget {

  final Function(Map<String, dynamic>) onSave;
  final String studentId;

  const AddStudentDialog({
    super.key,
    required this.onSave,
    required this.studentId,
  });

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("Add Student"),

      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextFormField(
                initialValue: widget.studentId,
                decoration: const InputDecoration(labelText: "Student ID"),
                enabled: false,
              ),

              const SizedBox(height: 12),

              _field("name"),
              _field("class"),
              _field("section"),
              _field("roll"),
              _field("phone"),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Fee Status"),
                items: const [
                  DropdownMenuItem(value: "Paid", child: Text("Paid")),
                  DropdownMenuItem(value: "Unpaid", child: Text("Unpaid")),
                ],
                onChanged: (val) => data["feeStatus"] = val,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {

                  if (_formKey.currentState!.validate()) {

                    data["id"] = widget.studentId;

                    widget.onSave(data);

                    Navigator.pop(context);
                  }
                },
                child: const Text("Save Student"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        validator: (value) =>
        value == null || value.isEmpty ? "Required" : null,
        onChanged: (val) => data[label] = val,
      ),
    );
  }
}