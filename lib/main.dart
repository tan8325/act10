import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACT10',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submitForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConfirmationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ACT10')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('name', 'Full Name'),
              _buildTextField('email', 'Email', isEmail: true),
              FormBuilderDateTimePicker(
                name: 'dob',
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                validator: (value) => value == null ? 'Select your DOB' : null,
              ),
              _buildTextField('password', 'Password', isPassword: true),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String name, String label, {bool isEmail = false, bool isPassword = false}) {
    return FormBuilderTextField(
      name: name,
      obscureText: isPassword,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter your $label';
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
        if (isPassword && value.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: const Center(child: Text('Signup Successful!')),
    );
  }
}
