
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/api_response.dart';
import 'package:taskmanager/services/api_caller.dart';
import 'package:taskmanager/utilits/appcolors.dart';
import 'package:taskmanager/utilits/urls.dart';
import '../widgets/screen_background.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  _clearTextField(){
    _emailController.clear();
    _firstNameController.clear();
    _lastnameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  Future <void>_signUp() async{
    Map<String,dynamic>requestBody =
    {
      'email': _emailController.text,
      'firstName': _firstNameController.text,
      'lastName': _lastnameController.text,
      'mobile': _mobileController.text,
      'password': _passwordController.text,

    };


    setState(() {
      isLoading = true;
    });

    final ApiResponse response = await ApiCaller.PostRequest(
      URL: Urls.SignUpURL,
      body: requestBody,
    );

    setState(() {
      isLoading = false;
    });
    if(response.isSuccess)
    {
      _clearTextField();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up success..')));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Somthing wrong...!')));

    }
  }
  void _onTabLogin(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground (child:
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150,),
                Text('Join With Us',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 25,),
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
                isLoading ? Center(child: CircularProgressIndicator()): FilledButton(onPressed: (){
                  if(_formkey.currentState!.validate()){
                    _signUp();
                  }
                },
                    child: Icon(Icons.arrow_circle_right_outlined)),
                SizedBox(height: 35,),
                Center(
                  child: RichText(text: TextSpan(
                      text: " Have a account?",style: TextStyle(color: Colors.black87),
                      children: [
                        TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                color: Appcolors.pcolor,fontWeight: FontWeight.bold),
                            recognizer:TapGestureRecognizer()..onTap = _onTabLogin
                        )
                      ]
                  )
                  ),
                )

              ],
            ),
          ),
        ),
      ),


      ),
    );
  }
}