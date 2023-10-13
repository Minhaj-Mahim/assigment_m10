import 'package:flutter/material.dart';
import 'items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController titleCon = TextEditingController();
  TextEditingController description = TextEditingController();

  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CRUD',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.search,
              color: Colors.blue,
            ),
          ],
        ),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a text';
                  }
                  return null;
                },
                controller: titleCon,
                decoration: InputDecoration(
                    hintText: 'Add Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a text';
                  }
                  return null;
                },
                controller: description,
                decoration: InputDecoration(
                    hintText: 'Add Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    Item newitem = Item(titleCon.text, description.text);
                    items.add(newitem);
                    titleCon.clear();
                    description.clear();
                    setState(() {});
                  }
                },
                child: Text(
                  'Add',
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, minimumSize: Size(90, 40)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return buildAlertDialog(context, index);
                            }
                            );
                      },
                      tileColor: Color(0xFFe0e0e0),
                      leading: CircleAvatar(
                          backgroundColor: Colors.red,
                      ),
                      title: Text('${items[index].title}'),
                      subtitle: Text('${items[index].descrip}'),
                      trailing: IconButton(onPressed: (){AlertDialog();},
                        icon: Icon(Icons.arrow_forward),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 5,
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context, int index) {
    return AlertDialog(
      title: Text('Alert'),
      actions: [
        Column(
          children: [
            SizedBox(
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: titleCon
                                        ..text = items[index].title,
                                      decoration: InputDecoration(
                                          hintText: '',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10))),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 8.0, left: 8, right: 8
                                    ),
                                    child: TextFormField(
                                      controller: description
                                        ..text = items[index].descrip,
                                      decoration: InputDecoration(
                                          hintText: '',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)
                                          )
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        int itemNumber =
                                        items.indexOf(items[index]);
                                        if (itemNumber != -1) {
                                          items[index] = Item(
                                              titleCon.text, description.text
                                          );
                                          titleCon.clear();
                                          description.clear();
                                          Navigator.of(context).pop();
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text(
                                        'Edit Done',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          minimumSize: Size(90, 40)),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.blue),
                      )
                  ),
                  GestureDetector(
                    onTap: () {
                      items.removeAt(index);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
