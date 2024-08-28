// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController controller = TextEditingController();
  final box = Hive.box("samplebox");
  List data = [];
  List keys = [];

  @override
  void initState() {
    keys = box.keys.toList();
    data = box.values.toList();
    print("data");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await box.clear();
                  data = box.values.toList();
                  keys = box.keys.toList();
                  setState(() {});
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () async {
                  await box.add(controller.text);

                  data = box.values.toList();
                  keys = box.keys.toList();
                  setState(() {});
                  controller.clear();
                  print(box.values.toList());
                },
                child: Text("add"),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                          color: Colors.grey,
                          child: ListTile(
                            title: Text(data[index]),
                            trailing: IconButton(
                                onPressed: () {
                                  box.delete(keys[index]);
                                  data = box.values.toList();
                                  keys = box.keys.toList();
                                  setState(() {});
                                  print(box.keys);
                                  print(box.values);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                    itemCount: data.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
