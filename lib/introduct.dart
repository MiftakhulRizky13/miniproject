import 'package:expensetracker/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  PageDecoration pageDecoration = PageDecoration(
    titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.black), //tile font size, weight and color
    bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.white),
    //body text size and color
    bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    //decription padding
    imagePadding: EdgeInsets.all(20), //image padding
    boxDecoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.5, 0.7, 0.9],
        colors: [
          Colors.white,
          Colors.white54,
          Colors.white60,
          Colors.white70,
        ],
      ),
    ), //show linear gradient background of page
  );
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.grey,
      //main background of screen
      pages: [
        //set your page view here
        PageViewModel(
          title: "Atur Keuangan Anda",
          body: "",
          image: introImage2('assets/sales.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Ciptakan keuangan yang sehat",
          body: "",
          image: introImage('assets/acquisition.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Catat setiap pengeluaran dan pemasukan anda",
          body: "",
          image: introImage1('assets/budget.png'),
          decoration: pageDecoration,
        ),

        //add more screen here
      ],

      onDone: () => goHomepage(context), //go to home page on done
      onSkip: () => goHomepage(context), // You can override on skip
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: Text(
        'Skip',
        style: TextStyle(color: Colors.black),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: Text(
        'Mulai',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0), //size of dots
        color: Colors.black, //color of dots
        activeSize: Size(22.0, 10.0),
        //activeColor: Colors.white, //color of active dot
        activeShape: RoundedRectangleBorder(
          //shave of active dot
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void goHomepage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return HomePage();
    }), (Route<dynamic> route) => false);
    //Navigate to home page and remove the intro screen history
    //so that "Back" button wont work.
  }

  Widget introImage(String assetName) {
    //widget to show intro image
    return Align(
      child: Image.asset('assets/acquisition.png', width: 200.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget introImage1(String assetName) {
    //widget to show intro image
    return Align(
      child: Image.asset('assets/budget.png', width: 200.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget introImage2(String assetName) {
    //widget to show intro image
    return Align(
      child: Image.asset('assets/sales.png', width: 200.0),
      alignment: Alignment.bottomCenter,
    );
  }
}
