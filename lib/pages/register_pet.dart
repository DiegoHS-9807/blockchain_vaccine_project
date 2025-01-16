import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';
import '../components/menu.dart';
import '../data/data.dart';
import '../models/pet.dart';

class RegisterPetPage extends StatefulWidget {
  final String? ownerId;

  const RegisterPetPage({super.key, this.ownerId});

  @override
  State<RegisterPetPage> createState() => _RegisterPetPageState();
}

class _RegisterPetPageState extends State<RegisterPetPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  late String _generatedPetId;
  late String _ownerId;

  @override
  void initState() {
    super.initState();
    if (widget.ownerId != null) {
      _ownerId = widget.ownerId!;
      _generatedPetId = _generatePetId(_ownerId);
    }
  }

  String _generatePetId(String ownerId) {
    int petCount = Data.getPetCountForOwner(ownerId);
    return '$ownerId-${(petCount + 1).toString().padLeft(2, '0')}';
  }

  void _registerPet() {
    final name = _nameController.text;
    final breed = _breedController.text;
    final age = _ageController.text;

    if (name.isNotEmpty && breed.isNotEmpty && age.isNotEmpty) {
      Data.addPet(Pet(name: name, id: _generatedPetId, breed: breed, age: age, owner: _ownerId));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(RegisterPetStrings.petRegistered)),
      );
      FocusScope.of(context).unfocus(); // Hide the keyboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(RegisterPetStrings.allFieldsRequired)),
      );
    }
  }

  InputDecoration _inputDecoration(String label) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RegisterPetStrings.registerPet),
      ),
      drawer: const Menu(),
      body: DynamicBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/dogs.png',
                    width: 225,
                    height: 225,
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _nameController,
                          decoration: _inputDecoration(RegisterPetStrings.name),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _breedController,
                          decoration: _inputDecoration(RegisterPetStrings.breed),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _ageController,
                          decoration: _inputDecoration(RegisterPetStrings.age),
                        ),
                        const SizedBox(height: 20),
                        Tooltip(
                          message: RegisterPetStrings.petRegistered,
                          child: ElevatedButton(
                            onPressed: _registerPet,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.buttonBackgroundColor,
                              foregroundColor: AppConstants.buttonForegroundColor,
                              textStyle: AppConstants.buttonTextStyle,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(RegisterPetStrings.register),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}