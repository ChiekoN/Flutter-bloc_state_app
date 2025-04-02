import '../models/todate.dart';

abstract class TodateRepo {
  /*
  Future<List<Todate>> getTodates();

  Future<void> addTodate(Todate newTodate);

  Future<void> updateTodate(Todate Todate);

  Future<void> deleteTodate(Todate Todate);
  */
  List<Todate> getTodates();

  void addTodate(Todate newTodate);

  void updateTodate(Todate Todate);

  void deleteTodate(Todate Todate);

}
