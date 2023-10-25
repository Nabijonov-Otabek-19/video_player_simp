import 'package:flutter/material.dart';
import 'package:tdd_test/feature/video_player/presentation/pages/video_player/video_player_page.dart';

import '../pod_player/pod_player_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  late String inputUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter url",
              ),
              onChanged: (value) {
                inputUrl = value;
              },
              onSubmitted: (_) {
                // something
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // pod_player
              FilledButton(
                onPressed: () {
                  if (inputUrl.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PodPlayerPage(url: inputUrl),
                        ));

                    controller.clear();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.blue),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  fixedSize: MaterialStatePropertyAll(
                      Size(MediaQuery.of(context).size.width / 3, 50)),
                ),
                child: const Text(
                  "Pod player",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // video_player
              FilledButton(
                onPressed: () {
                  if (inputUrl.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(url: inputUrl),
                        ));

                    controller.clear();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.blue),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  fixedSize: MaterialStatePropertyAll(
                      Size(MediaQuery.of(context).size.width / 3, 50)),
                ),
                child: const Text(
                  "Video player",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
