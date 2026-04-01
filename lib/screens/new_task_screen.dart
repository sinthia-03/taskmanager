import 'package:flutter/material.dart';
import 'package:taskmanager/widgets/appbar.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/taskcard.dart';
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:Tmappbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                return TaskCountByStatus(title: 'New', count: 10,);
              },
                  separatorBuilder:(context,index){
                return SizedBox(width: 4,);
                  }, itemCount: 4),
            ),

          ),

          Expanded(
            child: ListView.separated(itemBuilder: (context,index){
              return TaskCard();
            },
                separatorBuilder: (context,inedx){
              return Divider();
                },
                itemCount: 10),
          ),

        ],
      ),
      );
  }
}


