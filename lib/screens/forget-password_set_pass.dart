import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/screens/loginScreen.dart';
import 'package:taskmanager/screens/sign_up.dart';
import 'package:taskmanager/utilits/appcolors.dart';
import '../widgets/screen_background.dart';
import 'forget_password_otp_verify.dart';

class ForgetPasswordSetPassword extends StatefulWidget {
  const ForgetPasswordSetPassword({super.key});

  @override
  State<ForgetPasswordSetPassword> createState() => _ForgetPasswordSetPasswordState();
}

class _ForgetPasswordSetPasswordState extends State<ForgetPasswordSetPassword> {
  void _onTabSignUP() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              Text(
                'Set Password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10,),
              Text("Password Should be more than 6 letter and combination of numbers",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey
                  )),
              SizedBox(height: 25),
              TextFormField(
                  obscureText: true,
                  decoration:
                  InputDecoration(hintText: 'Password')),
              SizedBox(height: 10,),
              TextFormField(
                  obscureText: true,
                  decoration:
                  InputDecoration(hintText: ' Conform Password')),
              SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Icon(Icons.arrow_circle_right_outlined),
              ),
              SizedBox(height: 35),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: " have an account?",
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Appcolors.pcolor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _onTabSignUP,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
