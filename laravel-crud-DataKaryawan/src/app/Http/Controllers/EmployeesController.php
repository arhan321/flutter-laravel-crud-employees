<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use Illuminate\Http\Request;

class EmployeesController extends Controller
{
    public function index()
    {
        $employees = Employee::all(); 
        return view('karyawan.index', compact('employees')); 
    }

    public function create()
    {
        return view('karyawan.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'position' => 'required|string|max:255',
            'salary' => 'required|numeric',
            'hire_date' => 'nullable|date',
            'department' => 'required|string|max:255',
        ]);

        Employee::create($request->all());

        return redirect()->route('karyawan.index')
                         ->with('success', 'Employee created successfully.');
    }

    public function show(Employee $employee)
    {
        return view('karyawan.show', compact('employee'));
    }

    public function edit(Employee $employee)
    {
        return view('karyawan.edit', compact('employee'));
    }

    public function update(Request $request, Employee $employee)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'position' => 'required|string|max:255',
            'salary' => 'required|numeric',
            'hire_date' => 'nullable|date',
            'department' => 'required|string|max:255',
        ]);

        $employee->update($request->all()); 

        return redirect()->route('karyawan.index')
                         ->with('success', 'Employee updated successfully.');
    }
    
    public function destroy(Employee $employee)
    {
        $employee->delete(); 

        return redirect()->route('karyawan.index')
                         ->with('success', 'Employee deleted successfully.');
    }
}
