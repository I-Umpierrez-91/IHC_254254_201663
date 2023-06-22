import 'package:flutter/material.dart';
import 'package:invenflow_app/presentation/register_screen.dart';
import 'package:invenflow_app/factory_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _login() async {
  final email = emailController.text;
  final password = passwordController.text;
  try {
    final token = await dataProvider.loginUser(email, password);
    // Inicio de sesión exitoso, redirigir a otra pantalla
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(token: token),
      ),
    );
  } catch (e) {
    // Error en el inicio de sesión, mostrar mensaje de error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/invenflowLogo.png',
              height: 150.0,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón de inicio de sesión
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
