import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:confetti/confetti.dart'; // Import the confetti package

class WishScreen extends StatefulWidget {
  @override
  _WishScreenState createState() => _WishScreenState();
}

class _WishScreenState extends State<WishScreen> {
  int _currentQuestionIndex = 0;
  bool _isNoButtonVisible = true;

  final List<Map<String, String>> _questions = [
    {"question": "Are you ready for your suprise suppu?", "yes": "yaaa!", "no": "pheyyyy!! niku choice ledu bro inka"},
    {"question": "Do you want to see my singing vedio?", "yes": "Here's the song 🎶", "no": "sare nuvvve NSS singer ok naaa"},
    {"question": "Cake or no cake??", "yes": "idi tinnu 🍰🍰🍰", "no": "pheyyyyyyyyyyyyyyyyyyyyyy..........."},
    {"question": "Ready get set go 123....", "yes": "Get ready!", "no": "hehhehhehehehehhehehehe"}
  ];

  late html.AudioElement _audioElement;

  @override
  void initState() {
    super.initState();
    _audioElement = html.AudioElement()
      ..src = 'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Sevish_-__nbsp_.mp3'
      ..autoplay = true
      ..loop = true;  // To play continuously
    _audioElement.play();
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _isNoButtonVisible = true; // Reset the "No" button visibility for the next question
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinalWishScreen()),
        );
      }
    });
  }

  void _onNoPressed() {
    String noResponse = _questions[_currentQuestionIndex]['no'] ?? "You missed out!";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("sare sare"),
          content: Text(noResponse),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isNoButtonVisible = false; // Hide the "No" button after it's pressed
                });
                Navigator.pop(context);
              },
              child: Text("ok"),
            ),
          ],
        );
      },
    );
  }

  void _onYesPressed() {
    String yesResponse = _questions[_currentQuestionIndex]['yes'] ?? "Moving to the next step!";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Anta seen ledu brooooo"),
          content: Text(yesResponse),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog and go to the next question
                _nextQuestion();
              },
              child: Text("next.."),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                question["question"]!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: question["yes"] == "Here's the song 🎶" ? _onYesPressed : _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      question["yes"]!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(width: 20),
                  Visibility(
                    visible: _isNoButtonVisible,
                    child: ElevatedButton(
                      onPressed: _onNoPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class FinalWishScreen extends StatefulWidget {
  @override
  _FinalWishScreenState createState() => _FinalWishScreenState();
}

class _FinalWishScreenState extends State<FinalWishScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    // Initialize the confetti controller
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    _triggerConfetti();
  }

  @override
  void dispose() {
    // Dispose the confetti controller when the widget is destroyed
    _confettiController.dispose();
    super.dispose();
  }

  // Method to start the confetti animation
  void _triggerConfetti() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Stack(
        children: [
          // Confetti Widget
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 30,
              gravity: 0.1,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Add a festive header with an icon or title
                    Text(
                      'Happy Birthday, Superstar! 🎉🎂🎈',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                        fontFamily: 'Cursive',  // Use a cursive font for a fun, festive touch
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    // Add the birthday message
                    Text(
                      'Many more happy returns of the Suppu!! 🎉🎂🎈\n'
                      'You are one of the strongest girls I have ever seen.\n'
                      'Aa kopam, aa hard work, aa excitement—keep it going! 💪\n'
                      'You will surely make your mother proud! I believe in you! ❤️\n'
                      'Enjoy your special day, and haaa, konchem cake ivvu tinneyaka motammmm 🎂',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontFamily: 'Serif',  // A clean font for easy reading
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    // Add a fun button to trigger the confetti effect
                    ElevatedButton(
                      onPressed: () {
                        _triggerConfetti(); // Start the confetti effect
                        // Optionally, you can navigate to another screen or perform other actions here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Enjoy the Party! 🎉',
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}