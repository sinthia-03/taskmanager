import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/models/task_status_count.dart';
import 'package:taskmanager/services/api_caller.dart';
import 'package:taskmanager/utilits/urls.dart';
import 'package:taskmanager/widgets/task_count_by_status.dart';

class TaskProvider extends ChangeNotifier{
  List<TaskModel>newTask = [];
  List<TaskModel>progressTask = [];
  List<TaskModel>completedTask = [];
  List<TaskModel>cancelledTask = [];
  List<TaskStatusCountModel> taskStatusCounts = [];
  bool isLoading = false;
  String? errorMessage;


  _setLoading(bool value){
    isLoading = value;
    notifyListeners();
  }

  void setListByStatus(String status, List<TaskModel>tasks){
    switch(status){
      case 'new' :
        newTask = tasks;
      break;
      case 'progress' :
        progressTask = tasks;
      break;
      case 'completed':
        cancelledTask = tasks;
      break;
      case 'cancelled':
        cancelledTask = tasks;

    }
  }


  Future fetachtaskByStatus(String status)async{

    _setLoading(true);
    final response = await ApiCaller.getRequest(URL: Urls.taskByStatusUrl(status));

    if(response.isSuccess){
      List<TaskModel> tasks = [];
      for(Map<String,dynamic>jsonData in response.responseData['data']){
        tasks.add(TaskModel.fromJson(jsonData));
      }
      setListByStatus(status, tasks);

    }else{
      errorMessage = response.responseData['data'];
    }
    _setLoading(false);
  }

  Future fetachtaskCounts()async {

    final response = await ApiCaller.getRequest(URL: Urls.taskCountUrl);

    if(response.isSuccess){
      List<TaskStatusCountModel> count = [];
      for(Map<String,dynamic>jsonData in response.responseData['data']){
        count.add(TaskStatusCountModel.formJson(jsonData));

      }
      taskStatusCounts = count;
    }else{
      errorMessage = response.responseData['data'];
    }
    notifyListeners();
  }
}