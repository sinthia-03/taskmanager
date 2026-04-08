
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/widgets/appbar.dart';
import 'package:taskmanager/widgets/taskcard.dart';
import '../data/models/task_model.dart';
import '../providers/task_provider.dart';
import '../services/api_caller.dart';
import '../utilits/urls.dart';
class CancleTaskScreen extends StatefulWidget {
  const CancleTaskScreen({super.key});

  @override
  State<CancleTaskScreen> createState() => _CancleTaskScreenState();
}

class _CancleTaskScreenState extends State<CancleTaskScreen> {
  List<TaskModel> TaskList = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){

      final provider =  Provider.of<TaskProvider>(context,listen: false);

      provider.fetachtaskByStatus('cancelled');


    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),
      body: Consumer<TaskProvider>(
        builder: (context,taskProvider,_) {
      return ListView.separated(
        itemCount: taskProvider.cancelledTask.length,
        itemBuilder: (context,index)
        {
          return TaskCard(taskModel: taskProvider.newTask[index],
            cardColor: Colors.red,
            refreshParent: (){
            },
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(
            height: 4,
          );
        },

      );
    }
    )
    );
  }
}

