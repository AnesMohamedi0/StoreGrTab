import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/ad.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:grtabstore/services/apiService.dart';

class Adspace extends StatefulWidget {
  final double height;
  const Adspace({super.key, required this.height});

  @override
  State<Adspace> createState() => _AdspaceState();
}

class _AdspaceState extends State<Adspace> {
  List<Ad> _ads = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  Timer? _autoAdvanceTimer;

  @override
  void initState() {
    super.initState();
    _fetchAds();
  }

  Future<void> _fetchAds() async {
    if (!mounted) return;

    try {
      final data = await apiService.get('Ads');
      if (data is List && data.isNotEmpty) {
        if (mounted) {
          // Add this check
          setState(() {
            _ads = data
                .map((item) => Ad.fromJson(item as Map<String, dynamic>))
                .toList();
            _isLoading = false;
          });
          _startAutoAdvance();
        }
      } else {
        if (mounted) {
          // Add this check
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching ads: $e');
      if (mounted) {
        // Add this check
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _startAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    if (_ads.length > 1 && mounted) {
      _autoAdvanceTimer = Timer(const Duration(seconds: 10), () {
        if (mounted) {
          // This check is crucial
          _nextAd();
        }
      });
    }
  }

  void _nextAd() {
    if (!mounted || _ads.isEmpty) return; // Add mounted check

    setState(() {
      _currentIndex = (_currentIndex + 1) % _ads.length;
    });
    _startAutoAdvance();
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel(); // Cancel timer before disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: widget.height,
        color: deepPurple,
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (_ads.isEmpty) {
      return SizedBox.shrink();
    }

    final currentAd = _ads[_currentIndex];

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
          // Background Image
          SizedBox(
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
                  )
                : Container(color: deepPurple),
          ),

          // Title
          Positioned(
            bottom: widget.height * 0.05,
            left: widget.height * 0.05,
            child: AbelText(
              text: currentAd.title,
              fontSize: widget.height * 0.1,
              color: currentAd.isDark ? textOnBlue : textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Page indicators
          if (_ads.length > 1)
            Positioned(
              bottom: widget.height * 0.02,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _ads.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(
                      horizontal: widget.height * 0.01,
                    ),
                    width: index == _currentIndex
                        ? widget.height * 0.10
                        : widget.height * 0.05,
                    height: widget.height * 0.05,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: textPrimary, width: 1.5),
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
