import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class InvisuUserManager extends StatefulWidget {
  const InvisuUserManager({Key? key}) : super(key: key);

  @override
  State<InvisuUserManager> createState() => _InvisuUserManagerState();
}

class _InvisuUserManagerState extends State<InvisuUserManager> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  var logger = Logger();
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  String username = "";
  String phoneNumber = "";
  String userStatus = "";
  String _address = "";

  Uint8List? _selectedImage;
  Future<void> _selectImage() async {
    final FilePickerResult? pickedImage =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage.files.single.bytes;
      });
    }
  }

  String _limitUsername(String username) {
    const int maxLength = 20; // Change this to the desired maximum length
    int remainingCharacters = maxLength - username.length - 1;
    if (remainingCharacters < 0) {
      remainingCharacters = 0;
    }
    if (username.length <= maxLength) {
      return '$username ($remainingCharacters)';
    } else {
      return '${username.substring(0, maxLength)}...';
    }
  }

  void _editUsername() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Entrez votre nom et prénom',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextField(
                      autofocus: true,
                      controller: _usernameController,
                      focusNode: unitCodeCtrlFocusNode,
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Bruno Dupont',
                        //labelText: 'Entrez votre nom et prénom',
                        prefixIcon: Icon(CupertinoIcons.person),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            _usernameController.clear();
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text('Annuler'),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text('Enregistrer'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _editAddressInfo() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Entrez votre adresse',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextField(
                      autofocus: true,
                      controller: _addressController,
                      focusNode: unitCodeCtrlFocusNode,
                      onChanged: (value) {
                        setState(() {
                          _address = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: '1 rue de la Paix, 75000 Paris',
                        //labelText: 'Entrer votre adresse',
                        prefixIcon: Icon(CupertinoIcons.building_2_fill),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 16.0),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            _addressController.clear();
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text('Annuler'),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text('Enregistrer'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _editPhoneNumber() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Entrez votre numéro de téléphone',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextField(
                      autofocus: true,
                      controller: _phoneNumberController,
                      focusNode: unitCodeCtrlFocusNode,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: '+33 123457890',
                        //labelText: 'Entrez votre numéro de téléphone',
                        /*border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),*/
                        prefixIcon: Icon(CupertinoIcons.phone),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            _phoneNumberController.clear();
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text('Annuler'),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text('Enregistrer'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profil Utilisateur'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectImage();
                    },
                    child: CircleAvatar(
                      backgroundImage: _selectedImage != null
                          ? MemoryImage(_selectedImage!)
                              as ImageProvider<Object>
                          : const NetworkImage(
                              'https://cdn.pixabay.com/photo/2023/05/19/13/31/bird-8004551_1280.jpg',
                            ), // Display default avatar image
                      radius: 100.0,
                    ),
                  ),

                  const SizedBox(
                      width:
                          10), // Add some spacing between the icon and the image
                  const Icon(
                    CupertinoIcons.pen,
                    color: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.person,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          'Nom et prénom',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      GestureDetector(
                        onTap: _editUsername,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Text(
                            username.isNotEmpty ? username : 'Momodou Ndiaye',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.building_2_fill,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            'Votre Address',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _editAddressInfo,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Text(
                              _address.isNotEmpty
                                  ? _address
                                  : 'Rue Georges Clemenceau, 56100 Lorient Vannes France',
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.phone,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          'Numero Telephone',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _editPhoneNumber,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Text(
                            phoneNumber.isNotEmpty
                                ? phoneNumber
                                : '+33 769755573',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InvisuUserManager(),
  ));
}
