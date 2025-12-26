import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_php_provider/presentation/provider/user_model_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/crud.dart';
import '../components/text_field.dart';
import '../constant/link_api.dart';
import '../models/note.dart';
import 'home.dart';

class AddUpdateNote extends StatefulWidget {
  AddUpdateNote({super.key, this.note, required this.isAddPage});
  final bool isAddPage;
  final Note? note;

  @override
  State<AddUpdateNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddUpdateNote> with Crud {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.note?.noteTitle);
    contentController = TextEditingController(text: widget.note?.noteContent);
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File? imageFile;

  Future<void> pickImage(ImageSource source) async {
    final XFile? picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  addNot() async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("please upload an image ❗"),
          duration: Duration(seconds: 4),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });
    var result = widget.isAddPage
        ? await postRequestWithFile(linkAddNote, {
            "user_id":
                '${context.read<UserModelProvider>().currentUser['user_id']}',
            "note_title": titleController.text,
            "note_content": contentController.text,
          }, imageFile!)
        : await postRequest(linkUpdateNote, {
            "note_id": widget.note!.noteId.toString(),
            "note_title": titleController.text,
            "note_content": contentController.text,
          });

    setState(() {
      isLoading = false;
    });
    if (result != null) {
      if (result['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "note ${widget.isAddPage ? "added" : "updated"} with successful ✅",
            ),
            duration: Duration(seconds: 4),
          ),
        );
        Navigator.of(context).pop();
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      } else if (result['status'] == 'fail') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("something went wrong ❗"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          Text("${widget.isAddPage ? "Add" : "Update"} Note"),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFieldBuild(
                  hint: 'title note',
                  myController: titleController,
                ),
                TextFieldBuild(
                  hint: 'content note',
                  myController: contentController,
                  maxLines: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                        children: [
                          if (imageFile != null)
                            Image.file(imageFile!, height: 150),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                },
                                child: Column(
                                  children: [
                                    Icon(Icons.photo, size: 50),

                                    Text("Image From Gallery"),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                                child: Column(
                                  children: [
                                    Icon(Icons.camera_alt, size: 50),
                                    Text("Image From Camera"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade200,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Upload image"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (!isLoading) {
                      if (formKey.currentState!.validate()) {
                        addNot();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade200,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(widget.isAddPage ? "Add" : "Update"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
