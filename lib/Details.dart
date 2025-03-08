import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    preferences = await SharedPreferences.getInstance();
    String name = preferences.getString('name') ?? "";
    String age = preferences.getString('age') ?? "";
    String blood = preferences.getString('blood') ?? "";
    String symp = preferences.getString('symp') ?? "";
    String imagepath = preferences.getString('imagepath') ?? "";
    setState(() {
      _name.text = name;
      _age.text = age;
      _bloodgroup.text = blood;
      _symp.text = symp;
      _image = File(imagepath);
    });
  }

  File? _image;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _bloodgroup = TextEditingController();
  final TextEditingController _symp = TextEditingController();

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveData() async {
    String name = _name.text;
    String age = _age.text;
    String blood = _bloodgroup.text;
    String symp = _symp.text;
    String imagepath = _image!.path;
    await preferences.setString('name', name);
    await preferences.setString('age', age);
    await preferences.setString('blood', blood);
    await preferences.setString('symp', symp);
    await preferences.setString('imagepath', imagepath);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.red[300],
            title: const Text(
              'Medicine Dispenser',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          drawer: Drawer(
            backgroundColor: Colors.red[300],
            child: ListView(children: [
              DrawerHeader(
                  child: ListView(
                children: [
                  Image.asset(
                    'lib/images/medicine.png',
                    width: 100,
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Medicine Dispenser",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lumanosimo(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                iconColor: Colors.white,
                textColor: Colors.white,
                horizontalTitleGap: 10,
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(Icons.details),
                title: const Text("Patient Details"),
                iconColor: Colors.white,
                textColor: Colors.white,
                horizontalTitleGap: 10,
                onTap: () {
                  Navigator.pushNamed(context, '/details');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("About us"),
                iconColor: Colors.white,
                textColor: Colors.white,
                horizontalTitleGap: 10,
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
            ]),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Patient Details",
                    style: TextStyle(fontSize: 28, color: Colors.red.shade300),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Full name"),
                        contentPadding: EdgeInsets.all(8)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _age,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Age"),
                        contentPadding: EdgeInsets.all(8)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _bloodgroup,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Blood Group"),
                        contentPadding: EdgeInsets.all(8)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _symp,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("symptoms"),
                        contentPadding: EdgeInsets.all(8)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        _getImage();
                      },
                      icon: const Icon(Icons.upload),
                      label: const Text("Upload Report")),
                  const SizedBox(height: 20.0),
                  _image == ''
                      ? const Text('No image selected.')
                      : Image.file(_image!),
                  const SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    return ElevatedButton.icon(
                        onPressed: () {
                          _saveData();
                          const snackbar = SnackBar(
                              showCloseIcon: true,
                              content: Text('Data Saved'),
                              backgroundColor:
                                  Color.fromARGB(255, 243, 177, 172),
                              elevation: 10,
                              behavior: SnackBarBehavior.floating);
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Save Data"));
                  })
                ],
              ),
            ),
          )),
    );
  }
}
