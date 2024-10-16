import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final Function(Task) onEdit;
  final Function(Task) onDelete;

  const TaskDetailScreen({
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              onDelete(task);
              Navigator.pop(context); // Close the detail screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${task.title}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Description: ${task.description}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Due Date: ${task.dueDate.toLocal().toString().split(' ')[0]}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Priority: ${task.priority}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            // Checkbox for marking the task as completed
            Row(
              children: [
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    // Handle checkbox state change here if required
                  },
                ),
                Text('Mark as Completed', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onEdit(task);
              },
              child: Text('Edit Task'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
