import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState
    extends State<StudentManagementScreen> {

  final Color primaryColor = const Color(0xFF1F3C88);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iceBlue,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Student Management",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Manage student records and information",
              style: TextStyle(
                fontSize: 13,
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

            /// Top Section
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                  ),
                  onPressed: () => _openAddStudentDialog(),
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    "Add Student",
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// Search Bar
            TextField(
              controller: searchController,
              onChanged: _searchStudent,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText:
                "Search by name, ID, class, roll number, or phone number",
                hintStyle: const TextStyle(color: Colors.black54),
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 20),

            /// Student Table
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
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F3C88),
                      fontSize: 15,
                    ),
                    dataTextStyle: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
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
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: student["feeStatus"] == "Paid"
                                ? Colors.green.withOpacity(0.15)
                                : Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            student["feeStatus"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: student["feeStatus"] == "Paid"
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        )),
                        DataCell(PopupMenuButton<String>(
                          iconColor: primaryColor,
                          onSelected: (value) {
                            if (value == "Delete") {
                              _deleteStudent(student["id"]);
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                                value: "Delete", child: Text("Delete")),
                          ],
                        )),
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

  void _openAddStudentDialog() {
    showDialog(
      context: context,
      builder: (_) => AddStudentDialog(
        onSave: (student) {
          _addStudent(student);
        },
        studentId: "STU00$studentCounter",
      ),
    );
  }
}

class AddStudentDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final String studentId;

  const AddStudentDialog(
      {super.key, required this.onSave, required this.studentId});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Add Student",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F3C88)),
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                TextFormField(
                  initialValue: widget.studentId,
                  decoration:
                  const InputDecoration(labelText: "Student ID"),
                  enabled: false,
                ),

                const SizedBox(height: 12),

                _field("Full Name"),
                _field("Class"),
                _field("Section"),
                _field("Roll Number"),
                _field("Phone"),

                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  decoration:
                  const InputDecoration(labelText: "Fee Status"),
                  items: const [
                    DropdownMenuItem(value: "Paid", child: Text("Paid")),
                    DropdownMenuItem(value: "Unpaid", child: Text("Unpaid")),
                  ],
                  onChanged: (val) => data["feeStatus"] = val,
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F3C88),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      data["id"] = widget.studentId;
                      widget.onSave(data);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Save Student",
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
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
        onChanged: (val) => data[label.toLowerCase()] = val,
      ),
    );
  }
}
