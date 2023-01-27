import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalPostScreen extends StatelessWidget {
  GlobalPostScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey();

  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: Get.height * 0.25,
              width: Get.width,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  direction: Axis.vertical,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        ClipOval(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.amber),
                            height: 100,
                            width: 100,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                    title: Column(children: [
                                      Text("Create Post"),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                      Row(
                                        children: [
                                          ClipOval(
                                              child: Container(
                                            color: Colors.amberAccent,
                                            height: 50,
                                            width: 50,
                                          )),
                                          Text("Name")
                                        ],
                                      ),
                                      Form(
                                          key: formkey, child: TextFormField(controller: bodyController,)),
                                      ElevatedButton(
                                          onPressed: null,
                                          child: Text("Upload Image")),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        color: Colors.amberAccent,
                                        height: Get.height * 0.15,
                                        width: Get.width,
                                      )
                                    ]),
                                    children: [
                                      ElevatedButton(
                                          onPressed: null, child: Text("Post"))
                                    ]),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10),
                              height: 50,
                              width: Get.width * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                  "What's on your Mind {add name here from firebase}"),
                            )),
                      ],
                    ),
                    Container(
                        width: Get.width * 0.95,
                        child: Divider(
                          thickness: 1,
                          color: Colors.black87,
                        )),
                    Container(
                        margin: EdgeInsets.only(left: Get.width * 0.35),
                        child: ElevatedButton(
                            onPressed: null,
                            child: Text(
                              "Upload Image",
                              style: TextStyle(color: Colors.black87),
                            )))
                  ]),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                height: Get.height,
                child: ListView.separated(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      width: Get.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Name"),
                                                Text("20 min.")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "For information on the generic Dart part of this file, see the For information on the generic Dart part of this file, see the For information on the generic Dart part of this file, see the For information on the generic Dart part of this file, see the "),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: Get.width,
                            // height: 150,
                            child: Image.network(
                              "https://uploads-ssl.webflow.com/5f841209f4e71b2d70034471/60bb4a2e143f632da3e56aea_Flutter%20app%20development%20(2).png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("12 Likes"),
                                    Text("12 Comments"),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color: Colors.red,
                                        )),
                                    Text("12 Comments"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      width: Get.width,
                      height: 10,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
