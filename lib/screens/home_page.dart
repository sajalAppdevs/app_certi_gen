import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFilePath;

  Future<void> _pickExcelFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'xls']);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFilePath = result.files.single.path;
        });
        // Optional: Show a snackbar to confirm file selection
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${result.files.single.name}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking file $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AppCertiGen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'How many certificates do you wish to generate?',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Enter the number of certificates'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // Handle saved value
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 50),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       _formKey.currentState!.save();
              //       // Handle successful validation
              //     }
              //   },
              //   child: const Text('Submit'),
              // ),
              const Text('Select excel file for extracting data', style: TextStyle(fontSize: 17)),
              const SizedBox(height: 15),
              GestureDetector(
                  onTap: () {
                    _pickExcelFile();
                  },
                  child: Image.asset('assets/images/excel_sheet.png')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _pickExcelFile();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    const Icon(Icons.file_upload),
                    Text(_selectedFilePath != null
                        ? 'Selected: ${_selectedFilePath!.split('/').last}'
                        : 'Browse Excel File'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
