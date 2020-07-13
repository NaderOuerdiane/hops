import 'package:flutter/cupertino.dart';

enum PageSelect { Home, Search, Favorite, Compare }

class PageRepository with ChangeNotifier {
  PageSelect _page;
  bool _tab;

  PageSelect get page => _page;
  bool get tab => _tab;

  PageRepository.instance() {
    _page = PageSelect.Home;
    _tab = false;
  }

  void changePage(int pagenumber) {
    switch (pagenumber) {
      case 0:
        _page = PageSelect.Home;
        break;
      case 1:
        _page = PageSelect.Search;
        break;
      case 2:
        _page = PageSelect.Favorite;
        break;
      case 3:
        _page = PageSelect.Compare;
        break;
      default:
        _page = PageSelect.Home;
    }
    notifyListeners();
  }

  void changeTab() {
    _tab = !_tab;
    notifyListeners();
  }
}
