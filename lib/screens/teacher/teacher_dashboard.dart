import 'package:flutter/material.dart';
import 'teacher_attendance_screen.dart';
import 'teacher_homework_screen.dart';
import 'teacher_results_screen.dart';

// Dummy Data
final List<Map<String, dynamic>> timetable = [
  {
    'day': 'Monday',
    'periods': [
      {'subject': 'Mathematics', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'Physics', 'time': '10:00 AM - 11:00 AM'},
      {'subject': 'Break', 'time': '11:00 AM - 11:15 AM'},
      {'subject': 'Chemistry', 'time': '11:15 AM - 12:15 PM'},
      {'subject': 'English', 'time': '12:15 PM - 1:15 PM'},
    ],
  }
];

final List<Map<String, dynamic>> students = [
  {'id': 1, 'name': 'John Doe', 'rollNo': '101', 'class': '10-A'},
  {'id': 2, 'name': 'Jane Smith', 'rollNo': '102', 'class': '10-A'},
  {'id': 3, 'name': 'Mike Johnson', 'rollNo': '103', 'class': '10-B'},
];

final List<Map<String, dynamic>> homework = [
  {
    'id': 1,
    'title': 'Algebra Homework',
    'description': 'Complete exercises 1-10',
    'class': '10-A',
    'subject': 'Mathematics',
    'assignedDate': '2026-02-18',
    'dueDate': '2026-02-20',
    'submitted': 25,
    'pending': 10
  },
  {
    'id': 2,
    'title': 'Physics Assignment',
    'description': 'Chapter 3 Questions',
    'class': '10-A',
    'subject': 'Physics',
    'assignedDate': '2026-02-18',
    'dueDate': '2026-02-22',
    'submitted': 20,
    'pending': 5
  },
];

final Map<String, dynamic> dashboardStats = {
  'teacher': {
    'totalClasses': 3,
    'totalStudents': 30,
    'attendanceToday': 92,
    'pendingHomework': 6
  }
};

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard>
    with SingleTickerProviderStateMixin {
  List<String> myClasses = ['10-A', '10-B', '9-A'];

  List<Map<String, dynamic>> get myStudents =>
      students.where((s) => myClasses.contains(s['class'])).toList();

  List<Map<String, dynamic>> get myHomework => homework.take(2).toList();

  List<Map<String, dynamic>> get todaySchedule =>
      timetable[0]['periods'] as List<Map<String, dynamic>>;

  final stats = dashboardStats['teacher'] as Map<String, dynamic>;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEF8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        title: const Text(
          'Teacher Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1E3A8A)),
              child: Text("Menu",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text("Attendance"),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeacherAttendanceScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Homework"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeacherHomeworkScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Results"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeacherResultsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome back!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("Here's your overview for today."),
              const SizedBox(height: 16),

              // Stats Cards
              _statCard("My Classes", stats['totalClasses'].toString(),
                  Colors.blue, Icons.class_),
              const SizedBox(height: 12),
              _statCard("Total Students", stats['totalStudents'].toString(),
                  Colors.green, Icons.group),
              const SizedBox(height: 12),
              _statCard("Attendance Today", "${stats['attendanceToday']}%",
                  Colors.purple, Icons.access_time),
              const SizedBox(height: 12),
              _statCard("Pending Reviews", stats['pendingHomework'].toString(),
                  Colors.orange, Icons.pending_actions),
              const SizedBox(height: 16),

              // Tabs
              DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Overview'),
                        Tab(text: 'Schedule'),
                        Tab(text: 'My Classes'),
                        Tab(text: 'Assignments'),
                      ],
                      labelColor: Colors.white,
                      labelStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.black87,
                      indicatorColor: Colors.blue,
                      indicatorWeight: 3,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 600,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _overviewTab(),
                          _scheduleTab(),
                          _classesTab(),
                          _assignmentsTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ]),
          Icon(icon, color: color, size: 30),
        ],
      ),
    );
  }

  // Tabs

  Widget _overviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Today's Schedule (Quick View)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Column(
                    children: todaySchedule.map((period) {
                      final subject = period['subject']?.toString() ?? '';
                      final time = period['time']?.toString() ?? '';
                      final isBreak = subject.toLowerCase() == 'break';
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color:
                            isBreak ? Colors.grey[100] : Colors.blue[50],
                            border: Border.all(
                                color: isBreak
                                    ? Colors.grey[300]!
                                    : Colors.blue[200]!),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(subject,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(time,
                                    style:
                                    const TextStyle(color: Colors.grey)),
                              ],
                            ),
                            if (!isBreak)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4)),
                                child: const Text("Class 10-A",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _quickActionCard("Mark Attendance", Colors.blue),
                  const SizedBox(height: 8),
                  _quickActionCard("Assign Homework", Colors.green),
                  const SizedBox(height: 8),
                  _quickActionCard("Upload Results", Colors.purple),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scheduleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: todaySchedule.map((period) {
          final subject = period['subject']?.toString() ?? '';
          final time = period['time']?.toString() ?? '';
          final isBreak = subject.toLowerCase() == 'break';
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: isBreak ? Colors.grey[100] : Colors.blue[50],
                border: Border.all(
                    color: isBreak ? Colors.grey[300]! : Colors.blue[200]!),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subject,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(time,
                          style: const TextStyle(color: Colors.grey)),
                    ]),
                if (!isBreak)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Text("Class 10-A",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _classesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: myClasses.map((className) {
          final classStudents =
          myStudents.where((s) => s['class'] == className).toList();
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Class $className",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("${classStudents.length} Students",
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Column(
                      children: classStudents.map((student) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            children: [
                              const Icon(Icons.person, color: Colors.blue),
                              const SizedBox(width: 8),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(student['name']?.toString() ?? ''),
                                    Text(
                                        "Roll No: ${student['rollNo']?.toString() ?? ''}",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey))
                                  ]),
                            ],
                          ),
                        );
                      }).toList())
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _assignmentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: myHomework.map((hw) {
          final title = hw['title']?.toString() ?? '';
          final desc = hw['description']?.toString() ?? '';
          final assigned = hw['assignedDate']?.toString() ?? '';
          final due = hw['dueDate']?.toString() ?? '';
          final subject = hw['subject']?.toString() ?? '';
          final cls = hw['class']?.toString() ?? '';
          final submitted = hw['submitted']?.toString() ?? '0';
          final pending = hw['pending']?.toString() ?? '0';

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(desc),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text("Class: $cls • Subject: $subject",
                              overflow: TextOverflow.ellipsis)),
                      Flexible(
                          child: Text("Assigned: $assigned • Due: $due",
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _badge("Submitted: $submitted", Colors.green),
                      const SizedBox(width: 6),
                      _badge("Pending: $pending", Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _quickActionCard(String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color.withOpacity(0.1)]),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color)),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: color),
          const SizedBox(width: 8),
          Text(title,
              style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _badge(String text, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
