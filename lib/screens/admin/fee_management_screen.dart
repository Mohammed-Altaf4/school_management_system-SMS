import 'package:flutter/material.dart';

class FeeManagementScreen extends StatefulWidget {
  const FeeManagementScreen({super.key});

  @override
  State<FeeManagementScreen> createState() => _FeeManagementScreenState();
}

class _FeeManagementScreenState extends State<FeeManagementScreen> {
  static const Color primaryColor = Color(0xFF1F3C88);
  static const Color accentBlue = Color(0xFF3A6FF7);
  static const Color backgroundColor = Color(0xFFEAF1FF);
  static const Color cardColor = Colors.white;

  /// ================= DATA =================
  List<Map<String, dynamic>> students = [
    {
      "id": "STU001",
      "name": "Rahul Sharma",
      "class": "10-A",
      "feePending": 5000,
      "phone": "9876543210"
    },
    {
      "id": "STU002",
      "name": "Priya Singh",
      "class": "10-B",
      "feePending": 0,
      "phone": "9876501234"
    },
  ];

  List<Map<String, dynamic>> feeStructure = [
    {
      "class": "10-A",
      "tuitionFee": 15000,
      "examFee": 2000,
      "activityFee": 1000,
    },
    {
      "class": "10-B",
      "tuitionFee": 14000,
      "examFee": 2500,
      "activityFee": 1200,
    },
  ];

  List<Map<String, dynamic>> feePayments = [
    {
      "id": "PAY001",
      "studentId": "STU001",
      "amount": 10000,
      "date": "2026-02-18",
      "receiptNo": "RC001",
      "status": "Paid",
    },
    {
      "id": "PAY002",
      "studentId": "STU002",
      "amount": 12000,
      "date": "2026-02-17",
      "receiptNo": "RC002",
      "status": "Pending",
    },
  ];

  /// ================= CALCULATIONS =================
  int get totalCollected => feePayments.fold(
      0, (sum, payment) => sum + (payment["amount"] as int));

  int get totalPending =>
      students.fold(0, (sum, student) => sum + (student["feePending"] as int));

  int get totalExpected => totalCollected + totalPending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Fee Management"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// =============== HEADER ===============
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Fee Management",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Track and manage student fee payments",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// =============== STATS (VERTICAL) ===============
            _statCard("Total Collected", totalCollected, Colors.green),
            const SizedBox(height: 12),
            _statCard("Total Pending", totalPending, Colors.orange),
            const SizedBox(height: 12),
            _statCard("Total Expected", totalExpected, Colors.blue),
            const SizedBox(height: 20),

            /// =============== FEE STRUCTURE ===============
            _sectionTitle("Fee Structure"),
            _tableCard(
              columns: const [
                "Class",
                "Tuition Fee",
                "Exam Fee",
                "Activity Fee",
                "Total"
              ],
              rows: feeStructure.map((fee) {
                int total = (fee["tuitionFee"] as int) +
                    (fee["examFee"] as int) +
                    (fee["activityFee"] as int);
                return [
                  fee["class"],
                  "₹${fee["tuitionFee"]}",
                  "₹${fee["examFee"]}",
                  "₹${fee["activityFee"]}",
                  "₹$total",
                ];
              }).toList(),
            ),

            /// =============== RECENT PAYMENTS ===============
            _sectionTitle("Recent Payments"),
            _tableCard(
              columns: const [
                "Payment ID",
                "Student",
                "Amount",
                "Date",
                "Receipt No",
                "Status",
                "Action"
              ],
              rows: feePayments.map((payment) {
                var student = students
                    .firstWhere((s) => s["id"] == payment["studentId"]);
                return [
                  payment["id"],
                  "${student["name"]}\n(${payment["studentId"]})",
                  "₹${payment["amount"]}",
                  payment["date"],
                  payment["receiptNo"],
                  _statusBadge(payment["status"]),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Receipt ${payment["receiptNo"]} downloaded"),
                        backgroundColor: Colors.green,
                      ));
                    },
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text("Receipt"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentBlue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                ];
              }).toList(),
            ),

            /// =============== PENDING FEES ===============
            _sectionTitle("Pending Fees"),
            _tableCard(
              columns: const [
                "Student ID",
                "Name",
                "Class",
                "Pending Amount",
                "Contact"
              ],
              rows: students
                  .where((s) => (s["feePending"] as int) > 0)
                  .map((student) => [
                student["id"],
                student["name"],
                student["class"],
                "₹${student["feePending"]}",
                student["phone"],
              ])
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= UI WIDGETS =================
  Widget _statCard(String title, int amount, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Text(
                "₹${amount.toString()}",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.attach_money,
              color: color,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }

  Widget _tableCard({
    required List<String> columns,
    required List<List<dynamic>> rows,
  }) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 20,
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
            rows: rows.map((row) {
              return DataRow(
                  cells: row
                      .map((cell) => cell is Widget
                      ? DataCell(cell)
                      : DataCell(Text(cell.toString())))
                      .toList());
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color = status == "Paid"
        ? Colors.green
        : status == "Pending"
        ? Colors.orange
        : Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
