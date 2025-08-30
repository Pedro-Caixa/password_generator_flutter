import 'package:aula_05/tasklist.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO-DO!',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = <Task>[
      //Task(label: 'Printar piadocas'),
      //Task(label: 'enviar memes'),
      //Task(label: 'Adicionar'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Planejador!')),
      body: Column(children: [TaskList(tasks: tasks)]),
    );
  }
}
