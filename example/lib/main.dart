import 'package:flutter/material.dart';
import 'package:flutter_floc/flutter_floc.dart';
import 'package:flutter_floc_example/blocs/example_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height,
          child: BlocProvider(
            create: (context) => ExampleFormBloc(),
            child: ExampleForm(),
          ),
        ),
      ),
    );
  }
}

class ExampleForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormBlocListener<ExampleFormBloc, String>(
      onSubmitting: (context, state) {
        print('Loading...');
      },
      onSuccess: (context, state) {
        print('Success !');
        print(state.response);
      },
      onFailure: (context, state) {
        print('Failure !');
        print(state.response);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFieldBlocBuilder<ExampleFormBloc>(
            fieldName: 'username',
            decoration: InputDecoration(hintText: 'Username'),
          ),
          TextFieldBlocBuilder<ExampleFormBloc>(
            fieldName: 'password',
            obscureText: true,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          TextFieldBlocBuilder<ExampleFormBloc>(
            fieldName: 'confirmPassword',
            obscureText: true,
            decoration: InputDecoration(hintText: 'Confirm password'),
          ),
          CheckboxFieldBlocBuilder<ExampleFormBloc>(
            fieldName: 'accept',
          ),
          MaterialButton(
            onPressed: () {
              context.read<ExampleFormBloc>().validate();
            },
            child: Text('Validate'),
          ),
          MaterialButton(
            onPressed: () {
              context.read<ExampleFormBloc>().reset();
            },
            child: Text('Reset'),
          ),
          MaterialButton(
            onPressed: () {
              context.read<ExampleFormBloc>().submit();
            },
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}
