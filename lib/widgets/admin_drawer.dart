import 'package:flutter/material.dart';

import '../screens/admin/admin_dashboard.dart';
import '../screens/admin/student_management_screen.dart';
import '../screens/admin/teacher_management_screen.dart';
import '../screens/admin/attendance_management_screen.dart';
import '../screens/admin/academic_management_screen.dart';
import '../screens/admin/fee_management_screen.dart';
import '../screens/admin/communication_screen.dart';
import '../screens/admin/reports_screen.dart';
import '../screens/admin/events_posts_screen.dart';

class AppDrawer extends StatelessWidget {
  final Color primaryColor = const Color(0xFF1F3C88);

  AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          /// 🔷 HEADER
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
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Administrator Panel",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          /// 📊 MENU ITEMS
          _drawerItem(context, Icons.dashboard, "Admin Dashboard",
              const AdminDashboard()),

          _drawerItem(context, Icons.people, "Student Management",
              const StudentManagementScreen()),

          _drawerItem(context, Icons.person, "Teacher Management",
              const TeacherManagementScreen()),

          _drawerItem(context, Icons.check_circle, "Attendance Management",
              const AttendanceManagementScreen()),

          _drawerItem(context, Icons.menu_book, "Academic Management",
              const AcademicManagementScreen()),

          _drawerItem(context, Icons.attach_money, "Fee Management",
              const FeeManagementScreen()),

          _drawerItem(context, Icons.message, "Communication",
              const CommunicationScreen()),

          _drawerItem(context, Icons.bar_chart, "Reports",
              const ReportsScreen()),

          ///  EVENTS & POSTS (FIXED)
          _drawerItem(
            context,
            Icons.event,
            "Events & Posts",
            EventsPostsScreen(userRole: "admin"),
          ),
        ],
      ),
    );
  }

  /// 🔹 REUSABLE DRAWER ITEM
  Widget _drawerItem(
      BuildContext context,
      IconData icon,
      String title,
      Widget screen,
      ) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      hoverColor: Colors.white10,
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
    );
  }
}