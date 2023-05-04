import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sqflite_course/home_page.dart';
import 'package:sqflite_course/sqldb.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({super.key});

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
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
                    child: Text("Add Note"),
                    onPressed: () async {
                      int response = await sqlDb.insertData(''' 
                      INSERT INTO notes (`note`, `title`, `color`)
                      VALUES ("${note.text}", "${title.text}", "${color.text}")
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
