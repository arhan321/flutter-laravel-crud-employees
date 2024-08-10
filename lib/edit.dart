import 'package:flutter/material.dart';
import 'conn.dart';

class EditEmployeePage extends StatefulWidget {
  @override
  _EditEmployeePageState createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _salaryController = TextEditingController();
  final _hireDateController = TextEditingController();
  final _departmentController = TextEditingController();
  int? _employeeId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> employee =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _employeeId = employee['id'];
    _nameController.text = employee['name'];
    _positionController.text = employee['position'];
    _salaryController.text = employee['salary'].toString();

    DateTime hireDate = employee['hire_date'];
    _hireDateController.text = hireDate.toIso8601String().substring(0, 10);

    _departmentController.text = employee['department'];
  }

  Future<void> _updateEmployee() async {
    var db = DatabaseConnection();
    var conn = await db.getConnection();

    try {
      await conn.query(
        'UPDATE employees SET name = ?, position = ?, salary = ?, hire_date = ?, department = ? WHERE id = ?',
        [
          _nameController.text,
          _positionController.text,
          double.parse(_salaryController.text),
          _hireDateController.text,
          _departmentController.text,
          _employeeId,
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
        title: Text('Edit Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _hireDateController,
              decoration: InputDecoration(labelText: 'Hire Date (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _departmentController,
              decoration: InputDecoration(labelText: 'Department'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateEmployee,
              child: Text('Update Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
