import 'package:appstructure/bloc/employee_cubit.dart';
import 'package:appstructure/data/network/apis/employees/employee_api.dart';
import 'package:appstructure/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeCubit>().fetchEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) => state.maybeWhen(
          orElse: () => {}, error: (failure) => _errorWidget(failure.message)),
      builder: (context, state) => state.when(
          initial: () => _progressWidget(),
          loading: () => _progressWidget(),
          employeeSuccess: (employeeList) => _bodyWidget(employeeList),
          error: (failure) => _errorWidget(failure.message)),
      listenWhen: (previous, current) => current is EmployeeError,
    );
  }

  Widget _bodyWidget(List<Employee> employee) {
    return ListView.builder(
      itemCount: employee.isNotEmpty ? employee.length : 0,
      itemBuilder: (context, index) {
        return ListTile(title: Text(employee[index].employeeName!));
      },
    );
  }

  Widget _errorWidget(String errorData) {
    return Center(child: Text(errorData));
  }

  Widget _progressWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
