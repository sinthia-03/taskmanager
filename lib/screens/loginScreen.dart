import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/auth_provider.dart';
import 'package:taskmanager/screens/forget_password_email_varify.dart';
import 'package:taskmanager/screens/main_navi_screen.dart';
import 'package:taskmanager/screens/sign_up.dart';
import 'package:taskmanager/utilits/appcolors.dart';
import 'package:taskmanager/widgets/showsnackbar.dart';
import '../widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onTabSignUP() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  Future<void> _signIn() async {
    final authProvider = context.read<AuthProvider>();
    final bool success = await authProvider.SignIn(
      _emailController.text,
      _passwordController.text,
    );
    if (success) {
      showSnackbar(context, 'Login success....!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNaviScreen()),
      );
    } else {
      showSnackbar(context, authProvider.errorMwssage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter email';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter password';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(height: 10),
                FilledButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _signIn();
                    }
                  },
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
                SizedBox(height: 35),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ForgetPasswordEmailVarification(),
                            ),
                          );
                        },
                        child: Text(
                          'Forget Password ?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(color: Colors.black87),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
