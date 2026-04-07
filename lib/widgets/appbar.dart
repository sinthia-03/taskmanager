import 'package:flutter/material.dart';
import 'package:taskmanager/controller/auth_controller.dart';

import '../screens/update_profile_screen.dart';

class TmAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TmAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final profilePic = AuthController.userModel!.photo;
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()));
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                profilePic
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AuthController.userModel!.firstName}'
                    ' ${AuthController.userModel!.lastName}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white),
                ),
                Text(AuthController.userModel!.email,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white
                  ),
                ),

              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: (){},
            icon:Icon(Icons.logout,color: Colors.white,))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}