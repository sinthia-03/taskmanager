import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/widgets/appbar.dart';
import 'package:taskmanager/widgets/taskcard.dart';
import '../data/models/task_model.dart';
import '../providers/task_provider.dart';



class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask((){

      final provider =  Provider.of<TaskProvider>(context,listen: false);

      provider.fetachtaskByStatus('Progress');


    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),
      body: Consumer<TaskProvider>(
        builder: (context,taskProvider,_) {
          return ListView.separated(
              itemCount: taskProvider.progressTask.length,
            itemBuilder: (context,index)
            {
              return TaskCard(taskModel: taskProvider.newTask[index],
                  cardColor: Colors.purple,
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
      ),
    );
  }
}
