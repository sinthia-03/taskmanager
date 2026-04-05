import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager/screens/forget-password_set_pass.dart';
import 'package:taskmanager/screens/sign_up.dart';
import 'package:taskmanager/utilits/appcolors.dart';
import '../widgets/screen_background.dart';

class ForgetPasswordOTPVarification extends StatefulWidget {
  const ForgetPasswordOTPVarification({super.key});

  @override
  State<ForgetPasswordOTPVarification> createState() => _ForgetPasswordOTPVarificationState();
}

class _ForgetPasswordOTPVarificationState extends State<ForgetPasswordOTPVarification> {
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
                'Pin Verification',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 25),

              MaterialPinField(
                length: 6,
                obscureText: true,

                onCompleted: (pin) => print('PIN: $pin'),
                onChanged: (value) => print('Changed: $value'),
                theme: MaterialPinTheme(
                    shape: MaterialPinShape.outlined,
                    cellSize: Size(40, 40),
                    borderRadius: BorderRadius.circular(7),
                    completeFillColor: Colors.white,
                    focusedBorderColor: Appcolors.pcolor,
                    filledBorderColor: Colors.transparent

                ),

              ),
              SizedBox(height: 10),
              FilledButton(
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordSetPassword()));
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
                        text: 'Sign in',
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
