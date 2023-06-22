import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invenflow_app/factory_service.dart';
import 'package:invenflow_app/models/user.dart';
import 'package:invenflow_app/presentation/widgets/error_message.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});
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
      title: const Text('Products'),
    ));
  }
}
