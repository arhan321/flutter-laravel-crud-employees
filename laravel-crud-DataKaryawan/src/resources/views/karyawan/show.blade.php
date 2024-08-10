@extends('main')

@section('section')
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <h2>Employee Details</h2>
            <div class="card">
                <div class="card-header">
                    <h3>{{ $employee->name }}</h3>
                </div>
                <div class="card-body">
                    <p><strong>Position:</strong> {{ $employee->position }}</p>
                    <p><strong>Salary:</strong> ${{ number_format($employee->salary, 2) }}</p>
                    <p><strong>Hire Date:</strong> {{ $employee->hire_date ?? 'N/A' }}</p>
                    <p><strong>Department:</strong> {{ $employee->department }}</p>
                </div>
                <div class="card-footer">
                    <a href="{{ route('employees.edit', $employee->id) }}" class="btn btn-primary">Edit</a>
                    <form action="{{ route('employees.destroy', $employee->id) }}" method="POST" class="d-inline-block">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this employee?');">Delete</button>
                    </form>
                    <a href="{{ route('employees.index') }}" class="btn btn-secondary">Back to List</a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
