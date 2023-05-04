import 'package:flutter/material.dart';
import 'package:sqflite_course/edit_note_page.dart';
import 'package:sqflite_course/sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();

  List notes = [];
  bool isLoading = true;

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                MaterialButton(
                  child: Text("delete database"),
                  onPressed: () async {
                    await sqlDb.myDeleteDataBase();
                  },
                ),
                ListView.builder(
                  itemCount: notes.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                          title: Text("${notes[i]['title']}"),
                          subtitle: Text("${notes[i]['note']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditNotePage(
                                            note: notes[i]['note'],
                                            title: notes[i]['title'],
                                            color: notes[i]['color'],
                                            id: notes[i]['id'],
                                          )));
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  int response = await sqlDb.deleteData(
                                      "DELETE FROM notes WHERE id = ${notes[i]['id']}");
                                  if (response > 0) {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[i]['id']);
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          )),
                    );
                  },
                )
              ],
            ),
    );
  }
}
