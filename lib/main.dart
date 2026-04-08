import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/auth_provider.dart';
import 'package:taskmanager/providers/navigation_provider.dart';
import 'package:taskmanager/providers/task_provider.dart';

import 'app.dart';

void main(){
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>AuthProvider(),
      ),
      ChangeNotifierProvider(create: (_)=>TaskProvider(),
      ),
      ChangeNotifierProvider(create: (_)=>NavigationProvider(),
      )
    ],
    child: TaskManagerApp(),)
      );
}