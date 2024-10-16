import 'package:flutter/material.dart';
import 'add_edit_task_screen.dart';
import 'task_detail_screen.dart';
import 'settings_screen.dart';
import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            ToggleButtons(
              borderRadius: BorderRadius.circular(20),
              fillColor: Colors.purple[100],
              selectedColor: Colors.white,
              color: Colors.purple,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Daily'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Weekly'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Category'),
                ),
              ],
              isSelected: [true, false, false], // Example selection
              onPressed: (int index) {
                // Handle view switch
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                child: Text(
                  'No tasks yet! Add a new task.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Due: ${task.dueDate.toString()}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: Colors.purple),
                        onPressed: () async {
                          final editedTask = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEditTaskScreen(task: task),
                            ),
                          );
                          if (editedTask != null) {
                            setState(() {
                              tasks[index] = editedTask;
                            });
                          }
                        },
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(
                            task: task,
                            onEdit: (editedTask) async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddEditTaskScreen(task: editedTask),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  final index = tasks.indexOf(editedTask);
                                  tasks[index] = result;
                                });
                              }
                            },
                            onDelete: (taskToDelete) {
                              setState(() {
                                tasks.remove(taskToDelete);
                              });
                              Navigator.pop(context); // Close detail screen
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final newTask =
              await Navigator.pushNamed(context, '/addTask') as Task?;
              if (newTask != null) {
                setState(() {
                  tasks.add(newTask);
                });
              }
            },
            backgroundColor: Colors.purple,
            child: Icon(Icons.add, size: 30),
          ),
          SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () {
              // Help feature
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: Text(
                      'Help',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      'This is a Task Manager app. Use the "+" button to add tasks, tap on a task to view details, and use the edit button to modify existing tasks.',
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'OK',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.blue,
            child: Icon(Icons.help, size: 30),
          ),
        ],
      ),
    );
  }
}
