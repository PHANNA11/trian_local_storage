import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/constant/global.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController cpassController = TextEditingController();

  bool hidePassword = false;
  Future setUser(String emailValue, String passwordValue) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailValue);
    await prefs.setString('password', passwordValue);
    getUser();
  }

  getUser() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'admin';
      password = prefs.getString('password') ?? 'admin';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Create User'.toUpperCase(),
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
                child: TextFormField(
                  obscureText: hidePassword,
                  controller: cpassController,
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
                      hintText: 'Enter confirm password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Register'.toUpperCase()),
                    onPressed: () async {
                      if (emailController.text.isNotEmpty ||
                          passController.text.isNotEmpty ||
                          cpassController.text.isNotEmpty) {
                        if (passController.text == cpassController.text) {
                          setUser(emailController.text, passController.text)
                              .whenComplete(() {
                            Navigator.pop(context);
                          });
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
                  Navigator.pop(context);
                },
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ),
      ),
    );
  }
}
