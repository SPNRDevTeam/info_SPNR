import 'package:flutter/material.dart';

void main()
	=> runApp(const SPNRApp());

class SPNRApp extends StatelessWidget {
	const SPNRApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			theme: ThemeData(
				colorSchemeSeed: Color(0xFFFFFFFF),
				useMaterial3: true,
			),
			home: SPNRAppPage(),
		);
	}
}

class SPNRAppState extends ChangeNotifier {
	
}

class SPNRAppPage extends StatelessWidget {
	

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('СПНР'), // TODO: заглушка, добавить лого
				centerTitle: true,
				backgroundColor: const Color(0xFFFFFFFF), // TODO: заглушка, добавить цвет по дизайну
			),
			body: SingleChildScrollView(
			),

		);
	}
}