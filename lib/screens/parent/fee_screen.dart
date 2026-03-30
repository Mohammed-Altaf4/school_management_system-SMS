import 'dart:async';
import 'dart:math';
import '../../widgets/parent_drawer.dart';
import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF2563EB);

class ParentFeeScreen extends StatefulWidget {
  const ParentFeeScreen({super.key});

  @override
  State<ParentFeeScreen> createState() => _ParentFeeScreenState();
}

class _ParentFeeScreenState extends State<ParentFeeScreen> {

  bool showPaymentModal = false;
  String paymentMethod = "card";
  double paymentAmount = 5000;

  bool isProcessing = false;
  bool success = false;
  bool failed = false;

  final List paymentHistory = [
    {
      "date": "2024-01-15",
      "amount": 5000,
      "method": "UPI",
      "status": "Success",
      "id": "UPI2024011512345"
    },
    {
      "date": "2023-12-10",
      "amount": 5000,
      "method": "Net Banking",
      "status": "Success",
      "id": "NB2023121098765"
    },
  ];

  void processPayment() async {
    setState(() {
      isProcessing = true;
      failed = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    bool isSuccess = Random().nextDouble() > 0.05;

    setState(() {
      isProcessing = false;
      success = isSuccess;
      failed = !isSuccess;
    });

    if (isSuccess) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          showPaymentModal = false;
          success = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ParentDrawer(),
      backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: const Color(0xFF1F3C88),
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              "Fee Management",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
        ),
      ),

      body: Stack(
        children: [

          /// MAIN CONTENT
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                /// 🔵 HEADER CARD
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white24,
                        radius: 26,
                        child: Icon(Icons.currency_rupee, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Student Name",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            Text("Class 10 - 2025-26",
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// 📊 CARDS
                Row(
                  children: [

                    /// PAID
                    Expanded(
                      child: _statCard(
                        title: "Total Paid",
                        value: "₹30,000",
                        color: Colors.green,
                        icon: Icons.check_circle,
                      ),
                    ),

                    const SizedBox(width: 10),

                    /// PENDING
                    Expanded(
                      child: _pendingCard(),
                    ),

                    const SizedBox(width: 10),

                    /// DUE DATE
                    Expanded(
                      child: _statCard(
                        title: "Due Date",
                        value: "Feb 28",
                        color: Colors.blue,
                        icon: Icons.calendar_month,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// 🧾 FEE STRUCTURE
                _feeStructure(),

                const SizedBox(height: 20),

                /// 📜 PAYMENT HISTORY
                _paymentHistory(),
              ],
            ),
          ),

          /// 💳 PAYMENT MODAL
          if (showPaymentModal)
            Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text("Make Payment",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 10),

                      /// RADIO BUTTONS
                      Column(
                        children: ["card", "upi", "netbanking"]
                            .map((e) => RadioListTile(
                          title: Text(e.toUpperCase()),
                          value: e,
                          groupValue: paymentMethod,
                          onChanged: (v) {
                            setState(() => paymentMethod = v!);
                          },
                        ))
                            .toList(),
                      ),

                      TextField(
                        decoration:
                        const InputDecoration(labelText: "Amount"),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          paymentAmount = double.tryParse(val) ?? 0;
                        },
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() => showPaymentModal = false);
                              },
                              child: const Text("Cancel"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed:
                              isProcessing ? null : processPayment,
                              child: Text(isProcessing
                                  ? "Processing..."
                                  : "Pay Now"),
                            ),
                          ),
                        ],
                      ),

                      if (success)
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("Payment Successful",
                              style: TextStyle(color: Colors.green)),
                        ),

                      if (failed)
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("Payment Failed",
                              style: TextStyle(color: Colors.red)),
                        ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  /// 🔹 STAT CARD
  Widget _statCard(
      {required String title,
        required String value,
        required Color color,
        required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 5),
          Text(title),
          Text(value,
              style:
              const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// 🔹 PENDING CARD WITH BUTTON
  Widget _pendingCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade100, Colors.orange.shade200],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Icon(Icons.warning, color: Colors.orange),
          const SizedBox(height: 5),
          const Text("Pending"),
          const Text("₹5000",
              style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 5),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              minimumSize: const Size(double.infinity, 30),
            ),
            onPressed: () {
              setState(() => showPaymentModal = true);
            },
            child: const Text("Pay Now", style: TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }

  /// 🔹 FEE STRUCTURE
  Widget _feeStructure() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Tuition Fee"), Text("₹25,000")],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Exam Fee"), Text("₹3,000")],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Activity Fee"), Text("₹2,000")],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("₹30,000",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 PAYMENT HISTORY
  Widget _paymentHistory() {
    return Column(
      children: paymentHistory.map((p) {
        return Card(
          child: ListTile(
            title: Text(p["date"]),
            subtitle: Text("${p["method"]} • ${p["id"]}"),
            trailing: Text("₹${p["amount"]}"),
          ),
        );
      }).toList(),
    );
  }
}