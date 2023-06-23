import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invenflow_app/factory_service.dart';
import 'package:invenflow_app/models/user.dart';
import 'package:invenflow_app/presentation/widgets/error_message.dart';
import 'package:invenflow_app/presentation/widgets/success_message.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: companyNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre Empresa',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Reingrese Contraseña',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  // Verify that the text fields are completed.
                  if (emailController.text.isEmpty ||
                      firstNameController.text.isEmpty ||
                      lastNameController.text.isEmpty ||
                      companyNameController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    showErrorDialog(
                        context, 'Por favor ingresar todos los datos.');
                  } else {
                    final factory = FactoryServices().getAuthService();
                    User newUser = User(
                        email: emailController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        companyName: companyNameController.text,
                        password: passwordController.text);
                    var userId = await factory.insertUser(newUser);
                    if (userId == -1) {
                      showErrorDialog(context, 'Error al crear usuario.');
                    } else {
                      showSuccessDialog(context,
                          'Usuario creado de exitosamente.', "toLoginScreen");
                    }
                  }
                },
                child: const Text('+ Registrarme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
