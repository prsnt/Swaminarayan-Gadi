part of 'employee_cubit.dart';

@freezed
abstract class EmployeeState with _$EmployeeState {
  const factory EmployeeState.initial() = EmployeeInitial;
  const factory EmployeeState.loading() = EmployeeLoading;
  const factory EmployeeState.error(Failure failure) = EmployeeError;
  const factory EmployeeState.employeeSuccess(List<Employee> employeeDaya) = EmployeeSuccess;

}