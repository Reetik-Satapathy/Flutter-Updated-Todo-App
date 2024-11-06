import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore_for_file: prefer_const_constructors

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List<dynamic> tasks = [];
  TextEditingController task = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "To Do App",
            style: GoogleFonts.itim(color: Colors.white, fontSize: 30),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: task,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter task',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (task.text.isNotEmpty) {
                                setState(() {
                                  tasks.add({
                                    "task": task.text,
                                    "status": false,
                                  });
                                });
                                Navigator.pop(context);
                                task.clear();
                              }
                            },
                            child: Text("Save"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              task.clear();
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text("No active tasks", style: TextStyle(fontSize: 20)))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    title: Text(
                      tasks[index]["task"],
                      style: TextStyle(
                        fontSize: 25,
                        decoration: tasks[index]["status"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: tasks[index]["status"],
                      onChanged: (bool? value) {
                        setState(() {
                          tasks[index]["status"] = value ?? false;
                        });
                      },
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                );
              },
            ),
    );
  }
}
