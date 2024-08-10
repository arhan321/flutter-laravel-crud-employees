<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EmployeesController;

Route::get('/', [EmployeesController::class, 'index'])->name('karyawan.index');
Route::resource('employees', EmployeesController::class);