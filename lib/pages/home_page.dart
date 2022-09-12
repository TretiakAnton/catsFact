import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: 'https://cataas.com/cat',
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
            const SingleChildScrollView(),
            Row(
              children: [
                OutlinedButton(
                    onPressed: onPressed, child: const Text('Another fact!')),
                OutlinedButton(
                    onPressed: onPressed, child: const Text('Fact History'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
