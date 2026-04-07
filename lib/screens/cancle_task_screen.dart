
import 'package:flutter/material.dart';
import 'package:taskmanager/widgets/appbar.dart';
import 'package:taskmanager/widgets/taskcard.dart';
import '../data/models/task_model.dart';
import '../services/api_caller.dart';
import '../utilits/urls.dart';
class CancleTaskScreen extends StatefulWidget {
  const CancleTaskScreen({super.key});

  @override
  State<CancleTaskScreen> createState() => _CancleTaskScreenState();
}

class _CancleTaskScreenState extends State<CancleTaskScreen> {
  List<TaskModel> TaskList = [];

  Future<void>getProgressTask()async {
    final response = await ApiCaller.getRequest(URL:Urls.taskByStatusUrl('Cancelled'));

    List<TaskModel> taskList = [];
    if(response.isSuccess){
      for(Map<String,dynamic>jsonData in response.responseData['data'])
      {
        taskList.add(TaskModel.fromJson(jsonData));
      }
      setState(() {
        TaskList = taskList;
      });

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.responseData['data'])));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),
      body: ListView.separated(
        itemCount: TaskList.length,
        itemBuilder: (context,index)
        {
          return TaskCard(taskModel: TaskList[index],
            cardColor: Colors.red,
            refreshParent: (){},
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(
            height: 4,
          );
        },

      ),
    );
  }
}

