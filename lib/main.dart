import 'package:contact_x/core/local_storage/database_manager.dart';
import 'package:contact_x/core/services/injection_container.dart';
import 'package:contact_x/core/services/router.dart';
import 'package:contact_x/core/theme/app_theme.dart';
import 'package:contact_x/l10n/app_localization.dart';
import 'package:contact_x/src/category/presentation/add_or_edit_category_bloc/category_bloc.dart';
import 'package:contact_x/src/contacts/presentation/contact_bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await DatabaseHelper.database;
  runApp(const ContactXApp());
}

class ContactXApp extends StatelessWidget {
  const ContactXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(create: (context) => CategoryBloc()),
        BlocProvider<ContactBloc>(create: (context) => ContactBloc()),
      ],
      child: MaterialApp(
        title: 'ContactX',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        themeMode: ThemeMode.system,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
        ],
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
