import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/view/auth/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/constant/global.dart';
import '../home/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool hidePassword = false;

  getNumber() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'admin';
      password = prefs.getString('password') ?? 'admin';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'User Login'.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Enter E-mail')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: hidePassword,
                controller: passController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_open_rounded),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: hidePassword
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : const Icon(Icons.visibility_off)),
                    hintText: 'Enter password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('login'.toUpperCase()),
                  onPressed: () {
                    if (emailController.text.isNotEmpty ||
                        passController.text.isNotEmpty) {
                      if (email == emailController.text &&
                          password == passController.text) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false);
                      }
                    } else {
                      log('message Error E:${emailController.text}');
                      log('message Error P:${passController.text}');
                    }
                  }),
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 100,
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ),
      ),
    );
  }
}
