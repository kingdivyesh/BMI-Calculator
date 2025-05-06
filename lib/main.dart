import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      home: const BMICalculatorPage(),
      debugShowCheckedModeBanner: false, // This removes the debug banner
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({super.key});

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double? _bmi;
  String _message = '';

  void _calculateBMI() {
    final double? height = double.tryParse(heightController.text);
    final double? weight = double.tryParse(weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _message = 'Please enter valid height and weight!';
        _bmi = null;
      });
      return;
    }

    final bmi = weight / pow(height / 100, 2); // Convert cm to meters

    String msg;
    if (bmi < 18.5) {
      msg = 'Underweight';
    } else if (bmi < 24.9) {
      msg = 'Normal weight';
    } else if (bmi < 29.9) {
      msg = 'Overweight';
    } else {
      msg = 'Obese';
    }

    setState(() {
      _bmi = bmi;
      _message = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'assets/bmi.png',
              height: 150,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Height (cm)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Calculate BMI',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (_bmi != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your BMI is:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _bmi!.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: $_message',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            if (_bmi == null && _message.isNotEmpty)
              Text(
                _message,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
