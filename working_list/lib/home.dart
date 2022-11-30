import 'package:flutter/material.dart';
import 'package:test_work/todayWorker.dart';
import 'background.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //作業者一覧に表示する用
  List<String> todayWorkerList = [];
  // 各割り当て用Widgetの見た目を統一
  Widget assignmentWidget(String name) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        // 各割り当て業務（入館・入れ替え・出・連泊）のWidgetの最小サイズを指定
        minHeight: MediaQuery.of(context).size.height * 0.2,
        // minWidth: 1200,
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(63, 149, 133, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 各割り当て業務(入館・入れ替え・出・連泊)のWidget
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: (MediaQuery.of(context).size.width - 100) * 0.6),
              child: DragTarget(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    decoration: BoxDecoration(
                      border: checkBorder
                          ? Border.all(
                              color: Colors.red,
                              width: 10,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: (MediaQuery.of(context).size.width - 100) * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.all(10),
                            child: Text(name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white)),
                          ),
                          Wrap(
                            children: [
                              for (final buildingName in whichName(name))
                                Draggable(
                                  data: buildingName,
                                  feedback: plateLayout(buildingName),
                                  child: plateLayout(buildingName),
                                ),
                            ],
                          )
                        ]),
                  );
                },
                onWillAccept: (data) {
                  checkBorder = true;
                  return true;
                },
                onLeave: (data) {
                  checkBorder = false;
                },
                onAccept: (String data) {
                  if (whichName(name).contains(data)) {
                  } else {
                    setState(() {
                      whichName(name) == checkinName
                          ? {
                              checkinName.add(data),
                              replacementName.remove(data),
                              checkoutName.remove(data),
                              continueName.remove(data),
                            }
                          : null;
                      whichName(name) == replacementName
                          ? {
                              replacementName.add(data),
                              checkinName.remove(data),
                              checkoutName.remove(data),
                              continueName.remove(data),
                            }
                          : null;
                      whichName(name) == checkoutName
                          ? {
                              checkoutName.add(data),
                              checkinName.remove(data),
                              replacementName.remove(data),
                              continueName.remove(data),
                            }
                          : null;
                      whichName(name) == continueName
                          ? {
                              continueName.add(data),
                              checkinName.remove(data),
                              replacementName.remove(data),
                              checkoutName.remove(data),
                            }
                          : null;
                      allBuildingName.remove(data);
                    });
                  }
                  checkBorder = false;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(183, 225, 218, 1),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  outputFormat.format(DateTime.now()) + checkWeekday(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(63, 149, 133, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TodayWorker(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.person_add_alt_1,
                          size: 30,
                        ),
                        Text(
                          "作業者を設定する",
                          style: TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            //背景追加
            const BackGround(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //棟一覧Widget
                Container(
                  // 型崩れ防止のために最小サイズを指定
                  constraints: const BoxConstraints(minWidth: 100),
                  margin: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(63, 149, 133, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: (MediaQuery.of(context).size.width - 100) * 0.2,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          child: const Text("棟一覧",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white)),
                        ),
                        DragTarget(
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: checkBorder
                                    ? Border.all(
                                        color: Colors.red,
                                        width: 10,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: MediaQuery.of(context).size.height * 0.9 -
                                  100,
                              width: (MediaQuery.of(context).size.width - 100) *
                                  0.8 *
                                  0.6,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      for (final buildingName
                                          in allBuildingName)
                                        Draggable(
                                          data: buildingName,
                                          feedback: plateLayout(buildingName),
                                          child: plateLayout(buildingName),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          onWillAccept: (data) {
                            checkBorder = true;
                            return true;
                          },
                          onLeave: (data) {
                            checkBorder = false;
                          },
                          onAccept: (String data) {
                            if (allBuildingName.contains(data)) {
                            } else {
                              setState(() {
                                allBuildingName.add(data);
                                checkinName.remove(data);
                                replacementName.remove(data);
                                checkoutName.remove(data);
                                continueName.remove(data);
                              });
                            }
                            checkBorder = false;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // 入館用の割り当てWidget
                      assignmentWidget('入館'),
                      // 入れ替え用の割り当てWidget
                      assignmentWidget('入れ替え'),
                      // 出用の割り当てWidget
                      assignmentWidget('出'),
                      // 連泊用の割り当てWidget
                      assignmentWidget('連泊'),
                    ],
                  ),
                ),
                //作業者一覧の表示
                Container(
                  // 型崩れ防止のために最小サイズを指定
                  constraints: const BoxConstraints(minWidth: 100),
                  margin: const EdgeInsets.only(
                    right: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(63, 149, 133, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: (MediaQuery.of(context).size.width - 100) * 0.2,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          child: const Text("作業者一覧",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white)),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: checkBorder
                                ? Border.all(
                                    color: Colors.red,
                                    width: 10,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height:
                              MediaQuery.of(context).size.height * 0.9 - 100,
                          width: (MediaQuery.of(context).size.width - 100) *
                              0.8 *
                              0.6,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  for (final workerName in todayWorkerList)
                                    Container(
                                      child: plateLayout(workerName),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
