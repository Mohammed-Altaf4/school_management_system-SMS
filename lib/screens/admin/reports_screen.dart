import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/admin_drawer.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  static const Color primaryColor = Color(0xFF1F3C88);
  static const Color cardColor = Colors.white;
  static const Color backgroundColor = Color(0xFFEAF6FF);

  String selectedPeriod = "This Month";

  // ================= MOCK DATA =================
  final List<Map<String, dynamic>> attendanceData = [
    {"month": "Sep", "rate": 91},
    {"month": "Oct", "rate": 93},
    {"month": "Nov", "rate": 89},
    {"month": "Dec", "rate": 92},
    {"month": "Jan", "rate": 94},
    {"month": "Feb", "rate": 92.5},
  ];

  final List<Map<String, dynamic>> performanceData = [
    {"class": "10-A", "avgMarks": 85},
    {"class": "10-B", "avgMarks": 82},
    {"class": "9-A", "avgMarks": 88},
    {"class": "9-B", "avgMarks": 80},
    {"class": "8-C", "avgMarks": 83},
  ];

  final List<Map<String, dynamic>> feeCollectionData = [
    {"month": "Sep", "collected": 450000, "pending": 50000},
    {"month": "Oct", "collected": 480000, "pending": 45000},
    {"month": "Nov", "collected": 490000, "pending": 40000},
    {"month": "Dec", "collected": 475000, "pending": 35000},
    {"month": "Jan", "collected": 500000, "pending": 30000},
    {"month": "Feb", "collected": 485000, "pending": 25000},
  ];

  final List<Map<String, dynamic>> reports = [
    {
      "name": "Complete Student Database",
      "description": "All student records with personal and academic information",
      "type": "Excel"
    },
    {
      "name": "Teacher Performance Report",
      "description": "Teacher workload and performance metrics",
      "type": "PDF"
    },
    {
      "name": "Monthly Attendance Summary",
      "description": "Student and staff attendance for the month",
      "type": "Excel"
    },
    {
      "name": "Fee Collection Details",
      "description": "Detailed fee payment records and pending amounts",
      "type": "Excel"
    },
    {
      "name": "Academic Results Report",
      "description": "Exam results and grade distribution",
      "type": "PDF"
    },
    {
      "name": "Class-wise Performance",
      "description": "Subject-wise performance analysis by class",
      "type": "PDF"
    },
  ];

  void handleDownloadReport(String reportName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$reportName downloaded successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reports & Analytics",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              "View and download detailed reports",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER =================

            // ================= DROPDOWN =================
            DropdownButton<String>(
              value: selectedPeriod,
              items: const [
                DropdownMenuItem(value: "This Month", child: Text("This Month")),
                DropdownMenuItem(value: "Last Month", child: Text("Last Month")),
                DropdownMenuItem(value: "This Quarter", child: Text("This Quarter")),
                DropdownMenuItem(value: "This Year", child: Text("This Year")),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedPeriod = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // ================= VERTICAL QUICK REPORT CARDS =================
            Column(
              children: [
                _quickReportCard("Student Report", "Complete student data",
                    Icons.people, Colors.blue, Colors.blue[50]!),
                _quickReportCard("Attendance", "Monthly attendance data",
                    Icons.show_chart, Colors.green, Colors.green[50]!),
                _quickReportCard("Academic", "Exam results & marks",
                    Icons.assignment, Colors.purple, Colors.purple[50]!),
                _quickReportCard("Financial", "Fee collection data",
                    Icons.attach_money, Colors.orange, Colors.orange[50]!),
              ],
            ),

            const SizedBox(height: 24),

            // ================= CHARTS =================
            _chartCard(
              title: "Attendance Trend",
              child: SizedBox(
                height: 250,
                child: LineChart(LineChartData(
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < attendanceData.length) {
                            return Text(
                              attendanceData[index]["month"].toString(),
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text("");
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        attendanceData.length,
                            (index) => FlSpot(
                          index.toDouble(),
                          (attendanceData[index]["rate"] as num).toDouble(),
                        ),
                      ),
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.blue,
                    )
                  ],
                )),
              ),
            ),

            const SizedBox(height: 16),

            _chartCard(
              title: "Average Performance by Class",
              child: SizedBox(
                height: 250,
                child: BarChart(BarChartData(
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < performanceData.length) {
                            return Text(
                              performanceData[index]["class"].toString(),
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text("");
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                  barGroups: List.generate(performanceData.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: (performanceData[index]["avgMarks"] as num).toDouble(),
                          color: Colors.green,
                        ),
                      ],
                    );
                  }),
                )),
              ),
            ),

            const SizedBox(height: 16),

            _chartCard(
              title: "Fee Collection Trend",
              child: SizedBox(
                height: 250,
                child: BarChart(BarChartData(
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < feeCollectionData.length) {
                            return Text(
                              feeCollectionData[index]["month"].toString(),
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text("");
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                  barGroups: List.generate(feeCollectionData.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: (feeCollectionData[index]["collected"] as num).toDouble(),
                          color: Colors.green,
                        ),
                        BarChartRodData(
                          toY: (feeCollectionData[index]["pending"] as num).toDouble(),
                          color: Colors.orange,
                        ),
                      ],
                    );
                  }),
                )),
              ),
            ),

            const SizedBox(height: 24),

            // ================= DETAILED REPORTS =================
            Text(
              "Available Reports",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            const SizedBox(height: 12),
            Column(
              children: reports.map((report) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      child: const Icon(Icons.file_present, color: Colors.blue),
                    ),
                    title: Text(report["name"].toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(report["description"].toString()),
                        Text(
                          "Format: ${report["type"].toString()}",
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton.icon(
                      onPressed: () => handleDownloadReport(report["name"].toString()),
                      icon: const Icon(Icons.download, size: 16),
                      label: const Text("Download"),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickReportCard(String title, String subtitle, IconData icon, Color color, Color bgColor) {
    return GestureDetector(
      onTap: () => handleDownloadReport(title),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: bgColor, child: Icon(icon, color: color)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => handleDownloadReport(title),
              icon: const Icon(Icons.download, size: 16),
              label: const Text("Download"),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(30)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chartCard({required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
