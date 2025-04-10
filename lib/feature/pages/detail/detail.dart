import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../shared/router.dart';
import '../../shared/todate_cubit.dart';
import '../../../domain/models/todate.dart';
import 'memo_area.dart';


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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ),
            // Date
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: Text(
                item.dateString,
                style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            // Memo
            MemoArea(memoText: item.memo),
          ];
        }
        return Scaffold(
          appBar: AppBar(),
          body: SizedBox(
            width: double.infinity,
            child:
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: children,
                ),
              
              ),
            ),
          );
          /*
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go(AppRoutes.home);
            },
            child: const Icon(Icons.close),
          ),
          */
        
      }
    );
  }
}

/*
class MemoArea extends StatelessWidget {
  const MemoArea({super.key, this.memoText});

  final String? memoText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
      //margin: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Text(
              "Memo",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            //color: Colors.grey[500],
            padding: EdgeInsets.all(8.0),
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: Theme.of(context).textTheme.bodyLarge!.fontSize! * 5 + 16.0,
            ),
            decoration: BoxDecoration(
              //color: Theme.of(context).hoverColor,
              border: Border.all(
                color: Colors.grey[400]!,
              ),
            ),
            child: Text(
              memoText ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],)
      ,
      );
  }
}
*/