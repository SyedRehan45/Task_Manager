import 'package:flutter/material.dart';
import '../models/task.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  AddEditTaskScreen({this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _dueDate = DateTime.now();
  TimeOfDay _dueTime = TimeOfDay.now();
  String _priority = 'Low';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _dueTime = TimeOfDay.fromDateTime(widget.task!.dueDate);
      _priority = widget.task!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title Input
            Text('Task Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter task title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Task Description Input
            Text('Task Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter task description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),

            // Due Date and Time
            Text('Due Date & Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                // Date Picker
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _dueDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _dueDate = selectedDate;
                      });
                    }
                  },
                  child: Text('Date: ${_dueDate.toLocal().toString().split(' ')[0]}'),
                ),
                SizedBox(width: 10),
                // Time Picker
                TextButton(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: _dueTime,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _dueTime = selectedTime;
                      });
                    }
                  },
                  child: Text('Time: ${_dueTime.format(context)}'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Priority Dropdown with Icons
            Text('Priority', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _priority,
              onChanged: (String? newValue) {
                setState(() {
                  _priority = newValue!;
                });
              },
              items: <String>['Low', 'Medium', 'High']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(
                        value == 'Low'
                            ? Icons.arrow_downward
                            : value == 'Medium'
                            ? Icons.horizontal_rule
                            : Icons.arrow_upward,
                        color: value == 'Low'
                            ? Colors.green
                            : value == 'Medium'
                            ? Colors.orange
                            : Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Action Buttons (Add/Save, Reset, Cancel)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final task = Task(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dueDate: DateTime(
                        _dueDate.year,
                        _dueDate.month,
                        _dueDate.day,
                        _dueTime.hour,
                        _dueTime.minute,
                      ),
                      priority: _priority,
                    );
                    Navigator.pop(context, task);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: Text(widget.task == null ? 'Add Task' : 'Save Changes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _titleController.clear();
                    _descriptionController.clear();
                    setState(() {
                      _dueDate = DateTime.now();
                      _dueTime = TimeOfDay.now();
                      _priority = 'Low';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
