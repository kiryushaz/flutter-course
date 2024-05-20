import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';

class PointBottomSheet extends StatefulWidget {
  final int index;
  const PointBottomSheet({super.key, required this.index});

  @override
  _PointBottomSheetState createState() => _PointBottomSheetState();
}

class _PointBottomSheetState extends State<PointBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  context
                      .read<MenuBloc>()
                      .state
                      .locations![widget.index - 1]
                      .address,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  onPressed: () {
                    log("Selected location ${widget.index}");
                    while (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop(widget.index);
                    }
                  },
                  child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.selectLocation,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: CoffeeAppColors
                                            .secondaryTextColor))),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
