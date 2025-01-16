import 'package:blockchain_vaccine_project/pages/vaccines_list.dart';
import 'package:flutter/material.dart';
import '../components/menu.dart';
import '../data/data.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';
import 'register_vaccine.dart';

class PetsListPage extends StatelessWidget {
  const PetsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = Data.getPets();

    return Scaffold(
      appBar: AppBar(
        title: const Text(ListPetStrings.petsList),
      ),
      drawer: const Menu(),
      body: DynamicBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: pets.length,
          itemBuilder: (context, index) {
            final pet = pets[index];
            final owner = Data.getOwnerById(pet.owner);
            final ownerName = owner?.name ?? 'Unknown';

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15.0),
                title: Text(pet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${pet.id}'),
                    Text('Raza: ${pet.breed}'),
                    Text('Edad: ${pet.age}'),
                    Text('Dueño: $ownerName'),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VaccinesListPage(pet: pet),
                              ),
                            );
                          },
                          child: const Text('Ver vacunas'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterVaccinePage(pet: pet),
                              ),
                            );
                          },
                          child: const Text('Registrar Vacuna'),
                        ),
                      ],
                    ),

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