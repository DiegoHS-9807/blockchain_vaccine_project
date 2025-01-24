// Update the `RegisterVaccinePage` class in `lib/pages/register_vaccine.dart`

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/data.dart';
import '../models/pet.dart';
import '../models/vaccine.dart';
import '../utils/constants.dart';

class RegisterVaccinePage extends StatelessWidget {
  final Pet pet;

  const RegisterVaccinePage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final vaccineNameController = TextEditingController();
    final dateController = TextEditingController();
    final vetController = TextEditingController();
    final List<String> doctorNames = Data.getDoctors().map((doctor) => doctor.name).toList();
    String? selectedDoctor;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      }
    }

    void registerVaccine() {
      final vaccineName = vaccineNameController.text;
      final date = dateController.text;
      final vet = selectedDoctor;
      if (vaccineName.isNotEmpty && date.isNotEmpty && vet != null) {
        final vaccine = Vaccine(name: vaccineName, date: date, vet: vet);
        Data.addVaccineToPet(pet.id, vaccine);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vacuna registrada')),
        );
        FocusScope.of(context).unfocus(); // Hide the keyboard
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todos los campos son requeridos')),
        );
      }
    }

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Vacuna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  Text('ID de la Mascota: ${pet.id}'),
                  const SizedBox(height: 10),
                  Text('Nombre de la Mascota: ${pet.name}'),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: vaccineNameController,
                    decoration: inputDecoration('Nombre de la Vacuna'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre de la vacuna';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dateController,
                        decoration: inputDecoration('Fecha de Administración'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la fecha de administración';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: inputDecoration('Veterinario'),
                    value: selectedDoctor,
                    items: doctorNames.map((String doctor) {
                      return DropdownMenuItem<String>(
                        value: doctor,
                        child: Text(doctor),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedDoctor = newValue;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione un veterinario';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: registerVaccine,
                    child: const Text('Registrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}