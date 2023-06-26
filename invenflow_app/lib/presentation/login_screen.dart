import 'package:flutter/material.dart';
import 'package:invenflow_app/presentation/register_screen.dart';
import 'package:invenflow_app/presentation/home_screen.dart';
import 'package:invenflow_app/presentation/widgets/error_message.dart';

import '../factory_service.dart';
import '../models/session.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String welcomeMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Image.asset(
                'assets/images/invenflowLogo.png',
                height: 150.0,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Verify that the text fields are completed.
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  showErrorDialog(
                      context, 'Por favor ingresar todos los datos.');
                } else {
                  final factory = FactoryServices().getAuthService();
                  Session session = Session(
                      email: emailController.text,
                      password: passwordController.text);
                  var loginToken = await factory.logIn(session);
                  print(loginToken);
                  if (loginToken != 'false') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  } else {
                    showErrorDialog(
                        context, 'Usuario o contraseña incorrecta.');
                  }
                }
              },
              child: const Text('Iniciar sesión'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: const Text('Registrarse'))
          ],
        ),
      ),
    );
  }
}
