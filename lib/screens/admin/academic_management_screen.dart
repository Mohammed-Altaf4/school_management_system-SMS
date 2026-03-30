import 'package:flutter/material.dart';
import '../../widgets/admin_drawer.dart';

class AcademicManagementScreen extends StatefulWidget {
  const AcademicManagementScreen({super.key});

  @override
  State<AcademicManagementScreen> createState() =>
      _AcademicManagementScreenState();
}

class _AcademicManagementScreenState extends State<AcademicManagementScreen>
    with TickerProviderStateMixin {
  static const Color primaryColor = Color(0xFF1F3C88);
  static const Color accentBlue = Color(0xFF3A6FF7);
  static const Color backgroundColor = Color(0xFFEAF1FF);
  static const Color cardColor = Colors.white;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// ================= DATA =================

  List<Map<String, dynamic>> exams = [
    {
      "id": "EX001",
      "name": "Mid Term Exam",
      "class": "10-A",
      "startDate": "2026-03-01",
      "endDate": "2026-03-05",
      "status": "Upcoming"
    },
    {
      "id": "EX002",
      "name": "Final Exam",
      "class": "10-B",
      "startDate": "2026-04-01",
      "endDate": "2026-04-10",
      "status": "Ongoing"
    },
  ];

  List<Map<String, dynamic>> students = [
    {"id": "STU001", "name": "Rahul Sharma", "class": "10-A"},
    {"id": "STU002", "name": "Anita Singh", "class": "10-B"},
  ];

  List<Map<String, dynamic>> marks = [
    {
      "studentId": "STU001",
      "studentName": "Rahul Sharma",
      "subject": "Maths",
      "marksObtained": 85,
      "totalMarks": 100,
    },
  ];

  List<Map<String, dynamic>> timetable = [
    {
      "day": "Monday",
      "periods": [
        {"time": "9:00 - 10:00", "subject": "Maths", "teacher": "Mr. Sharma"},
        {"time": "10:00 - 11:00", "subject": "Science", "teacher": "Ms. Priya"},
        {"time": "11:00 - 11:30", "subject": "Break"},
      ]
    },
  ];

  /// ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Academic Management",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              "Manage exams, timetables & academic records",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            )
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: "Examinations"),
            Tab(text: "Marks Entry"),
            Tab(text: "Timetable"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _examsTab(),
          _marksTab(),
          _timetableTab(),
        ],
      ),
    );
  }

  /// ================= EXAMS TAB =================

  Widget _examsTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _responsiveHeader(
                "Scheduled Examinations", "Schedule Exam", _showAddExamDialog),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 30,
                  columns: const [
                    DataColumn(label: Text("Exam ID")),
                    DataColumn(label: Text("Exam Name")),
                    DataColumn(label: Text("Class")),
                    DataColumn(label: Text("Start Date")),
                    DataColumn(label: Text("End Date")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows: exams.map((exam) {
                    return DataRow(cells: [
                      DataCell(Text(exam["id"])),
                      DataCell(Text(exam["name"])),
                      DataCell(Text(exam["class"])),
                      DataCell(Text(exam["startDate"])),
                      DataCell(Text(exam["endDate"])),
                      DataCell(_statusBadge(exam["status"])),
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

  /// ================= MARKS TAB =================

  Widget _marksTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _card(
        child: Column(
          children: [
            _responsiveHeader("Student Marks", "Add Marks", _showAddMarksDialog),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 30,
                  columns: const [
                    DataColumn(label: Text("Student ID")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Subject")),
                    DataColumn(label: Text("Marks")),
                    DataColumn(label: Text("Total")),
                    DataColumn(label: Text("Percentage")),
                  ],
                  rows: marks.map((mark) {
                    double percent =
                        (mark["marksObtained"] / mark["totalMarks"]) * 100;

                    return DataRow(cells: [
                      DataCell(Text(mark["studentId"])),
                      DataCell(Text(mark["studentName"])),
                      DataCell(Text(mark["subject"])),
                      DataCell(Text(mark["marksObtained"].toString())),
                      DataCell(Text(mark["totalMarks"].toString())),
                      DataCell(_percentageBadge(percent)),
                    ]);
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// ================= TIMETABLE TAB =================

  Widget _timetableTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: timetable.map((dayData) {
        return _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dayData["day"],
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const SizedBox(height: 15),
              ...dayData["periods"].map<Widget>((period) {
                bool isBreak = period["subject"] == "Break";

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isBreak ? Colors.grey.shade200 : backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(period["time"]),
                      isBreak
                          ? const Text("Break Time")
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            period["subject"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          Text(period["teacher"]),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// ================= HEADER =================

  Widget _responsiveHeader(
      String title, String buttonText, VoidCallback onTap) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentBlue,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
          onPressed: onTap,
          icon: const Icon(Icons.add),
          label: Text(buttonText),
        ),
      ],
    );
  }
  /// ================= BADGES =================

  Widget _statusBadge(String status) {
    Color color = status == "Ongoing"
        ? Colors.green
        : status == "Completed"
        ? Colors.grey
        : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _percentageBadge(double percent) {
    Color color = percent >= 75
        ? Colors.green
        : percent >= 50
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text("${percent.toStringAsFixed(1)}%",
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
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

  /// ================= DIALOGS =================

  void _showAddExamDialog() {}

  void _showAddMarksDialog() {}
}