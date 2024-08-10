@extends('main')

@section('section')
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <h2>Edit Employee</h2>
            <div class="card">
                <div class="card-body">
                    <form action="{{ route('employees.update', $employee->id) }}" method="POST">
                        @csrf
                        @method('PUT')

                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="{{ old('name', $employee->name) }}" required>
                        </div>

                        <div class="form-group">
                            <label for="position">Position</label>
                            <input type="text" class="form-control" id="position" name="position" value="{{ old('position', $employee->position) }}" required>
                        </div>

                        <div class="form-group">
                            <label for="salary">Salary</label>
                            <input type="number" step="0.01" class="form-control" id="salary" name="salary" value="{{ old('salary', $employee->salary) }}" required>
                        </div>

                        <div class="form-group">
                            <label for="hire_date">Hire Date</label>
                            <input type="date" class="form-control" id="hire_date" name="hire_date" value="{{ old('hire_date', $employee->hire_date) }}">
                        </div>

                        <div class="form-group">
                            <label for="department">Department</label>
                            <input type="text" class="form-control" id="department" name="department" value="{{ old('department', $employee->department) }}" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Update Employee</button>
                        <a href="{{ route('employees.index') }}" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
