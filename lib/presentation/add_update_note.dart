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
  const AddUpdateNote({super.key, this.note, required this.isAddPage});
  final bool isAddPage;
  final Note? note;

  @override
  State<AddUpdateNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddUpdateNote> with Crud {
  late TextEditingController titleController;
  late TextEditingController contentController;
  bool isLoading = false;
  File? imageFile;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController = TextEditingController(text: widget.note?.noteTitle);
    contentController = TextEditingController(text: widget.note?.noteContent);
    super.initState();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
    );
    if (picked != null) {
      Navigator.pop(context);
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  addNot() async {
    if (imageFile == null && widget.isAddPage) {
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
        : imageFile == null
        ? await postRequest(linkUpdateNote, {
            "note_id": widget.note!.noteId.toString(),
            "note_title": titleController.text,
            "note_content": contentController.text,
            "note_image": widget.note!.noteImage,
          })
        : await postRequestWithFile(linkUpdateNote, {
            "note_id": widget.note!.noteId.toString(),
            "note_title": titleController.text,
            "note_content": contentController.text,
            "note_image": widget.note!.noteImage,
          }, imageFile!);

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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          widget.isAddPage ? "Add Note" : "Update Note",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => Container(
                      height: 110,
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _imageOption(
                            icon: Icons.photo,
                            label: "Gallery",
                            onTap: () => pickImage(ImageSource.gallery),
                          ),
                          _imageOption(
                            icon: Icons.camera_alt,
                            label: "Camera",
                            onTap: () => pickImage(ImageSource.camera),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: imageFile != null
                        ? Image.file(imageFile!)
                        : widget.isAddPage
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Tap to add image",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        : Image.network(
                            linkUploadedImg + widget.note!.noteImage,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFieldBuild(hint: "Note title", myController: titleController),
              SizedBox(height: 15),
              TextFieldBuild(
                hint: "Note content",
                myController: contentController,
                maxLines: 6,
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          addNot();
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        widget.isAddPage ? "Add Note" : "Update Note",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _imageOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.green.shade100,
          child: Icon(icon, color: Colors.green, size: 28),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    ),
  );
}
