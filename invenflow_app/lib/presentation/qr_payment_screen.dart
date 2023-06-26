import 'package:flutter/material.dart';

class QRPaymentScreen extends StatelessWidget {
  final double total;

  QRPaymentScreen({required this.total});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nueva Venta'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Escanee para pagar:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              Image.asset('assets/images/qrExample.png'),
              SizedBox(height: 16),
              Text(
                'Total: \$ $total',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  value: 0.66,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
