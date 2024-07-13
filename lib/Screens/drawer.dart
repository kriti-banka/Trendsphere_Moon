import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class drawer_page extends StatefulWidget {
  const drawer_page({Key? key}) : super(key: key);

  @override
  State<drawer_page> createState() => _drawer_pageState();
}

class _drawer_pageState extends State<drawer_page> {
  TextEditingController _textFieldController = TextEditingController();
  File? _image;
  bool _canSubmit = false;

  void _resetDialogState() {
    setState(() {
      _image = null;
      _textFieldController.clear();
      _canSubmit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showSubmissionDialog() async {
      await showDialog(

        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.red.shade100,
                title: Text('Submit Your Design'),

                content: Column(

                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 40,),
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            _image = File(pickedFile.path);
                          });
                        }
                      },
                      child: _image == null
                          ? Row(
                        children: [
                          Icon(Icons.upload_outlined, color: Colors.grey.shade600),
                          SizedBox(width: 8.0),
                          Text(
                            'Upload Image',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      )
                          : Column(
                        children: [
                          Image.file(
                            _image!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.upload_outlined, color: Colors.grey.shade600),
                              SizedBox(width: 8.0),
                              Text(
                                'Change Image',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 70.0),
                    TextField(

                      maxLines: null,
                      controller: _textFieldController,

                      onChanged: (value) {
                        setState(() {
                          _canSubmit = value.isNotEmpty && _image != null;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel',style: TextStyle(color: Colors.black),),
                    onPressed: () {
                      _resetDialogState();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Submit',),
                    onPressed: _canSubmit
                        ? () {
                      // Handle submission logic here
                      if (_image != null) {
                        // Upload image logic
                        print('Image uploaded: ${_image!.path}');
                      }
                      // Show thanks popup
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Thanks for submitting!'),
                        ),
                      );
                      Navigator.of(context).pop(); // Close dialog
                    }
                        : null,
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
        body: Container(


          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/drawer.jpg'),
                GestureDetector(
                  onTap: (){
                    _showSubmissionDialog();
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                  Row(

                  children: [
                    SizedBox(width: 15,),
                  Icon(Icons.upload_outlined,color: Colors.grey.shade600,),
                  SizedBox(width: 8.0),
                  Text(
                    'Submit your design',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.grey.shade800),
                  ),],
                  ),
                  SizedBox(height: 5.0),
                        Row(
                          children: [
                            SizedBox(width: 50,),
                            Text(

                              'Get approved and earn',
                              style: TextStyle(fontSize: 12.0,color: Colors.grey.shade600),
                            ),

                          ],
                        )
                        // Add space between rows
                 ],
                ),
                ),
                ],
            ),
          )


        )
    );
  }
}
