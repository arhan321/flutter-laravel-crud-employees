@extends('main')

@section('section')
<div class="container mt-4">
    <div class="row">
        <div class="col-md-12">
            <h2>Employee List</h2>
            <a href="{{ route('employees.create') }}" class="btn btn-success mb-2">Create New Employee</a>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Salary</th>
                        <th>Hire Date</th>
                        <th>Department</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($employees as $employee)
                        <tr>
                            <td>{{ $employee->id }}</td>
                            <td>{{ $employee->name }}</td>
                            <td>{{ $employee->position }}</td>
                            <td>{{ $employee->salary }}</td>
                            <td>{{ $employee->hire_date }}</td>
                            <td>{{ $employee->department }}</td>
                            <td>
                                <a href="{{ route('employees.show', $employee->id) }}" class="btn btn-info btn-sm">View</a>
                                <a href="{{ route('employees.edit', $employee->id) }}" class="btn btn-warning btn-sm">Edit</a>
                                <form action="{{ route('employees.destroy', $employee->id) }}" method="POST" style="display:inline-block;">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this employee?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection
