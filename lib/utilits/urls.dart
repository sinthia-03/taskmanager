class Urls {

  static String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static String signUpURL = '$_baseUrl/registration';

  static String loginUrl = '$_baseUrl/login';

  static String addTaskUrl = '$_baseUrl/createTask';

  static String taskCountUrl = '$_baseUrl/taskStatusCount';

  static String taskByStatusUrl(String status) =>
      '$_baseUrl/listTaskByStatus/$status';

  static String deleteTaskUrl(String id) =>
      '$_baseUrl/deleteTask/$id';

  static String changeStatusUrl(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}