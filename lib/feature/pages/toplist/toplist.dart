import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/router.dart';
import '../../../domain/models/todate.dart';
import '../../shared/todate_cubit.dart';
//import '../../shared/classes/date_info.dart';

class TopListPage extends StatefulWidget {
  const TopListPage({super.key});

  @override
  State<TopListPage> createState() => _TopListPageState();
}

class _TopListPageState extends State<TopListPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodateCubit, List<Todate>>(
      builder: (context, todates) {
        return ListView.builder(  
          itemCount: todates.length,
          itemBuilder: (context, index) {
            final item = todates[index];
            return Dismissible(
              key: ValueKey<Todate>(item),
              direction: DismissDirection.endToStart, // Only allow to swipe right-to-left
              dismissThresholds: {
                DismissDirection.endToStart: 0.3,
              },
              onDismissed: (direction) {                
                context.read<TodateCubit>().deleteTodate(item);
                ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${item.title} dismissed')));
              },
              background: Container(
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                leading: Icon(
                    Icons.event_available,
                  ),
                title: Text(item.title,
                  style: Theme.of(context).textTheme.titleMedium,         
                ),
                subtitle: Text(item.dateString),
                onTap:() {
                  context.go('/${AppRoutes.detail}/${item.id}');
                }
              )
            );
          }
        );
      }
    );
  }
}

/*
class TopListPage extends StatefulWidget {
  const TopListPage({super.key});

  @override
  State<TopListPage> createState() => _TopListPageState();
}

class _TopListPageState extends State<TopListPage> {

  //List<MyDate> items = MyDateProvider.samples;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: ValueKey<MyDate>(item),
          direction: DismissDirection.endToStart, // Only allow to swipe right-to-left
          dismissThresholds: {
            DismissDirection.endToStart: 0.3,
          },
          onDismissed: (direction) {
            setState((){
              items.removeAt(index);
            });
            ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${item.title} dismissed')));
          },
          background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            leading: Icon(
                Icons.event_available,
              ),
            title: Text(item.title,
              style: Theme.of(context).textTheme.titleMedium,         
            ),
            subtitle: Text(item.dateString),
            onTap:() {
              context.go('/${AppRoutes.detail}/${index.toString()}');
            }
          )
        );
      }
    );
  }
}
*/