import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/features/sfv/data/sfv_model.dart';
import '../../../../core/core.dart';
import '../../services/sfv_service.dart';

class SfvViewModel extends BaseModel {
  final _sfvService = Modular.get<SfvService>();
  AwsomeVideoPlayer _player;
  AwsomeVideoPlayer get player => _player;

  Sfv _selectedSfv;
  Sfv get selectedSfv => _selectedSfv;

  List<Sfv> _sfvList = [];
  List<Sfv> get sfvList => _sfvList;

  void selectSfv(sfv) {
    _selectedSfv = sfv;
    _swapSfv(sfv);
    notifyListeners();
  }

  void _swapSfv(sfv) {
    for (int i = 0; i < _sfvList.length; i++) {
      if (sfv == _sfvList[i]) {
        _sfvList[i] = _sfvList.first;
        _sfvList.first = sfv;
      }
    }
  }

  Future getSfvSnapshots() async {
    setBuzy(true);
    var result = await _sfvService.getSfvSnapshots();
    List<DocumentSnapshot> snapshots = result;

    for (var snapshot in snapshots) {
      _sfvList.add(Sfv.fromMap(snapshot.data, snapshot));
    }

    print("get snapshots");
    setBuzy(false);
    _selectedSfv = _sfvList.first;
  }
}
