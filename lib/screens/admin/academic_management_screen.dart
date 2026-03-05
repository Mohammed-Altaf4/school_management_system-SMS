import 'package:flutter/material.dart';

class AcademicManagementScreen extends StatefulWidget {
  const AcademicManagementScreen({super.key});

  @override
  State<AcademicManagementScreen> createState() =>
      _AcademicManagementScreenState();
}

class _AcademicManagementScreenState
    extends State<AcademicManagementScreen>
    with TickerProviderStateMixin {
  static const Color primaryColor = Color(0xFF1F3C88);
  static const Color accentBlue = Color(0xFF3A6FF7);
  static const Color backgroundColor = Color(0xFFEAF1FF);
  static const Color cardColor = Colors.white;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
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
          labelColor: Colors.white, // ACTIVE TAB COLOR
          unselectedLabelColor: Colors.white70, // INACTIVE TAB COLOR
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
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
            _responsiveHeader("Scheduled Examinations", "Schedule Exam", _showAddExamDialog),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 30,
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 15,
                  ),
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
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  columns: const [
                    DataColumn(label: Text("Student ID")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Subject")),
                    DataColumn(label: Text("Marks")),
                    DataColumn(label: Text("Total")),
                    DataColumn(label: Text("Percentage")),
                  ],
                  rows: marks.map((mark) {
                    double percent = (mark["marksObtained"] / mark["totalMarks"]) * 100;
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
                  color: primaryColor,
                ),
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
                      Text(
                        period["time"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      isBreak
                          ? const Text(
                        "Break Time",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            period["subject"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            period["teacher"],
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                          ),
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
  Widget _responsiveHeader(String title, String buttonText, VoidCallback onTap) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentBlue,
                    foregroundColor: Colors.white, // Text color
                  ),
                  onPressed: onTap,
                  icon: const Icon(Icons.add),
                  label: Text(buttonText),
                ),
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                foregroundColor: Colors.white, // Text color
              ),
              onPressed: onTap,
              icon: const Icon(Icons.add),
              label: Text(buttonText),
            ),
          ],
        );
      },
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
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
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
      child: Text(
        "${percent.toStringAsFixed(1)}%",
        style: TextStyle(
          color: color,
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: child,
    );
  }

  /// ================= DIALOGS =================
  void _showAddExamDialog() {
    String examName = "";
    String selectedClass = "10-A";
    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Schedule New Exam"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Exam Name"),
                onChanged: (val) => examName = val,
              ),
              DropdownButtonFormField(
                value: selectedClass,
                items: ["10-A", "10-B", "9-A", "9-B"]
                    .map((cls) => DropdownMenuItem(
                  value: cls,
                  child: Text(cls),
                ))
                    .toList(),
                decoration: const InputDecoration(labelText: "Class"),
                onChanged: (val) => selectedClass = val.toString(),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Start Date",
                    hintText: startDate != null ? startDate.toString() : ""),
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030));
                  if (date != null) setState(() => startDate = date);
                },
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "End Date",
                    hintText: endDate != null ? endDate.toString() : ""),
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030));
                  if (date != null) setState(() => endDate = date);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (examName.isNotEmpty && startDate != null && endDate != null) {
                setState(() {
                  exams.add({
                    "id": "EX${exams.length + 1}",
                    "name": examName,
                    "class": selectedClass,
                    "startDate": startDate.toString().split(" ")[0],
                    "endDate": endDate.toString().split(" ")[0],
                    "status": "Upcoming"
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Schedule Exam"),
          )
        ],
      ),
    );
  }

  void _showAddMarksDialog() {
    String selectedStudent = students.first["id"];
    String selectedSubject = "";
    int marksObtained = 0;
    int totalMarks = 100;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Student Marks"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField(
                value: selectedStudent,
                items: students
                    .map((s) => DropdownMenuItem(
                  value: s["id"],
                  child: Text("${s["name"]} - ${s["class"]}"),
                ))
                    .toList(),
                decoration: const InputDecoration(labelText: "Student"),
                onChanged: (val) => selectedStudent = val.toString(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Subject"),
                onChanged: (val) => selectedSubject = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Marks Obtained"),
                keyboardType: TextInputType.number,
                onChanged: (val) => marksObtained = int.tryParse(val) ?? 0,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Total Marks"),
                keyboardType: TextInputType.number,
                onChanged: (val) => totalMarks = int.tryParse(val) ?? 100,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final student =
              students.firstWhere((s) => s["id"] == selectedStudent);
              setState(() {
                marks.add({
                  "studentId": selectedStudent,
                  "studentName": student["name"],
                  "subject": selectedSubject,
                  "marksObtained": marksObtained,
                  "totalMarks": totalMarks,
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Add Marks"),
          )
        ],
      ),
    );
  }
}
