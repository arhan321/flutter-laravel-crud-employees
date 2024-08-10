import 'package:flutter/material.dart';
import 'conn.dart';

class CreateEmployeePage extends StatefulWidget {
  @override
  _CreateEmployeePageState createState() => _CreateEmployeePageState();
}

class _CreateEmployeePageState extends State<CreateEmployeePage> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _salaryController = TextEditingController();
  final _departmentController = TextEditingController();
  DateTime? _hireDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _hireDate) {
      setState(() {
        _hireDate = picked;
      });
    }
  }

  Future<void> _addEmployee() async {
    var db = DatabaseConnection();
    var conn = await db.getConnection();

    try {
      await conn.query(
        'INSERT INTO employees (name, position, salary, hire_date, department) VALUES (?, ?, ?, ?, ?)',
        [
          _nameController.text,
          _positionController.text,
          double.tryParse(_salaryController.text) ?? 0.0,
          _hireDate?.toIso8601String(),
          _departmentController.text,
        ],
      );
      Navigator.pop(context);
    } finally {
      await conn.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: _hireDate != null
                        ? _hireDate!.toLocal().toString().split(' ')[0]
                        : '',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Hire Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _departmentController,
              decoration: InputDecoration(labelText: 'Department'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addEmployee,
              child: Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
