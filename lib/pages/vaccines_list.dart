import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../data/data.dart';

class VaccinesListPage extends StatelessWidget {
  final Pet pet;

  const VaccinesListPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final vaccines = Data.getVaccinesForPet(pet.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Vacunas de ${pet.name}'),
      ),
      body: vaccines.isEmpty
          ? Center(
        child: Text('No hay vacunas registradas para esta mascota'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: vaccines.length,
        itemBuilder: (context, index) {
          final vaccine = vaccines[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15.0),
              title: Text(vaccine.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fecha: ${vaccine.date}'),
                  Text('Veterinario: ${vaccine.vet}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}