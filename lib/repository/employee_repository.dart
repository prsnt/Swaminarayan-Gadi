import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data/network/apis/employees/employee_api.dart';
import '../data/network/apis/failure.dart';
import '../models/employee.dart';

class EmployeeRepository {
  EmployeeRepository({required this.employeeApi});

  final EmployeeApi employeeApi;

  Future<Either<Failure, List<Employee>>> fetchEmployeeList() async {
    try {
      final response = await employeeApi.getEmployees();
      if (response.statusCode == 200) {
        final List<Employee> employeeList = [];
        final data = response.data['data'];
        data.forEach((emp) {
          employeeList.add(Employee.fromJson(emp as Map<String, dynamic>));
        });
        return Right(employeeList);
      } else {
        return Left(
            ServerException(message: ErrorHandler.getErrorMessage(response)));
      }
    } on DioError catch (res) {
      return Left(UnknownException(
          message: ErrorHandler.getErrorMessage(res.response as Response)));
    }
  }
}
