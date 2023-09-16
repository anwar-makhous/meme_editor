import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool liked = false;

  // Vertical ListView
  Widget card() {
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(5),),
                        child: Image.asset("assets/jerry.jpg"),
                      ),
                      Positioned(
                        top: 5.0,
                        right: 10.0,
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  liked = !liked;
                                  print(liked);
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.5),
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    liked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: liked ? Colors.red : Colors.black,
                                    size: 40,
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.5),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.share,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      color: Colors.blue,
                    ),
                    child: const Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Title',
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 3,
                            ),
                            Icon(Icons.person_outline),
                            Text(
                              "Username",
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.file_download),
                            Text(
                              "200",
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            Text(
                              "12",
                              maxLines: 1,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget loginCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(color: Colors.black.withAlpha(20), width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withAlpha(15),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: InkWell(
          splashColor: Colors.lightBlueAccent.withAlpha(150),
          onTap: () {
            print('Log in or create account');
          },
          child: Row(children: <Widget>[
            Icon(
              Icons.person_pin,
              size: 50,
              color: Colors.blue.withOpacity(0.7),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Log in or create an account",
              style: TextStyle(fontSize: 15),
            )
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: Drawer(
              child: ListView(
            children: <Widget>[
              CustomListTile(Icons.person, "Profile", () => {}),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              CustomListTile(Icons.settings, "Settings", () => {}),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              CustomListTile(Icons.phone, "Contact Us", () => {}),
              const Divider(thickness: 1, color: Colors.grey),
              CustomListTile(Icons.lock, "Log Out", () => {}),
            ],
          )),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Flexible(child: loginCard()),
              const SizedBox(
                height: 10,
              ),
              Flexible(child: card())
            ],
          ))),
    );
  }

  void navigateToDetails(int index, String name, String imgURL) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return Details(index);
    }));
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.lightBlueAccent,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
