import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';
import 'package:flutter_course/src/theme/image_sources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationsList extends StatelessWidget {
  const LocationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: ImageSources.backArrowIcon),
        title: Text(
          AppLocalizations.of(context)!.locationsListTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: context.read<MenuBloc>().state.locations?.length ?? 0,
        itemBuilder: (context, index) {
          final location = context.read<MenuBloc>().state.locations![index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            title: Text(location.address),
            trailing: ImageSources.rightArrowIcon,
            onTap: () {
              log("Selected location ${location.id}");
              while (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(location.id);
              }
            },
          );
        },
      ),
    );
  }
}
