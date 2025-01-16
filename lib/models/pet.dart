import 'package:blockchain_vaccine_project/models/vaccine.dart';

class Pet {
  final String name;
  final String id;
  final String breed;
  final String age;
  final String owner;
  final List<Vaccine> vaccines;

  Pet({
    required this.name,
    required this.id,
    required this.breed,
    required this.age,
    required this.owner,
    List<Vaccine>? vaccines,
  }) : vaccines = vaccines ?? [];

  void addVaccine(Vaccine vaccine) {
    vaccines.add(vaccine);
  }
}