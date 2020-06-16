import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO LIST',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter TODO LIST'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedTime;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    //TaskManager.addSampleTasks();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: BodyLayout(),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateTask()));
          setState(() {});
          // CreateTask().build(context);
          // Future<DateTime> selectedDate = showDatePicker(
          //   context: context,
          //   initialDate: DateTime.now(),
          //   firstDate: DateTime(2018),
          //   lastDate: DateTime(2030),
          //   builder: (BuildContext context, Widget child) {
          //     return Theme(
          //       data: ThemeData.dark(),
          //       child: child,
          //     );
          //   },
          // );

          // selectedDate.then((dateTime) {
          //   setState(() {
          //     _selectedTime = dateTime;
          //   });
          //   alert();
          // });
        },
        tooltip: 'Show date picker',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      // bottomNavigationBar: new BottomNavigationBar(),
    );
  }

  void alert() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Date selected'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('This is a alert dialog.'),
                    Text(
                        DateFormat('yyyy-MM-dd – kk:mm').format(_selectedTime)),
                    Text('Press OK button.'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }
}

final List<String> _listTaskName = ["집에서 할 일", "회사에서 할 일", "그룹에서 할 일"];
// final List<DateTime> _listDueDate = [];

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  return ListView.builder(
    itemCount: _listTaskName.length,
    itemBuilder: (context, index) {
      final task = _listTaskName[index];
      return Dismissible(
        key: Key(task),
        onDismissed: (direction) {
          _listTaskName.removeAt(index);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("$task dismissed")));
        },
        background: Container(color: Colors.red),
        child: Card(child: ListTile(title: Text(task))),
      );
      // return Card(
      //     child: ListTile(
      //   title: Text(task),
      // ));
    },
  );
}

class CreateTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _myController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text('Create a new task'),
        ),
        body: Column(children: <Widget>[
          TextField(
            controller: _myController,
            decoration: InputDecoration(labelText: 'Enter a task name'),
            //controller: _take,
            // validator: (_formKey) {
            //   if (_formKey.isEmpty) {
            //     return 'You must enter at least a letter';
            //   }
            // },
          ),
          Row(children: [
            RaisedButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            RaisedButton(
                child: Text('OK'),
                onPressed: () async {
                  _listTaskName.add(_myController.text);
                  print(_listTaskName);

                  Navigator.pop(context);
                }),
          ])
        ]));
  }
}

class TaskManager extends _MyHomePageState {
  // TaskManager() {};

  void addTask(String taskName, dueDate) {
    // void addTask() {
    // debugPrint(taskName);
    _listTaskName.clear();

    // this._listTaskName.add('2');
    _listTaskName.add(taskName);
    // _listDueDate.add(dueDate);
    // if (!dueDate) _listDueDate.add(DateTime.now());
    // else _listDueDate.add(dueDate);

    return;
  }

  void addSampleTasks() {
    // var str1 = "집에서 할 일";
    // addTask(str1, new DateTime.now());
    addTask("회사에서 할 일", DateTime.now());
    // addTask("활동에서 할 일", DateTime.now());
  }
}
