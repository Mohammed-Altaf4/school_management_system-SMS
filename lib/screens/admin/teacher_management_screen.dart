import 'package:flutter/material.dart';

class TeacherManagementScreen extends StatefulWidget {
  const TeacherManagementScreen({super.key});

  @override
  State<TeacherManagementScreen> createState() =>
      _TeacherManagementScreenState();
}

class _TeacherManagementScreenState
    extends State<TeacherManagementScreen> {

  final Color primaryColor = const Color(0xFF1F3C88);
  final Color iceBlue = const Color(0xFFE6EEF8);
  final Color cardColor = const Color(0xFFF4F7FC);

  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> teachers = [];
  List<Map<String, dynamic>> filteredTeachers = [];

  int teacherCounter = 6;

  @override
  void initState() {
    super.initState();

    teachers = [
      _dummyTeacher("TCH001", "Rajesh Kumar", "Mathematics"),
      _dummyTeacher("TCH002", "Anita Sharma", "Physics"),
      _dummyTeacher("TCH003", "Vikram Singh", "Chemistry"),
      _dummyTeacher("TCH004", "Priya Reddy", "English"),
      _dummyTeacher("TCH005", "Amit Patel", "Biology"),
    ];

    filteredTeachers = teachers;
  }

  Map<String, dynamic> _dummyTeacher(
      String id,
      String name,
      String subject,
      ) {
    return {
      "id": id,
      "name": name,
      "subject": subject,
      "qualification": "M.Sc.",
      "experience": "5 Years",
      "email": "teacher@school.com",
      "phone": "9876543210",
      "joiningDate": "2021-06-15",
      "classes": ["10-A", "9-B"],
    };
  }

  void _searchTeacher(String query) {
    setState(() {
      filteredTeachers = teachers.where((teacher) {
        return teacher.values
            .join(" ")
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  void _addTeacher(Map<String, dynamic> teacher) {
    setState(() {
      teachers.add(teacher);
      filteredTeachers = teachers;
      teacherCounter++;
    });
  }

  void _deleteTeacher(String id) {
    setState(() {
      teachers.removeWhere((teacher) => teacher["id"] == id);
      filteredTeachers = teachers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iceBlue,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Teacher Management",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Manage teacher profiles and assignments",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Teachers (${filteredTeachers.length})",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _openAddTeacherDialog,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Add Teacher",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// Search Bar
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: searchController,
                onChanged: _searchTeacher,
                decoration: const InputDecoration(
                  hintText: "Search by name, ID, or subject...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// Table
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                        primaryColor.withOpacity(0.12)),
                    headingTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 14,
                    ),
                    dataTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    columns: const [
                      DataColumn(label: Text("ID")),
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Subject")),
                      DataColumn(label: Text("Qualification")),
                      DataColumn(label: Text("Experience")),
                      DataColumn(label: Text("Classes")),
                      DataColumn(label: Text("Actions")),
                    ],
                    rows: filteredTeachers.map((teacher) {
                      return DataRow(cells: [
                        DataCell(Text(teacher["id"])),
                        DataCell(Text(teacher["name"])),
                        DataCell(Text(teacher["subject"])),
                        DataCell(Text(teacher["qualification"])),
                        DataCell(Text(teacher["experience"])),
                        DataCell(_classBadges(teacher["classes"])),
                        DataCell(_actionMenu(teacher)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _classBadges(List classes) {
    return Wrap(
      spacing: 6,
      children: classes.map<Widget>((cls) {
        return Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            cls,
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600),
          ),
        );
      }).toList(),
    );
  }

  Widget _actionMenu(Map<String, dynamic> teacher) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == "View") {
          _viewDetails(teacher);
        } else if (value == "Delete") {
          _deleteTeacher(teacher["id"]);
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(value: "View", child: Text("View Details")),
        PopupMenuItem(value: "Delete", child: Text("Delete")),
      ],
    );
  }

  void _viewDetails(Map<String, dynamic> teacher) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)),
        title: const Text(
          "Teacher Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: teacher.entries.map((e) {
                if (e.key == "classes") {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Assigned Classes:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        _classBadges(e.value),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    "${e.key.toUpperCase()} : ${e.value}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text("Close"))
        ],
      ),
    );
  }

  void _openAddTeacherDialog() {
    showDialog(
      context: context,
      builder: (_) => AddTeacherDialog(
        teacherId:
        "TCH${teacherCounter.toString().padLeft(3, '0')}",
        onSave: _addTeacher,
      ),
    );
  }
}

class AddTeacherDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final String teacherId;

  const AddTeacherDialog({
    super.key,
    required this.onSave,
    required this.teacherId,
  });

  @override
  State<AddTeacherDialog> createState() => _AddTeacherDialogState();
}

class _AddTeacherDialogState extends State<AddTeacherDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text(
        "Add Teacher",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.teacherId,
                  decoration:
                  const InputDecoration(labelText: "Teacher ID"),
                  enabled: false,
                ),
                _field("Full Name"),
                _field("Subject"),
                _field("Qualification"),
                _field("Experience"),
                _field("Email"),
                _field("Phone"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: const Text("Cancel")),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!
                              .validate()) {
                            data["id"] =
                                widget.teacherId;
                            data["classes"] =
                            ["10-A"];
                            widget.onSave(data);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Save"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      validator: (val) =>
      val == null || val.isEmpty
          ? "Required"
          : null,
      onChanged: (val) =>
      data[label.toLowerCase()] = val,
    );
  }
}
