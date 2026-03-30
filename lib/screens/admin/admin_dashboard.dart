import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'student_management_screen.dart';
import 'teacher_management_screen.dart';
import 'attendance_management_screen.dart';
import 'academic_management_screen.dart';
import 'fee_management_screen.dart';
import 'communication_screen.dart';
import 'reports_screen.dart';
import '../login_screen.dart';
import '../../widgets/admin_drawer.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  static const Color primaryColor = Color(0xFF1F3C88);
  static const Color darkBlue = Color(0xFF162E6E);
  static const Color iceBlue = Color(0xFFE6EEF8);
  static const Color cardColor = Color(0xFFF2F6FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: iceBlue,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("School Management",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text("Admin Portal",
                style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => logout(context), // <-- Added logout call
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text("Logout",
                style: TextStyle(color: Colors.white)),
          )
        ],
      ),



      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// ===== DASHBOARD TITLE =====
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Admin Dashboard",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                  SizedBox(height: 4),
                  Text("Welcome back! Here's what's happening today.",
                      style: TextStyle(fontSize: 13)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// ===== STAT CARDS =====
            _statCard("Total Students", "1250",
                Icons.people_outline, Colors.blue),
            const SizedBox(height: 16),
            _statCard("Total Teachers", "85",
                Icons.menu_book_outlined, Colors.green),
            const SizedBox(height: 16),
            _statCard("Total Classes", "45",
                Icons.calendar_today_outlined, Colors.purple),
            const SizedBox(height: 16),
            _statCard("Attendance Today", "92.5%",
                Icons.trending_up, Colors.deepOrange),

            const SizedBox(height: 30),

            /// ===== ATTENDANCE CHART =====
            _attendanceChart(),

            const SizedBox(height: 30),

            /// ===== FEE CHART =====
            _feePieChart(),

            const SizedBox(height: 30),

            /// ===== ANNOUNCEMENTS =====
            _announcements(),

            const SizedBox(height: 30),

            /// ===== QUICK ACTIONS =====
            _quickActions(),
          ],
        ),
      ),
    );
  }

  /// ================= LOGOUT FUNCTION =================
  void logout(BuildContext context) {
    // Clear any saved login/session data (if using SharedPreferences or Firebase Auth)
    // Example using SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    // Navigate to Login Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  /// ================= Drawer =================
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        children: [

          /// Header
          const DrawerHeader(
            decoration: BoxDecoration(color: darkBlue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.school, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text("School Management",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 4),
                Text("Administrator Panel",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          _drawerItem(Icons.dashboard, "Admin Dashboard", () {
            Navigator.pop(context);
          }),

          _drawerItem(Icons.people, "Student Management", () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const StudentManagementScreen(),
              ),
            );
          }),

          _drawerItem(Icons.person, "Teacher Management", () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TeacherManagementScreen(),
              ),
            );
          }),

          _drawerItem(Icons.check_circle, "Attendance Management", () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AttendanceManagementScreen(),
              ),
            );
          }),
          _drawerItem(Icons.menu_book, "Academic Management", () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AcademicManagementScreen(),
              ),
            );
          }),
          _drawerItem(Icons.attach_money, "Fee Management", () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FeeManagementScreen(),
              ),
            );
          }),
          _drawerItem(Icons.message, "Communication", () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CommunicationScreen(),
              ),
            );
          }),
          _drawerItem(Icons.bar_chart, "Report", () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ReportsScreen(),
              ),
            );
          }),

        ],
      ),
    );
  }

  Widget _drawerItem(
      IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title:
      Text(title, style: const TextStyle(color: Colors.white)),
      hoverColor: Colors.white10,
      onTap: onTap,
    );
  }

  /// ================= STAT CARD =================
  Widget _statCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.black54)),
                const SizedBox(height: 8),
                Text(value,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight:
                        FontWeight.bold)),
              ]),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius:
              BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          )
        ],
      ),
    );
  }

  /// ================= ATTENDANCE CHART =================
  Widget _attendanceChart() {
    return _cardContainer(
      title: "Monthly Attendance Trend",
      child: SizedBox(
        height: 250,
        child: BarChart(
          BarChartData(
            maxY: 100,
            barGroups: [
              _bar(0, 92),
              _bar(1, 95),
              _bar(2, 90),
              _bar(3, 94),
              _bar(4, 96),
              _bar(5, 93),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= FEE PIE CHART =================
  Widget _feePieChart() {
    return _cardContainer(
      title: "Fee Collection Status",
      child: SizedBox(
        height: 250,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: 700000,
                title: "Collected",
                color: Colors.green,
                radius: 70,
              ),
              PieChartSectionData(
                value: 300000,
                title: "Pending",
                color: Colors.orange,
                radius: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= ANNOUNCEMENTS =================
  Widget _announcements() {
    return _cardContainer(
      title: "Recent Announcements",
      child: Column(
        children: const [
          ListTile(
            leading:
            Icon(Icons.notifications, color: Colors.blue),
            title: Text("Exam Schedule Released"),
            subtitle:
            Text("Final exams start from March 10."),
          ),
          Divider(),
          ListTile(
            leading:
            Icon(Icons.notifications, color: Colors.blue),
            title:
            Text("Parent Teacher Meeting"),
            subtitle:
            Text("PTM scheduled for Feb 25."),
          ),
        ],
      ),
    );
  }

  /// ================= QUICK ACTIONS =================
  Widget _quickActions() {
    return _cardContainer(
      title: "Quick Actions",
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: [
          _quickIcon(Icons.attach_money, "Fees",
              Colors.blue),
          _quickIcon(Icons.people, "Students",
              Colors.green),
          _quickIcon(Icons.bar_chart, "Reports",
              Colors.purple),
        ],
      ),
    );
  }

  Widget _quickIcon(
      IconData icon, String text, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius:
            BorderRadius.circular(15),
          ),
          child:
          Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(text),
      ],
    );
  }

  /// ================= COMMON CARD STYLE =================
  Widget _cardContainer(
      {required String title,
        required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 20),
          child
        ],
      ),
    );
  }

  BarChartGroupData _bar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 18,
          color: const Color(0xFF2F6EDB),
          borderRadius:
          BorderRadius.circular(4),
        )
      ],
    );
  }
}
