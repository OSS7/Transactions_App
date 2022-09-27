import 'package:flutter/material.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/widgets/custom_text_field.dart';
import 'package:laravel_api/widgets/resgister_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Card(
          elevation: 20,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Container(
            width: size.width * 0.9,
            height: size.height * 0.7,
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Transaction App ',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.purple, fontSize: 30),
                ),
                CustomTextField(
                  controller:_name,
                  hint: 'Name',
                ),
                CustomTextField(
                  controller: _email,
                  hint: 'Email',
                ),
                CustomTextField(
                  controller: _password,
                  hint: 'Password',
                ),
                RegisterButton(name: _name,email: _email,password: _password),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
