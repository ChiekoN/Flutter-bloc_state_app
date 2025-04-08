import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../shared/router.dart';
import '../../shared/todate_cubit.dart';
import '../../../domain/models/todate.dart';



class DateDetailPage extends StatelessWidget {
  final String? id;
  const DateDetailPage({this.id, super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodateCubit, List<Todate>>(
      builder: (context, todates) {
        Todate? item = todates.firstWhereOrNull(
          (todate) => todate.id == id, 
        );
        List<Widget> children = [
          Text(
            "INTERNAL ERROR: Date not found for $id.}",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ];
        if(item != null) {
          children = [
            // Title
            Text(
              item.title,
              style: Theme.of(context).textTheme.headlineLarge, 
            ),
            // Date
            Text(
              item.dateString,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // Memo
            Text(
              "Memo",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              item.memo ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ];
        }
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
          /*
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go(AppRoutes.home);
            },
            child: const Icon(Icons.close),
          ),
          */
        );
      }
    );
  }
}
