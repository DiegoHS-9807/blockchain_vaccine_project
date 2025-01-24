// File: lib/pages/doctors_list.dart

import 'package:flutter/material.dart';
import '../data/data.dart';
import '../models/doctor.dart';
import '../widgets/dynamic_background.dart';

class DoctorsListPage extends StatelessWidget {
  const DoctorsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Doctor> doctors = Data.getDoctors();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Doctores'),
      ),
      body: DynamicBackground(
        child: doctors.isEmpty
            ? const Center(
          child: Text('No hay doctores registrados'),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctors[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15.0),
                title: Text(doctor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Especialidad: ${doctor.specialty}'),
                    Text('Contacto: ${doctor.contact}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}