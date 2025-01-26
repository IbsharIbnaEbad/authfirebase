// import 'package:authfirebase/authservice.dart';
// import 'package:authfirebase/crudservice.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final TextEditingController _noteController = TextEditingController();
//   final CrudService _crudService = CrudService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Home")),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               await AuthService().signout(context);
//             },
//             child: const Text("Sign Out"),
//           ),
//           TextField(
//             controller: _noteController,
//             decoration: InputDecoration(labelText: "Enter Note"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               if (_noteController.text.isNotEmpty) {
//                 await _crudService.createNote(
//                     _noteController.text, _noteController.text);
//                 _noteController.clear();
//               }
//             },
//             child: const Text("Create Note"),
//           ),
//           Expanded(
//             child: StreamBuilder(
//               stream: _crudService.getNotes(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) return CircularProgressIndicator();
//                 final notes = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: notes.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(notes[index]['title']),
//                       subtitle: Text(notes[index]['content']),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () async {
//                           await _crudService.deleteNote(notes[index].id);
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:authfirebase/authservice.dart';
import 'package:authfirebase/crudservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final CrudService _crudService = CrudService();
  String? _selectedNoteId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields for creating/updating notes
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Note Title',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Note Content',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isNotEmpty &&
                    _contentController.text.isNotEmpty) {
                  if (_selectedNoteId == null) {
                    await _crudService.createNote(
                      _titleController.text,
                      _contentController.text,
                    );
                  } else {
                    await _crudService.updateNote(
                      _selectedNoteId!,
                      _titleController.text,
                      _contentController.text,
                    );
                  }
                  _clearFields();
                }
              },
              child: Text(_selectedNoteId == null ? "Create Note" : "Update Note"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            SizedBox(height: 20),
            // Stream to display notes
            Expanded(
              child: StreamBuilder(
                stream: _crudService.getNotes(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  final notes = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.teal[50],
                        child: ListTile(
                          title: Text(
                            notes[index]['title'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(notes[index]['content']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _titleController.text = notes[index]['title'];
                                  _contentController.text = notes[index]['content'];
                                  setState(() {
                                    _selectedNoteId = notes[index].id;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await _crudService.deleteNote(notes[index].id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Clear input fields and reset selected note ID
  void _clearFields() {
    _titleController.clear();
    _contentController.clear();
    setState(() {
      _selectedNoteId = null;
    });
  }
}
