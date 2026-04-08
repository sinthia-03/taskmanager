import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/task_provider.dart';
import 'package:taskmanager/widgets/appbar.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/taskcard.dart';
import 'add_new_task.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      final provider =  Provider.of<TaskProvider>(context,listen: false);
      provider.fetachtaskCounts();
      provider.fetachtaskByStatus('New');

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:TmAppbar(),
      body: Consumer<TaskProvider>(
        builder: (context,taskprovider,_) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 90,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: taskprovider.taskStatusCounts.length,
                      itemBuilder: (context,index){
                        print(taskprovider.taskStatusCounts[index]);
                        return TaskCountByStatus(title:taskprovider.taskStatusCounts[index].status,
                          count: taskprovider.taskStatusCounts[index].count,);
                      },
                      separatorBuilder:(context,index){
                        return SizedBox(width: 4,);
                      },),
                ),

              ),

              Expanded(
                child: ListView.separated(
              itemCount: taskprovider.newTask.length,
              itemBuilder: (context,index){
                  return TaskCard(taskModel: taskprovider.newTask[index],
                    cardColor:Colors.blue,
                    refreshParent: () {
                    },);
                },
                    separatorBuilder: (context,inedx){
                      return Divider();
                    },
                )
              ),

            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddNewTask()));

      },child: Icon(Icons.add),),
    );
  }
}


