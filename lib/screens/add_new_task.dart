import 'package:flutter/material.dart';
import 'package:taskmanager/screens/main_navi_screen.dart';
import 'package:taskmanager/utilits/urls.dart';
import 'package:taskmanager/widgets/appbar.dart';
import 'package:taskmanager/widgets/screen_background.dart';

import '../data/models/api_response.dart';
import '../services/api_caller.dart';
class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descritionController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text('Add new Task', style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Title'
                ),
                validator: (String ? value) {
                  if (value == null || value.isEmpty) {
                    return ' please enter title';
                  }
                  return null;
                },

              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descritionController,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: 'Description'
                ),
                validator: (String ? value) {
                  if (value == null || value.isEmpty) {
                    return ' please enter Description';
                  }
                  return null;
                },

              ),
              FilledButton(onPressed: () {
                if (_formkey.currentState!.validate()) {
                  addNewTask();
                }
              },
                  child: Icon(Icons.arrow_circle_right_outlined)),


            ],
          ),
        ),
      )),
    );
  }
  Future <void>addNewTask() async {
    Map<String, dynamic>requestBody =
    {
      "title": titleController.text,
      "description": descritionController.text,
      "status": "New"
    };
    setState(() {
      isLoading = true;
    });

    final ApiResponse response = await ApiCaller.PostRequest(
      URL: Urls.addTaskUrl,
      body: requestBody,
    );

    setState(() {
      isLoading = false;
    });
    if(response.isSuccess)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Task addeed..')));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainNaviScreen()),(predicted)=>false);

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.responseData['data'])));

    }
  }

}
