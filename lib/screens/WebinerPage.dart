import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/appProvider.dart';
import 'package:lottie/lottie.dart';
import '../utils/Tile/WebinarTile.dart';
import 'WebinarDetailPage.dart';

class WebinerPage extends StatefulWidget {
  const WebinerPage({Key? key}) : super(key: key);

  @override
  _WebinerPageState createState() => _WebinerPageState();
}

class _WebinerPageState extends State<WebinerPage> {
  late AppProvider appProvider;

  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.fetchWebinars();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: appProvider.isLoading
          ?  Center(
              child: Lottie.asset(
                'assets/Animation/loadingAnimation.json', // Replace with the path to your Lottie animation file
                width: 150, // Adjust the width and height as needed
                height: 150,
              ),
            )
          : appProvider.errorMessage.isNotEmpty
          ? Center(
            child: Text(appProvider.errorMessage),
          )
          : ListView.builder(
              itemCount: appProvider.webinars.length,
              itemBuilder: (context, index) {
                final webinar = appProvider.webinars[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebinarDetailPage(
                      webinar: webinar,
                    )),
                  );
                },
                child: WebinarTile(webinar: webinar,),
              );
        },
      ),
    );
  }
}






