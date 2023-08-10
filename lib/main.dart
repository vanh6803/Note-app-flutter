import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'models/Note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Note App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("notes/");
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final Note _note =
      Note(title: "", content: "", createdDate: DateTime.now());

  List<Note> _list = <Note>[];

  void _getData(){
    ref.onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      if (data != null && data is Map) {
        Map<String, dynamic> dataMap = Map<String, dynamic>.from(data);
        List<Note> notesList = [];
        dataMap.forEach((noteId, noteData) {
          notesList.add(Note.fromJson(noteId, Map<String, dynamic>.from(noteData)));
        });
        setState(() {
          _list = notesList;
        });
      }
    });
  }

  void _addNote() {
    String title = _titleController.text;
    String content = _contentController.text;
    DateTime createdDate = DateTime.now();
    Note data = Note(content: content, createdDate: createdDate, title: title);
    ref.push().set(data.toJson());
    _titleController.clear();
    _contentController.clear();
    Navigator.of(context).pop();
  }

  void _dialogInsert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // Background màu trắng cho nội dung của dialog
                  borderRadius: BorderRadius.circular(
                      10.0), // Có thể tùy chỉnh bán kính bo tròn ở đây
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'enter title'),
                        controller: _titleController,
                        onChanged: (text) => {
                          setState(() {
                            _note.title = text;
                          })
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'enter content'),
                        controller: _contentController,
                        maxLines: null,
                        onChanged: (text) => {
                          setState(() {
                            _note.content = text;
                          })
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: _addNote, child: const Text("Save")),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showDialogDelete(String id) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          print("id: $id ");
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Delete"),
            content: const Text("you want to delete this note"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("cancel"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    DatabaseReference noteRef = FirebaseDatabase.instance.ref("notes/$id");
                    noteRef.remove();
                    Navigator.of(context).pop();
                  });
                },
                child: const Text("delete"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: MasonryGridView.builder(shrinkWrap: true,
    scrollDirection: Axis.vertical,
    gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    ),
    itemCount: _list.length,
    itemBuilder: (context, index) {
        return InkWell(
          onLongPress: (){
            _showDialogDelete(_list[index].id ??"");
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _list[index].title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Text(_list[index].content),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(DateFormat.yMd().format(_list[index].createdDate)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
    }),
      floatingActionButton: FloatingActionButton(
        onPressed: _dialogInsert,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
