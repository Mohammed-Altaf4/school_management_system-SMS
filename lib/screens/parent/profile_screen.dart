import 'package:flutter/material.dart';
import '../../widgets/parent_drawer.dart';
class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentInfo = {
      "name": "Rahul Sharma",
      "id": "STU001",
      "rollNo": "23",
      "class": "10",
      "section": "A",
      "dateOfBirth": "Jan 15, 2010",
      "gender": "Male",
      "bloodGroup": "O+",
      "admissionDate": "Apr 1, 2018",
      "email": "rahul.sharma@school.com",
      "phone": "+91 98765 43210",
      "address": "123 Park Street, New Delhi, India - 110001",
      "parentName": "Mr. Rajesh Sharma",
      "parentEmail": "rajesh.sharma@gmail.com",
      "parentPhone": "+91 98765 43211",
      "emergencyContact": "+91 98765 43212",
    };

    final academicInfo = [
      {"label": "Academic Year", "value": "2025-26"},
      {"label": "Admission Number", "value": studentInfo["id"]},
      {"label": "Roll Number", "value": studentInfo["rollNo"]},
      {"label": "Class", "value": studentInfo["class"]},
      {"label": "Section", "value": studentInfo["section"]},
      {"label": "Admission Date", "value": studentInfo["admissionDate"]},
    ];

    final personalInfo = [
      {"label": "Date of Birth", "value": studentInfo["dateOfBirth"], "icon": Icons.calendar_today},
      {"label": "Gender", "value": studentInfo["gender"], "icon": Icons.person},
      {"label": "Blood Group", "value": studentInfo["bloodGroup"], "icon": Icons.favorite},
      {"label": "Email", "value": studentInfo["email"], "icon": Icons.mail},
      {"label": "Phone", "value": studentInfo["phone"], "icon": Icons.phone},
      {"label": "Address", "value": studentInfo["address"], "icon": Icons.location_on},
    ];

    final parentInfo = [
      {"label": "Parent Name", "value": studentInfo["parentName"], "icon": Icons.group},
      {"label": "Parent Email", "value": studentInfo["parentEmail"], "icon": Icons.mail},
      {"label": "Parent Phone", "value": studentInfo["parentPhone"], "icon": Icons.phone},
      {"label": "Emergency Contact", "value": studentInfo["emergencyContact"], "icon": Icons.phone},
    ];

    final subjects = [
      "English",
      "Mathematics",
      "Science",
      "Social Studies",
      "Hindi",
      "Computer Science",
      "Physical Education"
    ];

    return Scaffold(
      drawer: const ParentDrawer(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Student Profile",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// HEADER CARD
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    studentInfo["name"]!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Wrap(
                    spacing: 6,
                    children: [
                      _badge("Class ${studentInfo["class"]} - ${studentInfo["section"]}"),
                      _badge("Roll No: ${studentInfo["rollNo"]}"),
                      _badge("ID: ${studentInfo["id"]}"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Text("Academic Year",
                      style: TextStyle(color: Colors.white70)),
                  const Text("2025-26",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ACADEMIC INFO
            _sectionCard(
              title: "Academic Information",
              icon: Icons.school,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: academicInfo.map((e) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e["label"]!,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(e["value"]!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            /// PERSONAL INFO
            _sectionCard(
              title: "Personal Information",
              icon: Icons.person,
              child: Column(
                children: personalInfo.map((e) {
                  return _infoTile(
                    icon: e["icon"] as IconData,
                    title: e["label"] as String,
                    value: e["value"] as String,
                    color: Colors.blue,
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            /// PARENT INFO
            _sectionCard(
              title: "Parent Information",
              icon: Icons.group,
              child: Column(
                children: parentInfo.map((e) {
                  return _infoTile(
                    icon: e["icon"] as IconData,
                    title: e["label"] as String,
                    value: e["value"] as String,
                    color: Colors.purple,
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            /// SUBJECTS
            _sectionCard(
              title: "Enrolled Subjects",
              icon: Icons.book,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: subjects.map((s) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(s,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            /// INFO BOX
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFF7ED), Color(0xFFFEF3C7)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "To update profile information, contact school administration.",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// BADGE
  static Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  /// SECTION CARD
  static Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Text(title,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        const SizedBox(height: 10),
        child
      ]),
    );
  }

  /// INFO TILE
  static Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}