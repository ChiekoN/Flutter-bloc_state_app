import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/router.dart';
import '../../../domain/models/todate.dart';

class NewDatePage extends StatefulWidget {
  const NewDatePage({super.key});

  @override
  State<NewDatePage> createState() => _NewDatePageState();
}

class _NewDatePageState extends State<NewDatePage> {

  DateTime firstDate = DateTime.now().add(Duration(days:1)); // Available date is tomorrow and after.
  DateTime selectedDate = DateTime.now().add(Duration(days:1)); // Initial value
  DateTime lastDate = DateTime(2200); // Max date
  String selectedDateString = '';

  final textController = TextEditingController();
  String title = '';

  final memoController = TextEditingController();
  String? memo;

  @override
  void initState() {
    super.initState();
    textController.addListener(_setLatestTitleValue);
  }

  @override
  void dispose() {
    textController.dispose();
    memoController.dispose();
    super.dispose();
  }

  void _setLatestTitleValue() {
    setState(() {
      title = textController.text;
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    print(picked); //DEV

    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
        selectedDateString = '${selectedDate.toLocal()}'.split(' ')[0];
      });
      print('selectedDateString = $selectedDateString'); // DEV
    }
  }

  
  String?  onSave() {
    // If selectedDateString is empty OR title is empty, 
    //    return null;
    // Else
    //    todateRepo.addTodate(newTodate);
    return null;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: 
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Add your important day!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                controller: textContoroller,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Date'),
                  ),
                  Text(
                    selectedDateString,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              TextField(
                maxLength: 2000,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add some notes (optional)',
                  labelText: 'Memo',
                ),
                controller: memoController,
              ),
              // Save button
              FilledButton(
                onPressed: null,
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(AppRoutes.home);
        },
        child: const Icon(Icons.close),
      ),
    );
  }
}