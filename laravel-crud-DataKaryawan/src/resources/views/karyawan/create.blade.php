@extends('main')

@section('section')
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <h2>Create New Employee</h2>
            <form action="{{ route('employees.store') }}" method="POST">
                @csrf
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" name="name" class="form-control" id="name" required>
                </div>
                <div class="form-group">
                    <label for="position">Position</label>
                    <input type="text" name="position" class="form-control" id="position" required>
                </div>
                <div class="form-group">
                    <label for="salary">Salary</label>
                    <input type="number" step="0.01" name="salary" class="form-control" id="salary" required>
                </div>
                <div class="form-group">
                    <label for="hire_date">Hire Date</label>
                    <input type="date" name="hire_date" class="form-control" id="hire_date">
                </div>
                <div class="form-group">
                    <label for="department">Department</label>
                    <input type="text" name="department" class="form-control" id="department" required>
                </div>
                <button type="submit" class="btn btn-primary">Create Employee</button>
                <a href="{{ route('employees.index') }}" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>
</div>
@endsection
