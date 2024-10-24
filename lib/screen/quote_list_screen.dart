import 'package:flutter/material.dart';
import 'package:navigator_2/routes/page_manager.dart';
import 'package:provider/provider.dart';

import '../model/quote.dart';

class QuotesListScreen extends StatelessWidget {
  final List<Quote> quotes;
  final Function(String) onTapped;
  final Function() toFormScreen;

  const QuotesListScreen({
    super.key,
    required this.quotes,
    required this.onTapped,
    required this.toFormScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
        actions: [
          IconButton(
            onPressed: () async {
              final scaffoldMessengerState = ScaffoldMessenger.of(context);
              toFormScreen();
              final dataString =
                  await context.read<PageManager>().waitForResult();

              scaffoldMessengerState.showSnackBar(
                  SnackBar(content: Text("My Name is $dataString")));
            },
            icon: const Icon(Icons.quiz),
          )
        ],
      ),
      body: ListView(
        children: [
          for (var quote in quotes)
            ListTile(
              title: Text(quote.author),
              subtitle: Text(quote.quote),
              isThreeLine: true,
              onTap: () => onTapped(quote.id),
            )
        ],
      ),
    );
  }
}
