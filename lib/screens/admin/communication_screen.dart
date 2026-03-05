import 'package:flutter/material.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  static const Color primaryColor = Color(0xFF1F3C88);
  static const Color accentBlue = Color(0xFF3A6FF7);
  static const Color backgroundColor = Color(0xFFEAF1FF);
  static const Color cardColor = Colors.white;

  /// ================= DATA =================
  String messageTitle = "";
  String messageContent = "";
  String targetAudience = "All";
  String priority = "Medium";

  List<Map<String, dynamic>> announcements = [
    {
      "id": "1",
      "title": "Parent-Teacher Meeting",
      "content": "Parent-Teacher meeting scheduled for next week. Please confirm your attendance.",
      "priority": "High",
      "date": "2026-02-20",
      "targetAudience": "Parents",
    },
    {
      "id": "2",
      "title": "Holiday Notice",
      "content": "School will remain closed on the upcoming public holiday.",
      "priority": "Medium",
      "date": "2026-02-18",
      "targetAudience": "All",
    },
    {
      "id": "3",
      "title": "Exam Schedule",
      "content": "Mid-term examinations will begin from next month. Please prepare accordingly.",
      "priority": "Medium",
      "date": "2026-02-15",
      "targetAudience": "Students",
    },
    {
      "id": "4",
      "title": "Fee Payment Reminder",
      "content": "This is a reminder to clear all pending fee payments by the end of this month.",
      "priority": "High",
      "date": "2026-02-12",
      "targetAudience": "Parents",
    },
  ];

  /// ================= FUNCTIONS =================
  void handleSendMessage() {
    if (messageTitle.isEmpty || messageContent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Message sent successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      messageTitle = "";
      messageContent = "";
      targetAudience = "All";
      priority = "Medium";
    });
  }

  void quickFill(String title, String content, String audience) {
    setState(() {
      messageTitle = title;
      messageContent = content;
      targetAudience = audience;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Communication"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            const Text(
              "Communication",
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            const Text(
              "Send messages and announcements",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            /// GRID: Send Message + Quick Actions
            Column(
              children: [
                /// Send Announcement Card
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.send, size: 20, color: primaryColor),
                          SizedBox(width: 6),
                          Text("Send Announcement",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _label("Title"),
                      _input(
                        hint: "Enter announcement title",
                        value: messageTitle,
                        onChanged: (v) => setState(() => messageTitle = v),
                      ),
                      const SizedBox(height: 10),
                      _label("Target Audience"),
                      _dropdown(
                        value: targetAudience,
                        items: ["All", "Students", "Teachers", "Parents"],
                        onChanged: (v) => setState(() => targetAudience = v!),
                      ),
                      const SizedBox(height: 10),
                      _label("Message"),
                      _textarea(
                        hint: "Enter your announcement message here...",
                        value: messageContent,
                        onChanged: (v) => setState(() => messageContent = v),
                      ),
                      const SizedBox(height: 10),
                      _label("Priority"),
                      _dropdown(
                        value: priority,
                        items: ["High", "Medium", "Low"],
                        onChanged: (v) => setState(() => priority = v!),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: handleSendMessage,
                          icon: const Icon(Icons.send, size: 16),
                          label: const Text("Send Announcement"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// Quick Actions Card
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Quick Messages",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                      const SizedBox(height: 12),
                      _quickButton(
                        label: "Parent-Teacher Meeting Notice",
                        icon: Icons.calendar_today,
                        onPressed: () => quickFill(
                            "Parent-Teacher Meeting",
                            "Parent-Teacher meeting scheduled for next week. Please confirm your attendance.",
                            "Parents"),
                      ),
                      _quickButton(
                        label: "Holiday Announcement",
                        icon: Icons.notifications,
                        onPressed: () => quickFill(
                            "Holiday Notice",
                            "School will remain closed on the upcoming public holiday.",
                            "All"),
                      ),
                      _quickButton(
                        label: "Exam Schedule Notice",
                        icon: Icons.message,
                        onPressed: () => quickFill(
                            "Exam Schedule",
                            "Mid-term examinations will begin from next month. Please prepare accordingly.",
                            "Students"),
                      ),
                      _quickButton(
                        label: "Fee Payment Reminder",
                        icon: Icons.send,
                        onPressed: () => quickFill(
                            "Fee Payment Reminder",
                            "This is a reminder to clear all pending fee payments by the end of this month.",
                            "Parents"),
                      ),
                      const Divider(height: 20, thickness: 1),
                      const Text("Message Statistics",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      _statRow("Total Sent", "125", Colors.grey),
                      _statRow("This Month", "18", Colors.grey),
                      _statRow("Read Rate", "87%", Colors.green),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Recent Announcements Card
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.notifications, color: primaryColor),
                      SizedBox(width: 6),
                      Text("Recent Announcements",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: announcements.map((a) {
                      Color badgeColor =
                      a["priority"] == "High" ? Colors.red : Colors.grey;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(a["title"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: badgeColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(a["priority"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: badgeColor,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(a["content"],
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black87)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 14),
                                    const SizedBox(width: 2),
                                    Text(a["date"], style: const TextStyle(fontSize: 12))
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.message, size: 14),
                                    const SizedBox(width: 2),
                                    Text(a["targetAudience"],
                                        style: const TextStyle(fontSize: 12))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// ================= UI WIDGETS =================
  Widget _card({required Widget child}) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 2,
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _label(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold));
  }

  Widget _input({
    required String hint,
    required String value,
    required Function(String) onChanged,
  }) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }

  Widget _textarea({
    required String hint,
    required String value,
    required Function(String) onChanged,
  }) {
    return TextField(
      maxLines: 6,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((i) => DropdownMenuItem(value: i, child: Text(i)))
          .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );
  }

  Widget _quickButton(
      {required String label, required IconData icon, required Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 16),
          label: Text(label),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(value,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          )
        ],
      ),
    );
  }
}
