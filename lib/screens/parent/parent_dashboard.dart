import 'package:flutter/material.dart';
import '../../widgets/parent_drawer.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const ParentDrawer(),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        title: const Text("Parent Dashboard",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔷 HEADER
            const Text(
              "Welcome to Parent Dashboard",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            const Text(
              "Track your child's academic progress and school activities",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            /// 🔷 STUDENT CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
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
                      Text("Class 10 • Roll No: 23",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔷 STATS GRID
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.4,
              children: const [

                StatCard(title: "Attendance", value: "92%"),
                StatCard(title: "Average", value: "85%"),
                StatCard(title: "Pending Fees", value: "₹5000"),
                StatCard(title: "Exams", value: "3"),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔷 QUICK STATS
            const Text("Quick Stats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                QuickCard(label: "Homework", value: "5"),
                QuickCard(label: "Assignments", value: "42"),
                QuickCard(label: "Classes", value: "6"),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔷 ANNOUNCEMENTS
            const Text("School Announcements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            const AnnouncementCard(
              title: "Holiday Notice",
              desc: "School closed on April 2",
              date: "2026-04-02",
            ),

            const AnnouncementCard(
              title: "PTM Meeting",
              desc: "Parent meeting on March 30",
              date: "2026-03-30",
            ),
          ],
        ),
      ),
    );
  }
}


/// 📦 STAT CARD
class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(value,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

/// 📦 QUICK CARD
class QuickCard extends StatelessWidget {
  final String label;
  final String value;

  const QuickCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Text(label),
              const SizedBox(height: 6),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

/// 📦 ANNOUNCEMENT
class AnnouncementCard extends StatelessWidget {
  final String title;
  final String desc;
  final String date;

  const AnnouncementCard({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(desc),
        trailing: Text(date),
      ),
    );
  }
}