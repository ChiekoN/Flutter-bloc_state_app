import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/todate.dart';
import '../../domain/repository/todate_repo.dart';

class TodateCubit extends Cubit<List<Todate>>{

  final TodateRepo todateRepo;

  TodateCubit(this.todateRepo) : super([]) {
    loadTodates();
  }

  // Load
  void loadTodates() {
    final List<Todate> todateList = todateRepo.getTodates();
    emit(todateList);
  }

  // Add
  void addTodate(Todate newTodate) {
    todateRepo.addTodate(newTodate);
    loadTodates();
  }

  // Update
  void updateTodate(Todate newTodate) {
    todateRepo.updateTodate(newTodate);
    loadTodates();
  }

  // Delete
  void deleteTodate(Todate deletedTodate) {
    todateRepo.deleteTodate(deletedTodate);
    loadTodates();
  }
}