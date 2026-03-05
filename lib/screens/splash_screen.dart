import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: navigateToLogin,
      child: Scaffold(
        backgroundColor: const Color(0xFFEAF2FF), // Ice Blue
        body: Stack(
          children: [

            /// 🔵 Top Left Curve
            Positioned(
              top: -80,
              left: -80,
              child: Container(
                height: 220,
                width: 220,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E3A8A),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            /// 🔵 Bottom Curve
            Positioned(
              bottom: -120,
              left: -100,
              right: -100,
              child: Container(
                height: 280,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E3A8A),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            /// 🎓 Center Logo + Title with Animation
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// Logo (Responsive Size)
                      Image.asset(
                        "assets/logo.png",
                        height: screenHeight * 0.20,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 25),

                      /// Title
                      const Text(
                        "School Management System",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E3A8A),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Tap to Continue Text
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Tap anywhere to continue",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
