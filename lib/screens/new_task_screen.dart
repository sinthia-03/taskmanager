import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/services/api_caller.dart';
import 'package:taskmanager/utilits/urls.dart';
import 'package:taskmanager/widgets/appbar.dart';
import '../data/models/task_status_count.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/taskcard.dart';
import 'add_new_task.dart';
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskModel> _newTaskList = [];
  List<TaskStatusCountModel> taskCountList = [];
  
  Future<void>getAllTaskCount()async {
 final response = await ApiCaller.getRequest(URL:Urls.taskCountUrl);

 List<TaskStatusCountModel> taskCount = [];

if(response.isSuccess){
  for(Map<String,dynamic>jsonData in response.responseData['data'])
    {
      taskCount.add(TaskStatusCountModel.formJson(jsonData));
    }
  setState(() {
    taskCountList = taskCount;

  });

}else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.responseData['data'])));
}

  }
  
  Future<void>getNewTask()async {
    final response = await ApiCaller.getRequest(URL:Urls.taskByStatusUrl('New'));

    List<TaskModel> newtask = [];


    if(response.isSuccess){
      for(Map<String,dynamic>jsonData in response.responseData['data'])
      {
        newtask.add(TaskModel.fromJson(jsonData));
      }
      setState(() {
        _newTaskList= newtask;
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
    getAllTaskCount();
    getNewTask();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:TmAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 90,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskCountList.length,
                  itemBuilder: (context,index){
                    print(taskCountList[index]);
                    return TaskCountByStatus(title:taskCountList[index].status,
                      count: taskCountList[index].count,);
                  },
                  separatorBuilder:(context,index){
                    return SizedBox(width: 4,);
                  },),
            ),

          ),

          Expanded(
            child: ListView.separated(
          itemCount: _newTaskList.length,
          itemBuilder: (context,index){
              return TaskCard(taskModel: _newTaskList[index],
                cardColor:Colors.blue,
                refreshParent: () {
                getAllTaskCount();
                getNewTask();
                },);
            },
                separatorBuilder: (context,inedx){
                  return Divider();
                },
            )
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddNewTask()));
        getAllTaskCount();
        getNewTask();
      },child: Icon(Icons.add),),
    );
  }
}


