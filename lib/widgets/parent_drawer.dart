import 'package:flutter/material.dart';

import '../screens/parent/parent_dashboard.dart';
import '../screens/parent/class_timetable_screen.dart';
import '../screens/parent/attendance_screen.dart';
import '../screens/parent/marks_screen.dart';
import '../screens/parent/homework_screen.dart';
import '../screens/parent/fee_screen.dart';
import '../screens/parent/notifications_screen.dart';
import '../screens/parent/profile_screen.dart';
import '../screens/parent/events_posts_screen.dart';

class ParentDrawer extends StatelessWidget {
  const ParentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          /// 🔵 HEADER
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1F3C88),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.school, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "School Management",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Parent Portal",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          /// 📊 MENU ITEMS
          _item(
            context,
            icon: Icons.dashboard,
            title: "Dashboard",
            screen: const ParentDashboard(),
          ),

          _item(
            context,
            icon: Icons.access_time,
            title: "Timetable",
            screen: const ParentTimetableScreen(),
          ),

          _item(
            context,
            icon: Icons.check_circle,
            title: "Attendance",
            screen: const AttendanceScreen(),
          ),

          _item(
            context,
            icon: Icons.bar_chart,
            title: "Marks & Results",
            screen: const ParentMarksScreen(),
          ),

          _item(
            context,
            icon: Icons.menu_book,
            title: "Homework",
            screen: const ParentHomeworkScreen(),
          ),

          _item(
            context,
            icon: Icons.payment,
            title: "Fee Management",
            screen: const ParentFeeScreen(),
          ),

          _item(
            context,
            icon: Icons.event,
            title: "Events & Posts",
            screen: const EventsPostsScreen(userRole: "parent"),
          ),

          _item(
            context,
            icon: Icons.notifications,
            title: "Notifications",
            screen: const ParentNotificationsScreen(),
          ),

          _item(
            context,
            icon: Icons.person,
            title: "Student Profile",
            screen: const ParentProfileScreen(),
          ),

          const Divider(),

          /// 🚪 LOGOUT
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              // TODO: Add logout logic
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 REUSABLE ITEM
  Widget _item(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Widget screen,
      }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1F3C88)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context); // close drawer first

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
    );
  }
}