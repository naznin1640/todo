import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/model/user_model.dart';
import 'package:todos/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

 final UserModel _userModel = UserModel();
  final AuthServices _authServices = AuthServices();

  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Future.delayed(Duration(seconds: 3));
      final data = await _authServices.registerUser(_userModel);

      if (data != null) {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      List err = e.toString().split('/');
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(err[1])));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 13, 33),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Form(
                key: _loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login in to your account",
                      style: themedata.textTheme.displayMedium,
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: themedata.textTheme.displaySmall,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter an Email";
                        }
                      },
                      cursorColor: Colors.teal,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: themedata.textTheme.displayMedium,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: themedata.textTheme.displaySmall,
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is mandatory";
                        } else if (value.length < 6) {
                          return "password must contain 6 characters";
                        }
                      },
                      cursorColor: Colors.teal,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: themedata.textTheme.displayMedium,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        UserCredential Userdata = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                        if (!context.mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: themedata.textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account?",
                          style: themedata.textTheme.displaySmall,
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Create Now",
                            style: themedata.textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
