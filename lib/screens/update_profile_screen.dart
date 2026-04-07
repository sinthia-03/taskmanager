import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/controller/auth_controller.dart';
import 'package:taskmanager/data/models/user_model.dart';
import 'package:taskmanager/widgets/appbar.dart';

import '../utilits/appcolors.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel user = AuthController.userModel!;
    _emailController.text = user.email;
    _firstNameController.text = user.firstName;
    _lastnameController.text = user.lastName;
    _mobileController.text = user.mobile;
  }
Future<void>pickImage()async {
     final XFile ? image =  await _imagePicker.pickImage(source: ImageSource.camera);{
      if(image != null)
        {
          _selectedImage = image;
          setState(() {

          });
        }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Text('Update Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 25,),

            InkWell(
              onTap: pickImage,
              child: Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  children: [
                    Container(
                      child: Text('photo'),
                      height: 50,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Email'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please Enter email';
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                  hintText: 'First name'
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please Enter First Name';
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(
                  hintText: 'Last name'
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please Enter Last Name';
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _mobileController,
              decoration: InputDecoration(
                  hintText: 'Mobile'
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please Enter Phone Number';
                }
                else if(value.length != 11)
                {
                  return 'please enter correct phone number';
                }
                else{
                  return null;
                }
              },
            ),

            SizedBox(height: 10,),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please Enter password';
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
         FilledButton(onPressed: (){
              if(_formkey.currentState!.validate()){

              }
            },
                child: Icon(Icons.arrow_circle_right_outlined)),


          ],
        ),
      ),
    ) ;
  }
}
