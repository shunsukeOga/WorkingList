import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
String checkWeekday() {
  switch (DateTime.now().weekday.toString()) {
    case '1':
      return "（月）";
    case '2':
      return "（火）";
    case '3':
      return "（水）";
    case '4':
      return "（木）";
    case '5':
      return "（金）";
    case '6':
      return "（土）";
    default:
      return "（日）";
  }
}

bool checkBorder = false;
List<String> allBuildingName = [
  '7号館',
  '8号館',
  '9号館',
  '1号館',
  '2号館',
  '3号館',
  '5号館',
  '6号館',
  '7号館',
  '8号館',
  '9号館'
]; // 全棟を管理（棟一覧）
List<String> checkinName = [
  '1号館',
  '2号館',
  '3号館',
  '5号館',
  '6号館',
  '7号館',
  '8号館',
  '9号館',
  '1号館',
  '2号館',
  '3号館',
  '5号館',
  '6号館',
  '7号館',
  '8号館',
  '9号館',
  '1号館',
  '2号館',
  '3号館',
  '5号館',
  '6号館',
  '9号館',
  '1号館',
  '2号館',
  '3号館',
  '5号館',
  '6号館',
]; // 入館の棟を管理
List<String> replacementName = []; // 入れ替えの棟を管理
List<String> checkoutName = []; // 出の棟を管理
List<String> continueName = []; // 連泊の棟を管理

//各棟のプレートの見た目を統一するための関数
Widget plateLayout(String name) {
  return Card(
    elevation: 10,
    child: Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    ),
  );
}

// nameから返すListを判別する
List<String> whichName(String name) {
  switch (name) {
    case '入館':
      return checkinName;
    case '入れ替え':
      return replacementName;
    case '出':
      return checkoutName;
    default:
      return continueName;
  }
}
