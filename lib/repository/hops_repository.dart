import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hops/models/hop_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HopsRepository with ChangeNotifier {
  List<Hop> _hops;
  List<Hop> get hops => _hops;

  List<String> _favs;
  List<String> get favs => _favs;

  List<String> _cmps;
  List<String> get cmps => _cmps;

  HopsRepository.intsance() {
    _hops = [];
    _favs = [];
    _cmps = [];
  }

  Future<List<String>> updateFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favs = prefs.getStringList('favorite') ?? [];
    _favs = favs;
    return favs;
  }

  Future<List<String>> updateCompare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cmps = prefs.getStringList('compare') ?? [];
    _cmps = cmps;
    return cmps;
  }

  Future<bool> clearCompare() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('compare', []);
      _cmps = [];
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> favorite(String fav) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favs = prefs.getStringList('favorite') ?? [];
      if (!favs.contains(fav)) {
        favs.add(fav);
        _favs = favs;
        prefs.setStringList('favorite', favs);
      } else {
        favs.remove(fav);
        _favs = favs;
        prefs.setStringList('favorite', favs);
      }
      notifyListeners();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> compare(String cmp) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> cmps = prefs.getStringList('compare') ?? [];
      if (!cmps.contains(cmp)) {
        cmps.add(cmp);
        _cmps = cmps;
        prefs.setStringList('compare', cmps);
      } else {
        cmps.remove(cmp);
        _cmps = cmps;
        prefs.setStringList('compare', cmps);
      }
      notifyListeners();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> loadAsset() async {
    try {
      var raw = await rootBundle.loadString('assets/hops.json');
      var hops = jsonDecode(raw);
      _hops = hops
          .map<Hop>((value) => Hop(
                variety: value['Variety'],
                type: value['type'],
                aroma_profile: value['AROMA_PROFILE'],
                country: value['Country'],
                beer_style: value['BEER STYLES'],
                substitutes: value['Substitutes'],
                flavor_description: value['Flavor Description'],
                alpha_min: value['Alpha min'].toDouble(),
                alpha_max: value['Alpha max'].toDouble(),
                beta_min: value['Beta min'].toDouble(),
                beta_max: value['Beta max'].toDouble(),
                total_oil_min: value['Total oil min'].toDouble(),
                total_oil_max: value['Total oil max\n(mL/100g)'].toDouble(),
                cohumulone_min: value['Cohumulone min'].toDouble(),
                cohumulone_max: value['Cohumulone max'].toDouble(),
                b_pinene_min: value['B-Pinene min'].toDouble(),
                b_pinene_max: value['B-Pinene max'].toDouble(),
                myrcene_min: value['Myrcene min'].toDouble(),
                myrcene_max: value['Myrcene max'].toDouble(),
                linalool_min: value['Linalool min'].toDouble(),
                linalool_max: value['Linalool max'].toDouble(),
                caryphyllene_min: value['Caryophyllene min'].toDouble(),
                caryphyllene_max: value['Caryophyllene max'].toDouble(),
                farnesene_min: value['Farnesene min'].toDouble(),
                farnesene_max: value['Farnesene max'].toDouble(),
                humulene_min: value['Humulene min'].toDouble(),
                humulene_max: value['Humulene max'].toDouble(),
                geraniol_min: value['Geraniol min'].toDouble(),
                geraniol_max: value['Geraniol max'].toDouble(),
                selinene_min: value['Selinene min'].toDouble(),
                selinene_max: value['Selinene max'].toDouble(),
                other_min: value['Other min'].toDouble(),
                other_max: value['Other max'].toDouble(),
              ))
          .toList();
      updateCompare();
      return true;
    } catch (err) {
      return false;
    }
  }
}
