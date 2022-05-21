class Employee {

    Employee({this.employeeAge, this.employeeName, this.employeeSalary, this.id, this.profileImage});

    factory Employee.fromJson(Map<String, dynamic> json) {
        return Employee(
            employeeAge: json['employee_age'] as int? ?? 0,
            employeeName: json['employee_name'] as String? ?? '',
            employeeSalary: json['employee_salary'] as int? ?? 0,
            id: json['id'] as int? ?? 0,
            profileImage: json['profile_image'] as String? ?? ''
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['employee_age'] = employeeAge;
        data['employee_name'] = employeeName;
        data['employee_salary'] = employeeSalary;
        data['id'] = id;
        data['profile_image'] = profileImage;
        return data;
    }
    int? employeeAge;
    String? employeeName;
    int? employeeSalary;
    int? id;
    String? profileImage;
}