import 'package:flutter/material.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterButton extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;
  const RegisterButton({Key? key, required this.name, required this.email, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        SizedBox(
          width: size.width * 0.3,
          height: size.height * 0.035,
          child: MaterialButton(
              color: Colors.purple,
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                authProvider.register(
                    name.text, email.text, password.text);
              }),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/LoginScreen');
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
