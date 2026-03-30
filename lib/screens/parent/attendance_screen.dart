import 'package:flutter/material.dart';
import '../../widgets/parent_drawer.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> attendanceRecords = [
      {"month": "February 2026", "present": 8, "absent": 0, "total": 8, "percentage": 100.0},
      {"month": "January 2026", "present": 21, "absent": 1, "total": 22, "percentage": 95.5},
      {"month": "December 2025", "present": 19, "absent": 1, "total": 20, "percentage": 95.0},
      {"month": "November 2025", "present": 20, "absent": 2, "total": 22, "percentage": 90.9},
      {"month": "October 2025", "present": 22, "absent": 1, "total": 23, "percentage": 95.7},
    ];

    const double overallAttendance = 95.4;

    return Scaffold(
      drawer: const ParentDrawer(),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Attendance Record",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),

      backgroundColor: const Color(0xFFEFF6FF),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 SUBTITLE
            const Text(
              "Track your child's attendance history",
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 16),

            /// 🔷 TOP BLUE CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// LEFT
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.calendar_month,
                            color: Colors.white, size: 28),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("John Doe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text("Class 10",
                              style: TextStyle(color: Colors.white70)),
                        ],
                      )
                    ],
                  ),

                  /// RIGHT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text("Overall",
                          style: TextStyle(color: Colors.white70)),
                      Text("95.4%",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔷 3 STATS CARDS
            Row(
              children: [

                Expanded(
                  child: _statBox(
                      icon: Icons.trending_up,
                      color: Colors.green,
                      title: "This Month",
                      value: "100%"),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statBox(
                      icon: Icons.calendar_today,
                      color: Colors.blue,
                      title: "Days Present",
                      value: "8/8"),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statusBox(),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔷 MONTHLY RECORD
            const Text(
              "Monthly Attendance Record",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            /// 📜 LIST
            Column(
              children: attendanceRecords.map((record) {

                final bool good = record["percentage"] >= 95;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),

                  child: Column(
                    children: [

                      /// HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(record["month"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: good ? Colors.green : Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${record["percentage"]}%",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// GRID
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [

                          _miniBox("Present",
                              record["present"].toString(),
                              Colors.green),

                          _miniBox("Absent",
                              record["absent"].toString(),
                              Colors.red),

                          _miniBox("Total",
                              record["total"].toString(),
                              Colors.blue),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  /// 🔹 SMALL BOX
  Widget _miniBox(String label, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color)),
          ],
        ),
      ),
    );
  }

  /// 🔹 STAT CARD
  Widget _statBox({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(title,
                style: const TextStyle(
                    fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 18)),
          ],
        ),
      ),
    );
  }

  /// 🔹 STATUS BOX
  Widget _statusBox() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Icon(Icons.star, color: Colors.purple),
            const SizedBox(height: 6),
            const Text("Overall",
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("Excellent",
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}