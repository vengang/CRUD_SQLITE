import 'dart:developer';

import 'package:crudsqlite/database/db_helper.dart';
import 'package:flutter/material.dart';

//CRUD Create/ read/ update/ delete
class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _salary = TextEditingController();
  List<Map<String, dynamic>> listEmployee = [];

  Future<void> loadData() async {
    listEmployee = await DbHelper.getUser();
    setState(() {});
    log('$listEmployee');
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Employee"),
        // backgroundColor: Colors.white,
        // surfaceTintColor: Colors.transparent,
        // scrolledUnderElevation: 0,
      ),
      body: ListView.builder(
        // shrinkWrap: true,
        itemCount: listEmployee.length,
        itemBuilder: (context, index) {
          final item = listEmployee[index];
          // take id
          final id = item['id'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    item['id'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),

                title: Text(
                  item['username'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    width: 90,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "\$${item['salary']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                trailing: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      DbHelper.dateleEmployee(id);
                      loadData();
                    },
                    icon: Icon(Icons.delete, size: 16, color: Colors.red),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Insert Employee"),
                content: Container(
                  height: 150,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userName,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Enter Username",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _salary,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.monetization_on_outlined),
                          hintText: "Enter Salary",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  FilledButton(
                    onPressed: () {
                      // log("${_userName.text} /t ${_salary.text}");
                      DbHelper.insertEmployee(
                        _userName.text,
                        double.parse(_salary.text),
                      );
                      _userName.clear();
                      _salary.clear();
                      Navigator.pop(context);
                      loadData();
                    },
                    child: Text("Insert"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
