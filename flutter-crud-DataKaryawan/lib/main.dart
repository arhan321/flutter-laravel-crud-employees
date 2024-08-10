import 'package:flutter/material.dart';
import 'conn.dart';
import 'create.dart';
import 'edit.dart';
import 'view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Karyawan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeDataPage(),
      routes: {
        '/create': (context) => CreateEmployeePage(),
        '/edit': (context) => EditEmployeePage(),
        '/view': (context) => ViewEmployeePage(),
      },
    );
  }
}

class EmployeeDataPage extends StatefulWidget {
  @override
  _EmployeeDataPageState createState() => _EmployeeDataPageState();
}

class _EmployeeDataPageState extends State<EmployeeDataPage> {
  late Future<List<Map<String, dynamic>>> futureEmployees;

  @override
  void initState() {
    super.initState();
    futureEmployees = getEmployees();
  }

  Future<List<Map<String, dynamic>>> getEmployees() async {
    var db = DatabaseConnection();
    var conn = await db.getConnection();

    try {
      var results = await conn.query('SELECT * FROM employees');
      List<Map<String, dynamic>> employeeList = [];
      for (var row in results) {
        employeeList.add({
          'id': row[0],
          'name': row[1],
          'position': row[2],
          'salary': row[3],
          'hire_date': row[4],
          'department': row[5],
        });
      }
      return employeeList;
    } finally {
      await conn.close();
    }
  }

  Future<void> _deleteEmployee(int id) async {
    var db = DatabaseConnection();
    var conn = await db.getConnection();

    try {
      await conn.query('DELETE FROM employees WHERE id = ?', [id]);
      setState(() {
        futureEmployees = getEmployees();
      });
    } finally {
      await conn.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Karyawan'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No employees found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var employee = snapshot.data![index];
                return ListTile(
                  title: Text(employee['name']),
                  subtitle: Text(
                      'Position: ${employee['position']}\nDepartment: ${employee['department']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/view',
                            arguments: employee,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/edit',
                            arguments: employee,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          bool? confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Delete Employee'),
                              content: Text(
                                  'Are you sure you want to delete this employee?'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: Text('Delete'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await _deleteEmployee(employee['id']);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        child: Icon(Icons.add),
        tooltip: 'Add Employee',
      ),
    );
  }
}
