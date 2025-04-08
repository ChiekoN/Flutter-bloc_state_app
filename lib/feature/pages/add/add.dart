import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/router.dart';
import '../../shared/todate_cubit.dart';
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

  void _onSave(BuildContext context) {
    // Add to list
    String? memo = memoController.text;
    context.read<TodateCubit>().addTodate(
      Todate(
        date: selectedDate,
        title: title,
        memo: memo,
      )
    );
    context.go(AppRoutes.home);
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                child: Text(
                  'Add your important day!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                  controller: textController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Row(
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
              ),      
              
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: TextField(
                  maxLength: 2000,
                  maxLines: 5,
                  minLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add some notes (optional)',
                    labelText: 'Memo',
                  ),
                  controller: memoController,
                ),
              ),

              // Save button
              FilledButton(
                onPressed: (selectedDateString.isEmpty || title.isEmpty) ? null : () {_onSave(context);},
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