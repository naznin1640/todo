import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String? name;
  String?email;
  String?uid;
  String?token;

  getData() async{

    SharedPreferences _pref =await SharedPreferences.getInstance();
   token = await _pref.getString('token');
   name = await _pref.getString('name');
   email = await _pref.getString('email');
   uid = await _pref.getString('uid');

  }
  @override
  void initState() {
   getData();
   var d = Duration(seconds: 5);
   Future.delayed(d, (){
    checkLoginStatus();
   });
    super.initState();
  }

  Future<void> checkLoginStatus() async{
    if(token == null){
      Navigator.pushNamed(context, '/');
    }else{
      Navigator.pushNamed(context, '/login');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("TODO APP", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),),),
    );
  }
}