import 'package:flutter/material.dart';

class NetworkImageWithPlaceholder extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget placeholder;
  final Widget errorWidget;
  final BorderRadius borderRadius;

  const NetworkImageWithPlaceholder({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder = const _DefaultPlaceholder(),
    this.errorWidget = const _DefaultErrorWidget(),
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      child: placeholder,
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
      ),
      child: errorWidget,
    );
  }
}

class _DefaultPlaceholder extends StatelessWidget {
  const _DefaultPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.grey,
        strokeWidth: 2,
      ),
    );
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  const _DefaultErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.broken_image,
        color: Colors.grey,
        size: 40,
      ),
    );
  }
}
