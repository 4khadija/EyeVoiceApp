import 'dart:math';
import 'dart:html' as html;
import 'package:flutter/material.dart';

void main() {
  runApp(EyeVoiceApp());
}

const Color kSoftBlue = Color(0xFFA2D2FF);
const Color kLightBg = Color(0xFFF6F9FF);

class EyeVoiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EyeVoice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kSoftBlue,
        scaffoldBackgroundColor: kLightBg,
        appBarTheme: AppBarTheme(
          backgroundColor: kSoftBlue,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kSoftBlue,
            foregroundColor: Colors.black87,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

// === SPLASH SCREEN ===
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
    )..forward();
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: FadeTransition(
        opacity: _fade,
        child: Center(
          child: ScaleTransition(
            scale: _scale,
            child: Text(
              "EyeVoice",
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.4,
                decoration: TextDecoration.none,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4),
                    blurRadius: 12,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// === ANIMATED GRADIENT BACKGROUND ===
class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  const AnimatedGradientBackground({required this.child});
  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 8))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final angle = _controller.value * 2 * pi;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-cos(angle), -sin(angle)),
              end: Alignment(cos(angle), sin(angle)),
              colors: [
                kSoftBlue.withOpacity(0.30 + 0.15 * sin(angle)),
                Color(0xFFD4E4FF).withOpacity(0.50 + 0.10 * cos(angle)),
                Colors.white.withOpacity(0.85 + 0.10 * sin(angle)),
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

// === HOME PAGE ===
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset1, _offset2, _offset3, _offset4, _offset5, _offset6;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 900));
    _offset1 = Tween<Offset>(begin: Offset(-1.0, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _offset2 = Tween<Offset>(begin: Offset(1.0, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _offset3 = Tween<Offset>(begin: Offset(-1.0, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _offset4 = Tween<Offset>(begin: Offset(1.0, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _offset5 = Tween<Offset>(begin: Offset(-1.0, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _offset6 = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EyeVoice")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChatbotPage()),
        ),
        icon: Icon(Icons.chat_bubble_outline),
        label: Text("Help"),
        backgroundColor: kSoftBlue,
        foregroundColor: Colors.black87,
      ),
      body: AnimatedGradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Accessibility Tools",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 40),
              SlideTransition(
                position: _offset1,
                child: FeatureButton(
                  icon: Icons.camera_alt,
                  title: "Visual Simplifier",
                  description: "Scan text, simplify words, hear it aloud",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => VisualSimplifierPage()),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _offset2,
                child: FeatureButton(
                  icon: Icons.people,
                  title: "Companion Mode",
                  description: "Link caregiver accounts & alerts",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CompanionModePage()),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _offset3,
                child: FeatureButton(
                  icon: Icons.mic,
                  title: "Voice Assistant",
                  description: "Speech-to-text and text-to-speech",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => VoiceAssistantPage()),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _offset4,
                child: FeatureButton(
                  icon: Icons.timer,
                  title: "Timed Reading Assistant",
                  description: "Read at your pace with pause controls",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TimedReadingPage()),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _offset5,
                child: FeatureButton(
                  icon: Icons.summarize,
                  title: "Smart Summarizer",
                  description: "Get quick summaries of long text",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SummarizerPage()),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _offset6,
                child: FeatureButton(
                  icon: Icons.link,
                  title: "Visit Website",
                  description: "Learn more about EyeVoice online",
                  onTap: () async {
                    final Uri websiteUrl = Uri.parse('https://jolly-monstera-18c267.netlify.app/');
                    try {
                      // For web/Zapp environment
                      html.window.open(websiteUrl.toString(), '_blank');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Opening EyeVoice website...")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Website: https://jolly-monstera-18c267.netlify.app/")),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 80), // Space for floating button
            ],
          ),
        ),
      ),
    );
  }
}

// === FEATURE BUTTON WIDGET ===
class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const FeatureButton({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: kSoftBlue),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(description,
                        style: TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === VISUAL SIMPLIFIER PAGE ===
class VisualSimplifierPage extends StatefulWidget {
  @override
  _VisualSimplifierPageState createState() => _VisualSimplifierPageState();
}

class _VisualSimplifierPageState extends State<VisualSimplifierPage> {
  String _recognizedText = "Tap 'Scan Text' to capture and simplify words.";
  bool _isProcessing = false;

  Future<void> _scanAndSimplify() async {
    setState(() => _isProcessing = true);

    await Future.delayed(Duration(seconds: 2));

    String mockText = """
The comprehensive documentation indicates that individuals 
should utilize appropriate assistance to obtain necessary 
information about the program.
""";

    String simplified = _simplifyText(mockText);

    setState(() {
      _recognizedText = "Original:\n$mockText\n\nSimplified:\n$simplified";
      _isProcessing = false;
    });
  }

  String _simplifyText(String text) {
    Map<String, String> simpleWords = {
      "comprehensive": "complete",
      "documentation": "papers",
      "indicates": "shows",
      "individuals": "people",
      "utilize": "use",
      "appropriate": "right",
      "assistance": "help",
      "obtain": "get",
      "necessary": "needed",
      "information": "facts",
    };

    simpleWords.forEach((complex, simple) {
      text = text.replaceAll(
          RegExp("\\b$complex\\b", caseSensitive: false), simple);
    });

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Visual Simplifier")),
      body: AnimatedGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: _scanAndSimplify,
                icon: Icon(Icons.camera_alt),
                label: Text("Scan Text (Mock OCR)"),
              ),
              SizedBox(height: 24),
              if (_isProcessing)
                CircularProgressIndicator()
              else
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _recognizedText,
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// === COMPANION MODE PAGE ===
class CompanionModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Companion Mode")),
      body: AnimatedGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              Text(
                "Linked Accounts",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _AccountCard(
                name: "Alex (User)",
                subtitle: "Dyslexia Mode Enabled",
                icon: Icons.person,
              ),
              SizedBox(height: 12),
              _AccountCard(
                name: "Sam (Caregiver)",
                subtitle: "Receives alerts & reminders",
                icon: Icons.supervisor_account,
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                icon: Icon(Icons.notifications),
                label: Text("Send Demo Alert"),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Demo alert sent to caregiver!")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final IconData icon;

  const _AccountCard(
      {required this.name, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kSoftBlue,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

// === VOICE ASSISTANT PAGE ===
class VoiceAssistantPage extends StatefulWidget {
  @override
  _VoiceAssistantPageState createState() => _VoiceAssistantPageState();
}

class _VoiceAssistantPageState extends State<VoiceAssistantPage> {
  String _text = "Tap mic to speak or enter text below...";
  TextEditingController _controller = TextEditingController();
  bool _isSpeaking = false;

  void _speakText() async {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter some text first!")),
      );
      return;
    }

    setState(() => _isSpeaking = true);

    try {
      final utterance = html.SpeechSynthesisUtterance(_controller.text);
      utterance.rate = 0.9;
      utterance.pitch = 1.0;
      utterance.volume = 1.0;
      utterance.lang = 'en-US';

      html.window.speechSynthesis!.speak(utterance);

      await Future.delayed(Duration(seconds: _controller.text.length ~/ 10 + 2));

      setState(() => _isSpeaking = false);
    } catch (e) {
      setState(() => _isSpeaking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Speech not supported in this browser")),
      );
    }
  }

  void _mockListen() {
    setState(() {
      _text = "Mock: You said 'Hello EyeVoice, read this for me.'";
      _controller.text = "Hello EyeVoice, read this for me.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Voice Assistant")),
      body: AnimatedGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              IconButton(
                iconSize: 80,
                icon: Icon(Icons.mic, color: kSoftBlue),
                onPressed: _mockListen,
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Type text to hear aloud",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
                maxLines: 3,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: _isSpeaking
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(Icons.volume_up, size: 28),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _isSpeaking ? "Speaking..." : "Read Aloud",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: _isSpeaking ? null : _speakText,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === TIMED READING ASSISTANT PAGE ===
class TimedReadingPage extends StatefulWidget {
  @override
  _TimedReadingPageState createState() => _TimedReadingPageState();
}

class _TimedReadingPageState extends State<TimedReadingPage> {
  final TextEditingController _textController = TextEditingController();
  List<String> _sentences = [];
  int _currentIndex = 0;
  bool _isReading = false;
  bool _isPaused = false;

  void _loadText() {
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter some text first!")),
      );
      return;
    }

    setState(() {
      _sentences = _textController.text
          .split(RegExp(r'[.!?]+'))
          .where((s) => s.trim().isNotEmpty)
          .map((s) => s.trim())
          .toList();
      _currentIndex = 0;
      _isReading = false;
      _isPaused = false;
    });
  }

  void _startReading() {
    if (_sentences.isEmpty) return;
    setState(() => _isReading = true);
    _readNext();
  }

  void _readNext() async {
    if (!_isReading || _isPaused || _currentIndex >= _sentences.length) return;

    String sentence = _sentences[_currentIndex];

    try {
      final utterance = html.SpeechSynthesisUtterance(sentence);
      utterance.rate = 0.8;
      utterance.pitch = 1.0;
      utterance.volume = 1.0;
      utterance.lang = 'en-US';

      html.window.speechSynthesis!.speak(utterance);

      await Future.delayed(Duration(seconds: sentence.length ~/ 8 + 2));

      if (mounted && _isReading && !_isPaused) {
        setState(() => _currentIndex++);
        if (_currentIndex < _sentences.length) {
          await Future.delayed(Duration(seconds: 1)); // Pause between sentences
          _readNext();
        } else {
          setState(() => _isReading = false);
        }
      }
    } catch (e) {
      setState(() => _isReading = false);
    }
  }

  void _pauseReading() {
    setState(() => _isPaused = true);
    html.window.speechSynthesis!.cancel();
  }

  void _resumeReading() {
    setState(() => _isPaused = false);
    _readNext();
  }

  void _stopReading() {
    setState(() {
      _isReading = false;
      _isPaused = false;
      _currentIndex = 0;
    });
    html.window.speechSynthesis!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timed Reading Assistant")),
      body: AnimatedGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "Paste your text here to read at your pace...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                ),
                maxLines: 6,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.upload_file),
                label: Text("Load Text"),
                onPressed: _loadText,
              ),
              SizedBox(height: 24),
              if (_sentences.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Sentence ${_currentIndex + 1} of ${_sentences.length}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Text(
                        _currentIndex < _sentences.length
                            ? _sentences[_currentIndex]
                            : "Finished!",
                        style: TextStyle(fontSize: 18, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!_isReading)
                      ElevatedButton.icon(
                        icon: Icon(Icons.play_arrow),
                        label: Text("Start"),
                        onPressed: _startReading,
                      ),
                    if (_isReading && !_isPaused)
                      ElevatedButton.icon(
                        icon: Icon(Icons.pause),
                        label: Text("Pause"),
                        onPressed: _pauseReading,
                      ),
                    if (_isReading && _isPaused)
                      ElevatedButton.icon(
                        icon: Icon(Icons.play_arrow),
                        label: Text("Resume"),
                        onPressed: _resumeReading,
                      ),
                    if (_isReading)
                      ElevatedButton.icon(
                        icon: Icon(Icons.stop),
                        label: Text("Stop"),
                        onPressed: _stopReading,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade300,
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// === SMART SUMMARIZER PAGE ===
class SummarizerPage extends StatefulWidget {
  @override
  _SummarizerPageState createState() => _SummarizerPageState();
}

class _SummarizerPageState extends State<SummarizerPage> {
  final TextEditingController _textController = TextEditingController();
  String _summary = "";
  bool _isProcessing = false;

  void _summarizeText() async {
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter some text to summarize!")),
      );
      return;
    }

    setState(() => _isProcessing = true);

    await Future.delayed(Duration(seconds: 2));

    // Simple extractive summarization (mock)
    String fullText = _textController.text;
    List<String> sentences = fullText
        .split(RegExp(r'[.!?]+'))
        .where((s) => s.trim().isNotEmpty)
        .map((s) => s.trim())
        .toList();

    // Take first and last sentence as summary (simple mock)
    String summary = sentences.length > 2
        ? "${sentences.first}. ... ${sentences.last}."
        : fullText;

    setState(() {
      _summary = "📝 Summary:\n\n$summary\n\n✨ Key Points:\n"
          "• ${sentences.length} sentences total\n"
          "• Simplified for easier understanding\n"
          "• Main ideas captured";
      _isProcessing = false;
    });
  }

  void _speakSummary() {
    if (_summary.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No summary to read!")),
      );
      return;
    }

    try {
      final utterance = html.SpeechSynthesisUtterance(_summary);
      utterance.lang = 'en-US';
      utterance.rate = 0.9;
      utterance.pitch = 1.0;
      utterance.volume = 1.0;

      html.window.speechSynthesis!.speak(utterance);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reading summary aloud...")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Speech not supported in this browser.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Summarizer")),
      body: AnimatedGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "Paste long text here to get a summary...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                ),
                maxLines: 8,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.summarize),
                    label: Text("Summarize"),
                    onPressed: _summarizeText,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.volume_up),
                    label: Text("Speak"),
                    onPressed: _summary.isNotEmpty ? _speakSummary : null,
                  ),
                ],
              ),
              SizedBox(height: 24),
              if (_isProcessing)
                CircularProgressIndicator()
              else if (_summary.isNotEmpty)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _summary,
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// === CHATBOT PAGE ===
class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addBotMessage(
      "👋 Hi! I'm your EyeVoice assistant. I'm here to help you navigate the app!\n\n"
      "You can ask me about:\n"
      "• Visual Simplifier\n"
      "• Companion Mode\n"
      "• Voice Assistant\n"
      "• Timed Reading\n"
      "• Smart Summarizer\n\n"
      "What would you like to know?"
    );
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: false));
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text.trim().isEmpty) return;

    _addUserMessage(text);

    Future.delayed(Duration(milliseconds: 500), () {
      String response = _getResponse(text.toLowerCase());
      _addBotMessage(response);
    });
  }

  String _getResponse(String input) {
    if (input.contains('visual') || input.contains('simplif') || input.contains('scan')) {
      return "📸 Visual Simplifier:\n\nThis feature helps you read printed text!\n\n"
          "1. Tap 'Visual Simplifier' on the home screen\n"
          "2. Click 'Scan Text' to capture text\n"
          "3. The app will simplify complex words\n"
          "4. Listen to the simplified version\n\n"
          "Perfect for reading documents with easier words!";
    } else if (input.contains('companion') || input.contains('caregiver')) {
      return "👥 Companion Mode:\n\nConnect with your caregiver or family!\n\n"
          "1. Go to 'Companion Mode'\n"
          "2. Link accounts together\n"
          "3. Share reminders and alerts\n"
          "4. Caregivers can monitor your activity\n\n"
          "Great for staying connected with loved ones!";
    } else if (input.contains('voice') || input.contains('speak') || input.contains('assistant')) {
      return "🎙️ Voice Assistant:\n\nSpeak or type to hear text read aloud!\n\n"
          "1. Tap the microphone to speak\n"
          "2. Or type text in the box\n"
          "3. Click 'Read Aloud' to hear it\n"
          "4. Adjust speed and volume as needed\n\n"
          "Helpful for reading text hands-free!";
    } else if (input.contains('timed') || input.contains('reading') || input.contains('pace')) {
      return "⏱️ Timed Reading Assistant:\n\nRead at your own pace!\n\n"
          "1. Paste or type your text\n"
          "2. Click 'Load Text'\n"
          "3. Use Play/Pause/Stop controls\n"
          "4. It reads sentence by sentence\n\n"
          "Perfect for studying and comprehension!";
    } else if (input.contains('summar') || input.contains('condense')) {
      return "📝 Smart Summarizer:\n\nGet quick summaries of long text!\n\n"
          "1. Paste your long text\n"
          "2. Click 'Summarize'\n"
          "3. Get key points instantly\n"
          "4. Save time and focus better\n\n"
          "Great for articles and documents!";
    } else if (input.contains('help') || input.contains('how') || input.contains('use')) {
      return "ℹ️ Here's what EyeVoice can do:\n\n"
          "🔹 Visual Simplifier - Read & simplify text\n"
          "🔹 Companion Mode - Connect with caregivers\n"
          "🔹 Voice Assistant - Text-to-speech\n"
          "🔹 Timed Reading - Read at your pace\n"
          "🔹 Smart Summarizer - Quick summaries\n\n"
          "Just ask me about any feature!";
    } else if (input.contains('thank') || input.contains('thanks')) {
      return "😊 You're welcome! I'm here anytime you need help. Feel free to ask me anything!";
    } else if (input.contains('hello') || input.contains('hi')) {
      return "👋 Hello! How can I help you today?";
    } else {
      return "🤔 I'm not sure about that, but I can help you with:\n\n"
          "• Visual Simplifier\n"
          "• Companion Mode\n"
          "• Voice Assistant\n"
          "• Timed Reading\n"
          "• Smart Summarizer\n\n"
          "What would you like to know?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Assistant"),
        backgroundColor: kSoftBlue,
      ),
      body: AnimatedGradientBackground(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _ChatBubble(message: _messages[index]);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Ask me anything...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: kSoftBlue,
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () => _handleSubmitted(_textController.text),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser)
            CircleAvatar(
              backgroundColor: kSoftBlue,
              child: Icon(Icons.support_agent, color: Colors.white, size: 20),
              radius: 16,
            ),
          if (!message.isUser) SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? kSoftBlue.withOpacity(0.8)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 15,
                  color: message.isUser ? Colors.white : Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (message.isUser) SizedBox(width: 8),
          if (message.isUser)
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.grey[700], size: 20),
              radius: 16,
            ),
        ],
      ),
    );
  }
}
