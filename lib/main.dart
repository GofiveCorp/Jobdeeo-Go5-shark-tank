import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/feature/questionnaire/screen/questionaire_screen.dart';
import 'feature/job_board/bloc/company/company_bloc.dart';
import 'feature/job_board/bloc/job/job_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => JobBloc()),
        BlocProvider(create: (context) => CompanyBloc()),
      ],
      child: MaterialApp(
        title: 'questionaire',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),
        home: const QuestionnaireScreen(),
      ),
    );
  }
}