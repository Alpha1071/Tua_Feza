import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Challenge {
  final String title;
  final Icon icon;
  final String description;
  final String scientist;
  final String sciPicture;
  final List<Step> steps;
  Challenge(this.title, this.icon, this.description, this.scientist, this.sciPicture, this.steps);
}


class Step {
  String text;
  String image;

  Step(this.text, this.image);
}


List<Challenge> challengeTree = [
  Challenge(
      'Planes',
      Icon(Icons.local_airport),
      'In this step, you will learn why airplanes fly. Make your own paper airplane following the instructions on the next step',
      'physicist',
      'phys.png',
      [
        Step('', 'Step1: Do this '),
        Step('', 'Step2: Do that')
      ]),
  Challenge('The Moon',Icon(Icons.search), 'Learn about the mission target', 'physicist', 'phys.png',
    [
      Step('', 'Step1: Do this '),
      Step('', 'Step2: Do that')
    ]
  ),
  Challenge('Stars', Icon(Icons.insights), 'The next target: the stars!', 'physicist', 'phys.png',
    [
      Step('', 'Step1: Do this '),
      Step('', 'Step2: Do that')
    ]
  ),
  Challenge('Food', Icon(Icons.restaurant), 'Learn what to eat to stay healthy in space', 'physicist', 'phys.png',
    [
      Step('', 'Step1: Do this '),
      Step('', 'Step2: Do that')
    ]
  ),
];


class DetailArguments {
  final Challenge challenge;
  DetailArguments(this.challenge);
}


class StepArguments {
  final List<Step> steps;
  final int currentStep;
  StepArguments(this.steps, this.currentStep);
}

MaterialApp myApp = MaterialApp(
  title: 'To The Moon!',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => Challenges(challenges: challengeTree),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/step': (context) => StepScreen(),
    '/detail': (context) => DetailScreen(),
  },
);

void main() {
  runApp(myApp);
}

class Challenges extends StatelessWidget {

  final List<Challenge> challenges;

  Challenges({Key? key, required this.challenges}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),

      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: challenges[index].icon,
            title: Text(challenges[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailScreen.routeName,
                arguments: DetailArguments(
                  challenges[index]
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailArguments;
    final challenge = args.challenge;
    return Scaffold(
      appBar: AppBar(
        title: Text(challenge.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
          AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('havaBilimcisi.png'),
          ),
            Text(challenge.description),
            ElevatedButton(
                onPressed: () => { },
                child: Text('Let\'s start!'))
          ]
        )
      ),
    );
  }
}


class StepScreen extends StatelessWidget {

  static const routeName = '/step';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as StepArguments;
    final steps = args.steps;
    final currentStep = args.currentStep;
    return Scaffold(
      appBar: AppBar(
        title: Text('Step'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18.0 / 11.0,
                  child: Image.asset('havaBilimcisi.png'),
                ),
                Text(steps[currentStep].text),
                ElevatedButton(onPressed: () => {}, child: Text('Let\'s start!'))
              ]
          )
      ),
    );
  }
}