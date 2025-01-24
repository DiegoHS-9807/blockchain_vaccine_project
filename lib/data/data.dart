// File: lib/data/data.dart

import '../models/doctor.dart';
import '../models/owner.dart';
import '../models/pet.dart';
import '../models/vaccine.dart';

class Data {
  static final List<Owner> owners = [
    Owner(
      name: 'John Doe',
      id: '123456789',
      address: 'Bogota',
      phone: '123-456-7890',
      email: 'john@gmail.com',
    ),
    Owner(
      name: 'Jane Doe',
      id: '987654321',
      address: 'Bogota',
      phone: '987-654-3210',
      email: 'jane@gmail.com',
    ),
    Owner(
        name: 'Diego Higuera',
        id: '1110588819',
        address: 'Bogota',
        phone: '3214725683',
        email: 'dhiguera09@gmail.com'
    )
  ];

  static final List<Pet> pets = [
    Pet(
      name: 'Rex',
      id: '123456789-01',
      breed: 'Labrador',
      age: '5',
      owner: '123456789',
    ),
    Pet(
      name: 'Bella',
      id: '123456789-02',
      breed: 'Poodle',
      age: '3',
      owner: '123456789',
    ),
  ];

  static final List<Doctor> doctors = [
    Doctor(
      id: '1',
      name: 'Dr. Smith',
      specialty: 'General',
      contact: '123-456-7890',
    ),
    Doctor(
      id: '2',
      name: 'Dr. Johnson',
      specialty: 'Dermatología',
      contact: '123-456-7890',
    ),
  ];

  static void addOwner(Owner owner) {
    owners.add(owner);
  }

  static List<Owner> getOwners() {
    return owners;
  }

  static void addPet(Pet pet) {
    pets.add(pet);
  }

  static List<Pet> getPets() {
    return pets;
  }

  static int getPetCountForOwner(String ownerId) {
    return pets.where((pet) => pet.owner == ownerId).length;
  }

  static Owner? getOwnerById(String ownerId) {
    return owners.firstWhere((owner) => owner.id == ownerId);
  }

  static Pet? getPetById(String petId) {
    return pets.firstWhere((pet) => pet.id == petId);
  }

  static void addVaccineToPet(String petId, Vaccine vaccine) {
    final pet = getPetById(petId);
    if (pet != null) {
      pet.addVaccine(vaccine);
    }
  }

  static List<Vaccine> getVaccinesForPet(String petId) {
    final pet = getPetById(petId);
    return pet?.vaccines ?? [];
  }

  static void addDoctor(Doctor doctor) {
    doctors.add(doctor);
  }

  static List<Doctor> getDoctors() {
    return doctors;
  }

  static generateDoctorId() {
    return doctors.length.toString();
  }
}