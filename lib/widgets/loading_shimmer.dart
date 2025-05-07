import 'package:flutter/material.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: _buildShimmer(24.0, 150.0),
          subtitle: _buildShimmer(24.0, 50.0),
          trailing: _buildShimmer(30.0, 20.0),
        ),
        const Divider(
          color: Colors.blueAccent,
        )
      ],
    );
  }

  Widget _buildShimmer(double height, double widght) {
    return Container(
      color: Colors.grey[200],
      height: height,
      width: widght,
      margin: const EdgeInsets.only(
        bottom: 8.0,
        top: 8.0,
      ),
    );
  }
}
