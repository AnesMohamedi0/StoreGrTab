import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/ad.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class Adspace extends StatefulWidget {
  final List<Ad> ads;
  final double height;
  const Adspace({super.key, required this.ads, required this.height});

  @override
  State<Adspace> createState() => _AdspaceState();
}

class _AdspaceState extends State<Adspace> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start the animation
    _fadeController.forward();

    // Auto-advance ads every 5 seconds
    if (widget.ads.length > 1) {
      _startAutoAdvance();
    }
  }

  void _startAutoAdvance() {
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        _nextAd();
      }
    });
  }

  void _nextAd() {
    if (widget.ads.isEmpty) return;

    _fadeController.reverse().then((_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.ads.length;
      });
      _fadeController.forward().then((_) {
        if (mounted) {
          _startAutoAdvance();
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ads.isEmpty) {
      return Container(
        height: widget.height,
        width: double.infinity,
        color: deepPurple,
        child: Center(
          child: Text(
            'No ads available',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final currentAd = widget.ads[_currentIndex];

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: electricBlueDarkest, width: 2.5),
        ),
        color: deepPurple,
      ),
      child: Stack(
        children: [
          // Background Image with fade animation
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: currentAd.imageUrl != null
                      ? Image.network(
                          currentAd.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: deepPurple,
                              child: Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                  size: widget.height * 0.2,
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: deepPurple,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(color: deepPurple),
                ),
              );
            },
          ),

          // Title with fade animation
          Positioned(
            bottom: widget.height * 0.05,
            left: widget.height * 0.05,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: TitlesText(
                    text: currentAd.title,
                    fontSize: widget.height * 0.15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Open button with fade animation
          Positioned(
            bottom: widget.height * 0.05,
            right: widget.height * 0.05,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: IconButton(
                    onPressed: () {
                      // Handle ad click - open link
                      if (currentAd.link != null) {
                        // Add URL launcher functionality here
                        print('Opening: ${currentAd.link}');
                      }
                    },
                    icon: Icon(
                      Icons.open_in_new_rounded,
                      color: Colors.white,
                      size: widget.height * 0.15,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Page indicators (dots)
          if (widget.ads.length > 1)
            Positioned(
              bottom: widget.height * 0.02,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.ads.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == _currentIndex ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == _currentIndex
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
