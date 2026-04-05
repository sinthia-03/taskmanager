import 'package:flutter/material.dart';
import 'package:taskmanager/screens/cancle_task_screen.dart';
import 'package:taskmanager/screens/complied_task_screen.dart';
import 'package:taskmanager/screens/new_task_screen.dart';
import 'package:taskmanager/screens/progress_task_screen.dart';
class MainNaviScreen extends StatefulWidget {
  const MainNaviScreen({super.key});

  @override
  State<MainNaviScreen> createState() => _MainNaviScreenState();
}

class _MainNaviScreenState extends State<MainNaviScreen> {

  int _seletedIndex = 0;

  List _screen = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompliedTaskScreen(),
    CancleTaskScreen(),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_seletedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _seletedIndex,
        onDestinationSelected: (int index){
          _seletedIndex = index;
          setState(() {

          });
        },

        destinations: const [
          NavigationDestination(icon: Icon(Icons.task), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.task_alt_outlined), label: 'Compiled'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel')

        ],),
    );
  }
}
