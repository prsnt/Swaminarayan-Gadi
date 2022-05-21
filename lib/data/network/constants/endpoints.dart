class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = 'http://dummy.restapiexample.com/api/v1';

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  // booking endpoints
  static const String getEmployees = baseUrl + '/employees';

  static const String deleteEmployees = baseUrl + '/delete';
}