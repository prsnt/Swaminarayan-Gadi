import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

import '../data/network/apis/failure.dart';
import '../models/employee.dart';
import '../repository/employee_repository.dart';

part 'employee_cubit.freezed.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(const EmployeeState.initial());

  final EmployeeRepository _employeeRepository =
      GetIt.instance<EmployeeRepository>();

  Future<void> fetchEmployeeList() async {
    emit(const EmployeeState.loading());
    final either = await _employeeRepository.fetchEmployeeList();
    emit(
      either.fold(
        (failure) => EmployeeState.error(failure),
        (employeeList) {
          return EmployeeSuccess(employeeList);
        },
      ),
    );
  }
}
