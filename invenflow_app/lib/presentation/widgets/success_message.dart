import 'package:flutter/material.dart';

import '../products_screen.dart';

class SuccessMessageWidget extends StatelessWidget {
  final String successMessage;

  const SuccessMessageWidget({Key? key, required this.successMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.green[400],
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              successMessage,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showSuccessDialog(
    BuildContext context, String successMessage, String? action) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: SuccessMessageWidget(successMessage: successMessage),
        actions: [
          TextButton(
            onPressed: () {
              if (action == null) {
                Navigator.of(context).pop(); // Dismiss the dialog
              } else if (action == 'toProductScreen') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsScreen()),
                );
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
