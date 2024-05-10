import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Organizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Organizer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to create new note or task page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewTaskPage()),
                );
              },
              child: Text('Buat Catatan Baru'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to task list page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Change button color here
              ),
              child: Text('Lihat Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewTaskPage extends StatefulWidget {
  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  bool _isAddingNote = true;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Catatan Baru'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isAddingNote,
                  onChanged: (value) {
                    setState(() {
                      _isAddingNote = value as bool;
                    });
                  },
                ),
                Text('Tambah Catatan Baru'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: false,
                  groupValue: _isAddingNote,
                  onChanged: (value) {
                    setState(() {
                      _isAddingNote = value as bool;
                    });
                  },
                ),
                Text('Tambah Tugas'),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mata Pelajaran'),
            ),
            SizedBox(height: 16.0),
            if (_isAddingNote)
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Isi Catatan'),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16.0),
                  Text('Tanggal Pembuatan: ${DateTime.now().toString()}'),
                ],
              )
            else
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deskripsi'),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Deadline'),
                          keyboardType: TextInputType.datetime,
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null &&
                                pickedDate != _selectedDate) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                          readOnly: true,
                          controller: TextEditingController(
                            text: _selectedDate != null
                                ? _selectedDate.toString()
                                : '',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null &&
                              pickedDate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          }
                        },
                        icon: Icon(Icons.calendar_today),
                        tooltip: 'Select Date',
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      // Add logic to upload file
                    },
                    child: Text('Unggah File'),
                  ),
                ],
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save task to database or local storage
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool _showNotes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showNotes = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showNotes ? Colors.grey : Colors.blue,
                  ),
                  child: Text('Tugas'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showNotes = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showNotes ? Colors.blue : Colors.grey,
                  ),
                  child: Text('Catatan'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Number of tasks or notes to be displayed
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Add logic to show share options
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Bagikan'),
                          content: Text(
                              'Pilihan untuk membagikan catatan atau tugas $index'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Tutup'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListTile(
                    title: _showNotes
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Catatan $index'),
                              Text(
                                'Tanggal Pembuatan: ${DateTime.now().toString().split(' ')[0]}',
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tugas $index'),
                              Text(
                                'Deadline: ${DateTime.now().add(Duration(days: index)).toString().split(' ')[0]}',
                              ),
                            ],
                          ),
                    subtitle: _showNotes
                        ? Text('Isi catatan $index')
                        : Text('Deskripsi tugas $index'),
                    trailing: Icon(Icons.more_vert),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
