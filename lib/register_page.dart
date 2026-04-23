import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _registerKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color.fromARGB(255, 1, 13, 33),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _registerKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Create an Account",
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
                SizedBox(height: 10),
                TextFormField(
                  style: themedata.textTheme.displaySmall,
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is mandatory";
                    }else if(value.length != 6){
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
                TextFormField(
                  controller: _nameController,
                  style: themedata.textTheme.displaySmall,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your name";
                    }
                  },
                  cursorColor: Colors.teal,
                  decoration: InputDecoration(
                    hintText: "Enter name",
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
                    if (_registerKey.currentState!.validate()) {
                      UserCredential userData = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userData.user!.uid)
                            .set({
                              'uid': userData.user!.uid,
                              'email': userData.user!.email,
                              'name': _nameController.text,
                              'createdAt': DateTime.now(),
                              'status': 1,
                            })
                            .then(
                              (value) {
                                if(!context.mounted) return;
                                 Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/home',
                                (route) => false
                              );},
                            );
                      
                    }
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
                        "Create Account",
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
                      "Already have an Account?",
                      style: themedata.textTheme.displaySmall,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: themedata.textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
