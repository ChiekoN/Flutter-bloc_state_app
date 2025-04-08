import 'package:uuid/uuid.dart';

import '../../domain/models/todate.dart';
import '../../domain/repository/todate_repo.dart';
import '../models/data_todate.dart';

class TodateRepoData implements TodateRepo {

  // Initial data for a sample
  List<Todate> todates = [
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2024, 12, 27),
      title: 'Camping in Margaret River',
      memo: 'Conto campground, 2 nights',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 2, 25),
      title: 'Perth business meeting',
      memo: 'At Firaobo 6:00pm',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 7, 15),
      title: 'Emma\'s wedding',
      memo: 'At Crown Hall at 11:00am',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 10, 3),
      title: 'Holiday in Bangkok',
      memo: 'Return on 10/8',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 11, 7),
      title: 'My birthday',
      memo: 'No plan yet',
    ),
    Todate(
      id: const Uuid().v4(),
      date: DateTime(2025, 12, 15),
      title: 'Christmas event',
      memo: 'No plan yet',
    ),
  ];

  @override
  List<Todate> getTodates() {
    sortTodates();
    return todates;
  }

  @override
  void addTodate(Todate newTodate) {
    newTodate.date = newTodate.dateOnly; // Set the Time in DateTime to 00:00:00 forcibly.
    todates.add(newTodate);
    //sortTodates();
  }


  @override
  void updateTodate(Todate todate) {
    
    int index = todates.indexWhere(
      (d) => d.id == todate.id
    );

    todates[index].date = todate.dateOnly; // Set the Time in DateTime to 00:00:00 forcibly.
    todates[index].title = todate.title;
    todates[index].memo = todate.memo;
    //sortTodates();
  }

  @override
  void deleteTodate(Todate todate) {

    int index = todates.indexWhere(
      (d) => d.id == todate.id
    );
    todates.removeAt(index);
    //sortTodates();
  }

  void sortTodates() {
    todates.sort((a, b) => a.date.compareTo(b.date));
  }



} 