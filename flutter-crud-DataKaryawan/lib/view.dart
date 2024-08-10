import 'package:flutter/material.dart';

class ViewEmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> employee =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('View Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${employee['name']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Position: ${employee['position']}'),
            SizedBox(height: 10),
            Text('Department: ${employee['department']}'),
            SizedBox(height: 10),
            Text('Salary: \Rp.${employee['salary']}'),
            SizedBox(height: 10),
            Text('Hire Date: ${employee['hire_date']}'),
          ],
        ),
      ),
    );
  }
}
