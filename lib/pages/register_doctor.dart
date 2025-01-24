// File: lib/pages/register_doctor.dart

import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../data/data.dart';
import '../models/doctor.dart';
import '../widgets/dynamic_background.dart'; // Import the DynamicBackground widget

class RegisterDoctorPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final specialtyController = TextEditingController();
  final contactController = TextEditingController();

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppConstants.labelColor),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppConstants.inputBorderColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppConstants.inputBorderColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  void registerDoctor(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final doctor = Doctor(
        id: Data.generateDoctorId(),
        name: nameController.text,
        specialty: specialtyController.text,
        contact: contactController.text,
      );
      Data.addDoctor(doctor);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Doctor registrado')),
      );
      FocusScope.of(context).unfocus(); // Hide the keyboard
      // Clear the text fields
      nameController.clear();
      specialtyController.clear();
      contactController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son requeridos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Doctor'),
      ),
      body: DynamicBackground( // Wrap the main content with DynamicBackground
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: inputDecoration('Nombre del Doctor'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el nombre del doctor';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: specialtyController,
                        decoration: inputDecoration('Especialidad'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la especialidad';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: contactController,
                        decoration: inputDecoration('Contacto'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el contacto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => registerDoctor(context),
                        child: const Text('Registrar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}