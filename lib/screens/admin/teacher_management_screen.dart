import 'package:flutter/material.dart';

import 'admin_dashboard.dart';
import 'student_management_screen.dart';
import 'attendance_management_screen.dart';
import 'academic_management_screen.dart';
import 'fee_management_screen.dart';
import 'communication_screen.dart';
import 'reports_screen.dart';

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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const StudentManagementScreen()));
          }),

          _drawerItem(Icons.person, "Teacher Management", () {}),

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

      /// REST OF YOUR ORIGINAL CODE (UNCHANGED)

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

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
        title: const Text("Teacher Details"),
        content: Text(teacher.toString()),
      ),
    );
  }

  void _openAddTeacherDialog() {}
}