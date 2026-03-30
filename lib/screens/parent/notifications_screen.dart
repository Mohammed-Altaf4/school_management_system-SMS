import 'package:flutter/material.dart';
import '../../widgets/parent_drawer.dart';
class ParentNotificationsScreen extends StatelessWidget {
  const ParentNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allNotifications = [
      {
        "id": "1",
        "title": "School Holiday",
        "content": "School will remain closed tomorrow.",
        "date": "Mar 15, 2026",
        "priority": "Low",
        "type": "General"
      },
      {
        "id": "N001",
        "title": "Assignment Reminder",
        "content":
        "Science project submission due tomorrow. Please ensure completion.",
        "date": "Mar 12, 2026",
        "priority": "High",
        "type": "Assignment",
      },
      {
        "id": "N002",
        "title": "Fee Payment Reminder",
        "content":
        "Quarterly fees due on Feb 28, 2026. Pay online in Fee section.",
        "date": "Mar 10, 2026",
        "priority": "Medium",
        "type": "Fees",
      },
      {
        "id": "N003",
        "title": "Attendance Alert",
        "content":
        "Your child was absent on March 8. Update leave if needed.",
        "date": "Mar 9, 2026",
        "priority": "High",
        "type": "Attendance",
      },
      {
        "id": "N004",
        "title": "Exam Schedule Released",
        "content":
        "Mid-term schedule published. Check academic section.",
        "date": "Mar 5, 2026",
        "priority": "High",
        "type": "Exam",
      },
    ];

    return Scaffold(
      drawer: const ParentDrawer(),
      backgroundColor: Colors.grey[100],

      /// APPBAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// HEADER CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("All Notifications",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "You have ${allNotifications.length} notifications",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// STATS ROW
            Row(
              children: [
                _statCard("High Priority", "3", Colors.red, Icons.error),
                const SizedBox(width: 10),
                _statCard("Medium Priority", "2", Colors.orange, Icons.info),
                const SizedBox(width: 10),
                _statCard("Total Unread",
                    "${allNotifications.length}", Colors.blue, Icons.notifications),
              ],
            ),

            const SizedBox(height: 20),

            /// NOTIFICATIONS LIST
            _card(
              title: "Recent Notifications",
              child: Column(
                children: allNotifications.map((notification) {
                  IconData icon = _getIcon(notification["type"]);
                  Color color = _getPriorityColor(notification["priority"]);
                  Color bgColor = _getBgColor(notification["priority"]);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border(
                        left: BorderSide(width: 5, color: color),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ICON
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: color, size: 20),
                        ),

                        const SizedBox(width: 12),

                        /// CONTENT
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// TITLE + BADGE
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      notification["title"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  _badge(notification["priority"], color)
                                ],
                              ),

                              const SizedBox(height: 4),

                              /// TYPE
                              _outlineBadge(notification["type"]),

                              const SizedBox(height: 8),

                              /// CONTENT
                              Text(notification["content"],
                                  style:
                                  const TextStyle(color: Colors.black87)),

                              const SizedBox(height: 8),

                              /// DATE
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 12),
                                  const SizedBox(width: 5),
                                  Text(notification["date"],
                                      style: const TextStyle(fontSize: 12))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            /// SETTINGS CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEFF6FF), Color(0xFFF3E8FF)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "To manage notification preferences, contact school administration.",
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// ICON LOGIC
  static IconData _getIcon(String type) {
    switch (type) {
      case "Assignment":
        return Icons.warning;
      case "Fees":
        return Icons.info;
      case "Attendance":
        return Icons.warning;
      case "Exam":
        return Icons.notifications;
      default:
        return Icons.check_circle;
    }
  }

  /// COLORS
  static Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  static Color _getBgColor(String priority) {
    switch (priority) {
      case "High":
        return Colors.red.shade50;
      case "Medium":
        return Colors.orange.shade50;
      default:
        return Colors.blue.shade50;
    }
  }

  /// CARD WRAPPER
  static Widget _card({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child
        ],
      ),
    );
  }

  /// BADGE
  static Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 10)),
    );
  }

  static Widget _outlineBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: const TextStyle(fontSize: 10)),
    );
  }

  /// STATS CARD
  static Widget _statCard(
      String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 5),
            Text(title,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ],
        ),
      ),
    );
  }
}