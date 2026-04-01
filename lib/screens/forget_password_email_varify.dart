import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/screens/sign_up.dart';
import 'package:taskmanager/utilits/appcolors.dart';
import '../widgets/screen_background.dart';
import 'forget_password_otp_verify.dart';

class ForgetPasswordEmailVarification extends StatefulWidget {
  const ForgetPasswordEmailVarification({super.key});

  @override
  State<ForgetPasswordEmailVarification> createState() => _ForgetPasswordEmailVarificationState();
}

class _ForgetPasswordEmailVarificationState extends State<ForgetPasswordEmailVarification> {
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
                'Your Email Address',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 25),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordOTPVarification()));
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
