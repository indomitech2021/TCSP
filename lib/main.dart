import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}


// class Home extends StatelessWidget {
//    Home({Key? key}) : super(key: key);
//
//   int number = 100;
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int number = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stful and stless"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          Container(
            child: Text(number.toString(),
              style: TextStyle(
                fontSize: 50,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    number++;
                    print(number);
                  });
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Icon(Icons.add,
                    color: Colors.grey,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    number--;
                    print(number);
                  });
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Icon(Icons.remove,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
