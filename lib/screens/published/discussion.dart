import 'package:flutter/material.dart';

import '../../services/singleton.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final singleton = Singleton();
  String postKey = '';
  List<String> commentKeys = [];
  List<String> comments = [];
  List<List<IconData>> iconList = [];
  List<List<bool>> likes = [];

  // @override
  // void initState() {
  //   super.initState();
  //   postKey = singleton.key;
  //   //TODO: Get comments from firebase
  //   for (var items in comments) {
  //     iconList.add([Icons.favorite_border, Icons.favorite]);
  //     likes.add([false]);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/publishedWork');
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text(
                  'Discussion Board',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: comments.isEmpty // Check if the data source is empty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Share your thoughts...",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 50),
                              ],
                            ),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: comments.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Card(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.white70,
                                              offset: Offset(
                                                5.0,
                                                5.0,
                                              ),
                                              blurRadius: 2.5,
                                              spreadRadius: 2.0,
                                            ), //BoxShadow
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                          ],
                                          color: Colors.white70,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Text(comments[index], //Comment
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ToggleButtons(
                                                  renderBorder: false,
                                                  isSelected: likes[index],
                                                  onPressed: (n) {
                                                    setState(() {
                                                      likes[index][0] =
                                                          !likes[index][0];
                                                    });
                                                  },
                                                  children: [
                                                    Icon(iconList[index][
                                                        likes[index][0] == false
                                                            ? 0
                                                            : 1])
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ))
              ]))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String comment = "";
          showDialog<String>(
              context: context,
              builder: (BuildContext c) => AlertDialog(
                    content: TextField(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                      onChanged: (text) {
                        setState(() {
                          comment = text;
                        });
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            comments.add(comment);
                            iconList
                                .add([Icons.favorite_border, Icons.favorite]);
                            likes.add([false]);
                          });
                          Navigator.pop(c, 'Submit');
                        },
                        child: const Text('Submit'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(c, 'Cancel');
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ));
        },
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}