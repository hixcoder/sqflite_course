import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sqflite_course/home_page.dart';
import 'package:sqflite_course/sqldb.dart';

class EditNotePage extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  const EditNotePage(
      {super.key,
      required this.note,
      required this.title,
      required this.color,
      required this.id});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    super.initState();

    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(hintText: "note"),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(hintText: "title"),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(hintText: "color"),
                  ),

                  // add button
                  Container(height: 20),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text("Edit Note"),
                    onPressed: () async {
                      int response = await sqlDb.updateData(''' 
                      UPDATE notes SET 
                      note = "${note.text}", 
                      title = "${title.text}", 
                      color = "${color.text}"
                      WHERE id = ${widget.id}
                      ''');
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
