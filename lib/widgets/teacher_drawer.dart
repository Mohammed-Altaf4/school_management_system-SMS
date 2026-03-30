import 'package:flutter/material.dart';

import '../screens/teacher/teacher_dashboard.dart';
import '../screens/teacher/teacher_attendance_screen.dart';
import '../screens/teacher/teacher_homework_screen.dart';
import '../screens/teacher/teacher_results_screen.dart';
import '../screens/teacher/events_posts_screen.dart';
class TeacherDrawer extends StatelessWidget {
  const TeacherDrawer({super.key});

  final Color primaryColor = const Color(0xFF1E3A8A); // dark blue
  final Color bgColor = const Color(0xFFE6EEF8); // ice blue

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          /// 🔷 HEADER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "Teacher Panel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// 🔹 MENU ITEMS
          _drawerItem(
            context,
            Icons.dashboard,
            "Dashboard",
            const TeacherDashboard(),
          ),

          _drawerItem(
            context,
            Icons.check_circle,
            "Attendance",
            const TeacherAttendanceScreen(),
          ),

          _drawerItem(
            context,
            Icons.book,
            "Homework",
            const TeacherHomeworkScreen(),
          ),

          _drawerItem(
            context,
            Icons.bar_chart,
            "Results",
            const TeacherResultsScreen(),
          ),

          const Divider(),
          ListTile(
            leading: Icon(Icons.event),
            title: Text("Events & Posts"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventsPostsScreen(userRole: "teacher"),
                ),
              );
            },
          ),

          /// 🔴 LOGOUT
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  /// 🔧 COMMON TILE
  Widget _drawerItem(
      BuildContext context,
      IconData icon,
      String title,
      Widget screen,
      ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // close drawer
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
    );
  }
}