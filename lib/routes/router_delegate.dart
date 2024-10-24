import 'package:flutter/material.dart';
import 'package:navigator_2/db/auth_repository.dart';
import 'package:navigator_2/model/quote.dart';
import 'package:navigator_2/screen/form_screen.dart';
import 'package:navigator_2/screen/quote_detail_screen.dart';
import 'package:navigator_2/screen/quote_list_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  MyRouterDelegate(this.authRepository)
      : _navigatorKey = GlobalKey<NavigatorState>();

  String? selectedQuote;
  bool? isForm = false;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey("QuotesListPage"),
          child: QuotesListScreen(
            quotes: quotes,
            onTapped: (String quoteId) {
              selectedQuote = quoteId;
              notifyListeners();
            },
            toFormScreen: () {
              isForm = true;
              notifyListeners();
            },
          ),
        ),
        if (selectedQuote != null)
          MaterialPage(
            key: ValueKey("QuoteDetailsPage-$selectedQuote"),
            child: QuoteDetailsScreen(
              quoteId: selectedQuote as String,
            ),
          ),
        if (isForm != false)
          MaterialPage(
            key: const ValueKey("FormScreen"),
            child: FormScreen(
              onSend: () {
                isForm = false;
                notifyListeners();
              },
            ),
          )
      ],
      onDidRemovePage: (page) {
        selectedQuote = null;
        isForm = false;
        notifyListeners();
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
