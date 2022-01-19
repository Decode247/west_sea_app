import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:west_sea_app/data/boxes.dart';
import 'package:west_sea_app/data/savedb.dart';
import 'package:intl/intl.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  void dispose() {
    Hive.box('Savedb').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Saved Numbers'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Savedb>>(
        valueListenable: Boxes.getSaveDb().listenable(),
        builder: (context, box, _) {
          final saved = box.values.toList().cast<Savedb>();

          return showSaved(saved);
        },
      ),
    );
  }

  Widget showSaved(List<Savedb> saves) {
    if (saves.isEmpty) {
      return const Center(
        child: Text(
          'No expenses yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: saves.length,
        itemBuilder: (context, index) {
          return buildSaved(context, saves[index]);
        },
      );
    }
  }

  Widget buildSaved(BuildContext context, Savedb savedb) {
    final date = DateFormat.yMMMEd().format(savedb.date);
    final numbers = savedb.numbers;

    return ListTile(
      tileColor: Colors.green,
      title: Text(numbers),
      subtitle: Text(date),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () => deleteSaved(savedb),
        color: Colors.white,
      ),
    );
  }

  void deleteSaved(Savedb savedb) {
    savedb.delete();
  }
}
