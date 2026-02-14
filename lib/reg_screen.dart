import 'package:flutter/material.dart';

class RegApp extends StatefulWidget {
  const RegApp({super.key});

  @override
  State<RegApp> createState() => _RegAppState();
}

class _RegAppState extends State<RegApp> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? selectedGender;
  DateTime? selectedDate;

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool isAdult(DateTime birthDate) {
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age >= 18;
  }

  //Date Picker

  Future<void> pickDate() async {
    DateTime today = DateTime.now();

    DateTime lastAllowedDate = DateTime(
      today.year - 18,
      today.month,
      today.day,
    );

    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: lastAllowedDate,
      initialDate: lastAllowedDate,
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          content: Center(
            child: Text("Select gender", style: TextStyle(color: Colors.red)),
          ),
        ),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          content: Center(
            child: Text(
              "Select date of birth",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
      return;
    }

    if (!isAdult(selectedDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          content: Center(
            child: Text(
              "You must be at least 18 years old",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Center(
          child: Text(
            "Registration Successful",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }

  void resetForm() {
    _formKey.currentState!.reset();
    nameController.clear();
    emailController.clear();
    passwordController.clear();

    setState(() {
      selectedGender = null;
      selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registration Form'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(19),

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                focusNode: nameFocus,
                decoration: InputDecoration(label: Text('Name')),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(emailFocus),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                decoration: InputDecoration(label: Text('Email')),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(passwordFocus),
                validator: (value) {
                  if (value!.isEmpty) return "Enter email";
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                  ).hasMatch(value)) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                focusNode: passwordFocus,
                decoration: InputDecoration(label: Text('Password')),

                textInputAction: TextInputAction.done,

                onFieldSubmitted: (_) => submitForm(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }

                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }

                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return "Must contain 1 uppercase letter";
                  }

                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return "Must contain 1 lowercase letter";
                  }

                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return "Must contain 1 number";
                  }

                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return "Must contain 1 special character";
                  }

                  return null;
                },
              ),
              SizedBox(height: 15),

              DropdownButtonFormField<String>(
                initialValue: selectedGender,
                decoration: InputDecoration(label: Text('Select Gender')),
                items: ["Male", "Female", "Other"]
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (value) => setState(() => selectedGender = value),
                validator: (value) => value == null ? "Select gender" : null,
              ),

              const SizedBox(height: 15),

              ListTile(
                shape: UnderlineInputBorder(),
                title: Text(
                  selectedDate == null
                      ? "Select Date of Birth"
                      : selectedDate.toString().split(" ")[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: pickDate,
              ),
              SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: submitForm,

                      child: const Text(
                        "Submit",

                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: resetForm,
                      child: const Text("Reset"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
