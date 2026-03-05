import 'package:flutter/material.dart';
import '../login_screen.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Color primaryBlue = const Color(0xFF1E3A8A);
  final Color iceBlue = const Color(0xFFEAF2FF);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ================= STAT CARD =================
  Widget statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  // ================= COMMON INFO CARD (SAME HEIGHT) =================
  Widget infoCard(String title, String subtitle, IconData icon) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryBlue),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iceBlue,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: const Text(
          "Parent Dashboard",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,
                color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const LoginScreen(),
                ),
                    (route) => false,
              );
            },
          )
        ],
      ),


      body: Column(
        children: [

          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius:
              const BorderRadius.vertical(
                  bottom: Radius.circular(30)),
            ),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person,
                      size: 40, color: Colors.white),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text("John Doe",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text("Class 10-A • Roll No: 12",
                        style: TextStyle(
                            color: Colors.white70)),
                    Text("Student ID: STD001",
                        style: TextStyle(
                            color: Colors.white70)),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: primaryBlue,
            labelColor: primaryBlue,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(icon: Icon(Icons.dashboard), text: "Overview"),
              Tab(icon: Icon(Icons.schedule), text: "Timetable"),
              Tab(icon: Icon(Icons.calendar_month), text: "Attendance"),
              Tab(icon: Icon(Icons.grade), text: "Marks"),
              Tab(icon: Icon(Icons.book), text: "Homework"),
              Tab(icon: Icon(Icons.currency_rupee), text: "Fees"),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                overviewTab(),
                timetableTab(),
                attendanceTab(),
                marksTab(),
                homeworkTab(),
                feesTab(),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= OVERVIEW =================
  Widget overviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          statCard("Attendance", "95%",
              Icons.calendar_month, Colors.green),
          const SizedBox(height: 15),
          statCard("Recent Average", "88%",
              Icons.grade, Colors.blue),
          const SizedBox(height: 15),
          statCard("Pending Fees", "₹5000",
              Icons.currency_rupee, Colors.orange),

          const SizedBox(height: 25),
          const Text("Upcoming Exams",
              style:
              TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          infoCard("Mid-Term Exams",
              "Feb 25 - Mar 5", Icons.school),
          infoCard("Unit Test",
              "March 20", Icons.event),

          const SizedBox(height: 20),
          const Text("School Announcements",
              style:
              TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          infoCard("Sports Day",
              "March 10", Icons.emoji_events),
          infoCard("Holiday Notice",
              "Feb 28", Icons.campaign),

          const SizedBox(height: 20),
          const Text("Performance Overview",
              style:
              TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                  child: infoCard(
                      "Overall Grade", "A", Icons.star)),
              const SizedBox(width: 10),
              Expanded(
                  child: infoCard(
                      "Class Rank", "3rd", Icons.leaderboard)),
            ],
          ),
          const SizedBox(height: 10),
          infoCard("Assignments Completed",
              "42", Icons.assignment),
        ],
      ),
    );
  }

  // ================= TIMETABLE =================
  Widget timetableTab() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        infoCard("Mathematics",
            "9:00 AM - 10:00 AM", Icons.calculate),
        infoCard("Science",
            "10:00 AM - 11:00 AM", Icons.science),
        infoCard("English",
            "11:30 AM - 12:30 PM", Icons.menu_book),
      ],
    );
  }

  // ================= ATTENDANCE =================
  Widget attendanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 25,
        headingRowColor:
        MaterialStateProperty.all(primaryBlue.withOpacity(0.1)),
        columns: const [
          DataColumn(label: Text("Month")),
          DataColumn(label: Text("Present Days")),
          DataColumn(label: Text("Absent Days")),
          DataColumn(label: Text("Total Days")),
          DataColumn(label: Text("Percentage")),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text("February 2026")),
            DataCell(Text("8")),
            DataCell(Text("0")),
            DataCell(Text("8")),
            DataCell(Text("100%")),
          ]),
          DataRow(cells: [
            DataCell(Text("January 2026")),
            DataCell(Text("21")),
            DataCell(Text("1")),
            DataCell(Text("22")),
            DataCell(Text("95.5%")),
          ]),
          DataRow(cells: [
            DataCell(Text("December 2025")),
            DataCell(Text("19")),
            DataCell(Text("1")),
            DataCell(Text("20")),
            DataCell(Text("95%")),
          ]),
          DataRow(cells: [
            DataCell(Text("November 2025")),
            DataCell(Text("20")),
            DataCell(Text("2")),
            DataCell(Text("22")),
            DataCell(Text("90.9%")),
          ]),
          DataRow(cells: [
            DataCell(Text("October 2025")),
            DataCell(Text("22")),
            DataCell(Text("1")),
            DataCell(Text("23")),
            DataCell(Text("95.7%")),
          ]),
        ],
      ),
    );
  }


  // ================= MARKS =================
  Widget marksTab() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        statCard("Mathematics", "85 / 100",
            Icons.calculate, Colors.blue),
        const SizedBox(height: 15),
        statCard("Science", "78 / 100",
            Icons.science, Colors.green),
      ],
    );
  }

  // ================= HOMEWORK =================
  Widget homeworkTab() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [

        const Text("Pending Homework & Assignments",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 15),

        homeworkDetailCard(
          "Mathematics",
          "Quadratic Equations",
          "Solve exercises 1-10 from Chapter 4",
          "2026-02-10",
          "2026-02-15",
        ),

        homeworkDetailCard(
          "Physics",
          "Newton's Laws",
          "Write notes on all three laws with examples",
          "2026-02-09",
          "2026-02-14",
        ),

        homeworkDetailCard(
          "English",
          "Essay Writing",
          "Write an essay on 'Importance of Education' (500 words)",
          "2026-02-11",
          "2026-02-18",
        ),
      ],
    );
  }

  Widget homeworkDetailCard(String subject,
      String title,
      String description,
      String assigned,
      String due) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subject,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryBlue)),
          const SizedBox(height: 6),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(description),
          const SizedBox(height: 12),

          const Text("Assigned Date",
              style: TextStyle(color: Colors.grey)),
          Text(assigned),

          const SizedBox(height: 8),

          const Text("Due Date",
              style: TextStyle(color: Colors.grey)),
          Text(due),

          const SizedBox(height: 10),
          const Text("Pending Submission",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }


  // ================= FEES =================
  Widget feesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ================= HEADER CARD =================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_balance_wallet,
                        color: primaryBlue),
                    const SizedBox(width: 10),
                    const Text(
                      "Online Fee Payment",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  "View fee details and make secure online payments",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ================= SUMMARY CARDS =================
          statCard("Total Paid", "₹30,000",
              Icons.check_circle, Colors.green),
          const SizedBox(height: 12),
          statCard("Pending Amount", "₹5000",
              Icons.warning, Colors.orange),

          const SizedBox(height: 15),

          // ================= PAY NOW BUTTON =================
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                padding:
                const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text(
                "Pay Now",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: const [
              Icon(Icons.calendar_month,
                  size: 18, color: Colors.grey),
              SizedBox(width: 6),
              Text("Due Date: Feb 28, 2026",
                  style: TextStyle(
                      fontWeight: FontWeight.w500)),
            ],
          ),

          const SizedBox(height: 25),

          // ================= FEE STRUCTURE =================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Icon(Icons.receipt_long,
                        color: primaryBlue),
                    const SizedBox(width: 10),
                    const Text(
                      "Fee Structure - Class 10-A",
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                feeRow("Tuition Fee", "₹25,000"),
                const Divider(),
                feeRow("Exam Fee", "₹3,000"),
                const Divider(),
                feeRow("Activity Fee", "₹2,000"),
                const Divider(),
                feeRow("Total Annual Fee", "₹30,000",
                    isBold: true),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ================= PAYMENT HISTORY =================
          const Text(
            "Payment History",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),

          const SizedBox(height: 10),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
              MaterialStateProperty.all(
                  primaryBlue.withOpacity(0.08)),
              columnSpacing: 25,
              columns: const [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Amount")),
                DataColumn(label: Text("Method")),
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Transaction ID")),
                DataColumn(label: Text("Receipt")),
              ],
              rows: [
                paymentRow("2024-01-15", "₹5000",
                    "UPI", "Success",
                    "UPI2024011512345"),
                paymentRow("2023-12-10", "₹5000",
                    "Net Banking", "Success",
                    "NB2023121098765"),
                paymentRow("2023-11-08", "₹5000",
                    "Credit Card", "Success",
                    "CC2023110854321"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget feeRow(String title, String amount,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight:
                isBold ? FontWeight.bold : FontWeight.normal)),
        Text(amount,
            style: TextStyle(
                fontWeight:
                isBold ? FontWeight.bold : FontWeight.w500)),
      ],
    );
  }

  DataRow paymentRow(String date, String amount,
      String method, String status, String id) {
    return DataRow(cells: [
      DataCell(Text(date)),
      DataCell(Text(amount)),
      DataCell(Text(method)),
      DataCell(Text(status,
          style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600))),
      DataCell(Text(id)),
      const DataCell(Text("Download",
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500))),
    ]);
  }
}
