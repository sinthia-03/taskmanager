
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/widgets/appbar.dart';
import 'package:taskmanager/widgets/taskcard.dart';
import '../data/models/task_model.dart';
import '../providers/task_provider.dart';
import '../services/api_caller.dart';
import '../utilits/urls.dart';
class CompliedTaskScreen extends StatefulWidget {
  const CompliedTaskScreen({super.key});

  @override
  State<CompliedTaskScreen> createState() => _CompliedTaskScreenState();
}

class _CompliedTaskScreenState extends State<CompliedTaskScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){

      final provider =  Provider.of<TaskProvider>(context,listen: false);

      provider.fetachtaskByStatus('Completed');


    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),
        body: Consumer<TaskProvider>(
            builder: (context,taskProvider,_) {
              return ListView.separated(
                itemCount: taskProvider.completedTask.length,
                itemBuilder: (context,index)
                {
                  return TaskCard(taskModel: taskProvider.newTask[index],
                    cardColor: Colors.green,
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
