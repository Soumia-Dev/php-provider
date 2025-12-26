import 'package:flutter/material.dart';
import 'package:flutter_php_provider/presentation/provider/user_model_provider.dart';
import 'package:provider/provider.dart';

import '../components/crud.dart';
import '../constant/link_api.dart';
import '../models/note.dart';
import 'add_update_note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  late Future notesFuture;

  @override
  void initState() {
    super.initState();
    final userId = context.read<UserModelProvider>().currentUser['user_id'];
    notesFuture = postRequest(linkGetNotes, {'user_id': '$userId'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUpdateNote(isAddPage: true),
            ),
          );
        },
        shape: CircleBorder(),
        foregroundColor: Colors.black,
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: notesFuture,
        builder: (context, snapshot) {
          // 1️⃣ Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final response = snapshot.data as Map<String, dynamic>;
            // 2️⃣ API fail
            if (response['status'] != 'success') {
              return const Center(child: Text("No notes found"));
            }
            // 3️⃣ Success
            final List notes = response['data'];
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = Note.fromJson(notes[index]);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddUpdateNote(isAddPage: false, note: note),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            linkUploadedImg + note.noteImage,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ListTile(
                            title: Text(note.noteTitle),
                            subtitle: Text(note.noteContent),
                            trailing: IconButton(
                              onPressed: () async {
                                final result = await postRequest(
                                  linkDeleteNote,
                                  {"note_id": note.noteId.toString()},
                                );
                                if (result != null) {
                                  if (result['status'] == 'success') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "note deleted with successful ✅",
                                        ),
                                        duration: Duration(seconds: 4),
                                      ),
                                    );
                                    setState(() {
                                      notesFuture = postRequest(linkGetNotes, {
                                        "user_id": '13',
                                      });
                                    });
                                  }
                                } else if (result['status'] == 'fail') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("something went wrong ❗"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          // 4️⃣ Error
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
