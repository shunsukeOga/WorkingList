import 'package:flutter/material.dart';
import 'background.dart';
import 'model.dart';

class TodayWorker extends StatefulWidget {
  const TodayWorker({Key? key}) : super(key: key);
  @override
  State<TodayWorker> createState() => _TodayWorkerState();
}

class _TodayWorkerState extends State<TodayWorker> {
  // 作業者選択の際に表示させるボタン(todayWorker.dart内で使用)
  Widget selectedPlate(String name) {
    return InkWell(
      onTap: () {
        setState(() {
          todayWorkerList.contains(name)
              ? todayWorkerList.remove(name)
              : todayWorkerList.add(name);
        });
      },
      child: Stack(
        children: [
          Card(
            elevation: 10,
            margin: const EdgeInsets.all(10),
            child: Container(
              constraints: const BoxConstraints(minWidth: 200),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: (MediaQuery.of(context).size.width - 100) * 0.7 * 0.3,
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: todayWorkerList.contains(name),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent[400],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 30,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        //戻るボタンの配置
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(63, 149, 133, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(183, 225, 218, 1),
        title: Center(
          child: Text(
            outputFormat.format(DateTime.now()) + checkWeekday(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          //背景追加
          const BackGround(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 作業者一覧の表示
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
                  width: (MediaQuery.of(context).size.width - 100) * 0.7,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text("本日の作業者を選択してください",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white)),
                        Wrap(
                          children: [
                            for (final workerName in workerList)
                              Container(
                                child: selectedPlate(workerName),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //本日の作業者一覧の表示
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
                  width: (MediaQuery.of(context).size.width - 100) * 0.3,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          child: const Text("本日の作業者一覧",
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
          ),
        ],
      ),
    ));
  }
}
