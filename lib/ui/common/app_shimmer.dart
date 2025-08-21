import 'package:flutter/material.dart';

class EventShimmerLoader extends StatefulWidget {
  const EventShimmerLoader({Key? key}) : super(key: key);

  @override
  State<EventShimmerLoader> createState() => _EventShimmerLoaderState();
}

class _EventShimmerLoaderState extends State<EventShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image Shimmer
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                ),
                child: Stack(
                  children: [
                    // Shimmer effect for image
                    _buildShimmerGradient(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                    // Header buttons
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildShimmerGradient(
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 20,
                              ),
                            ),
                            _buildShimmerGradient(
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Content Shimmer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title shimmer
                    _buildShimmerGradient(
                      child: Container(
                        height: 32,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildShimmerGradient(
                      child: Container(
                        height: 24,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Info cards shimmer
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildShimmerGradient(
                            child: Container(
                              height: 92,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 5,
                          child: _buildShimmerGradient(
                            child: Container(
                              height: 92,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Second row of info cards
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildShimmerGradient(
                            child: Container(
                              height: 92,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 5,
                          child: _buildShimmerGradient(
                            child: Container(
                              height: 92,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Map shimmer
                    _buildShimmerGradient(
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Divider
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[700],
                    ),

                    const SizedBox(height: 20),

                    // About section title
                    _buildShimmerGradient(
                      child: Container(
                        height: 24,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description lines
                    Column(
                      children: List.generate(
                          4,
                          (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: _buildShimmerGradient(
                                  child: Container(
                                    height: 16,
                                    width: index == 3
                                        ? MediaQuery.of(context).size.width *
                                            0.7
                                        : double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              )),
                    ),

                    const SizedBox(height: 20),

                    // Divider
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[700],
                    ),

                    const SizedBox(height: 20),

                    // Who's going section
                    _buildShimmerGradient(
                      child: Container(
                        height: 24,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // User avatars
                    Row(
                      children: [
                        ...List.generate(
                            4,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: _buildShimmerGradient(
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                )),
                        const SizedBox(width: 12),
                        _buildShimmerGradient(
                          child: Container(
                            height: 16,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Button shimmer
                    _buildShimmerGradient(
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerGradient({required Widget child}) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            Colors.grey[800]!,
            Colors.grey[600]!,
            Colors.grey[800]!,
          ],
          stops: const [0.1, 0.3, 0.4],
          begin: Alignment(-1.0 - _animation.value, -0.3),
          end: Alignment(1.0 - _animation.value, 0.3),
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
